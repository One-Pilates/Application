package com.onePilates.agendamento.validator;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Component
public class AgendamentoValidator {

    private static final Logger logger = LoggerFactory.getLogger(AgendamentoValidator.class);

    private final SalaRepository salaRepository;
    private final ProfessorRepository professorRepository;
    private final EspecialidadeRepository especialidadeRepository;
    private final AlunoRepository alunoRepository;
    private final AusenciaRepository ausenciaRepository;
    private final AgendamentoRepository agendamentoRepository;

    public AgendamentoValidator(
            SalaRepository salaRepository,
            ProfessorRepository professorRepository,
            EspecialidadeRepository especialidadeRepository,
            AlunoRepository alunoRepository,
            AusenciaRepository ausenciaRepository,
            AgendamentoRepository agendamentoRepository
    ) {
        this.salaRepository = salaRepository;
        this.professorRepository = professorRepository;
        this.especialidadeRepository = especialidadeRepository;
        this.alunoRepository = alunoRepository;
        this.ausenciaRepository = ausenciaRepository;
        this.agendamentoRepository = agendamentoRepository;
    }

    /**
     * Valida todas as regras de negócio para um agendamento.
     * 
     * @param dto DTO contendo os dados do agendamento a ser validado
     * @throws BusinessException se alguma validação falhar
     */
    public void validar(AgendamentoDTO dto) {
        logger.debug("Iniciando validação de agendamento para data/hora: {}", dto.getDataHora());

        LocalDateTime dataHora = dto.getDataHora();

        Sala sala = salaRepository.findById(dto.getSalaId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Sala não encontrada"));

        Professor professor = professorRepository.findById(dto.getProfessorId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Professor não encontrado"));

        Especialidade especialidade = especialidadeRepository.findById(dto.getEspecialidadeId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Especialidade não encontrada"));

        List<Aluno> alunos = alunoRepository.findAllById(dto.getAlunoIds());
        if (alunos.size() != dto.getAlunoIds().size()) {
            throw new EntidadeNaoEncontradaException("Um ou mais alunos não foram encontrados");
        }

        // Validações básicas de conflito
        validarConflitosBasicos(dto, dataHora, alunos);

        // Validações de regras de negócio
        validarLotacaoSala(sala, alunos.size());
        validarEquipamentosPCD(sala, alunos);
        validarAusenciaProfessor(professor, dataHora);
        validarStatusAluno(alunos);
        validarStatusProfessor(professor);
        validarEspecialidadeSala(sala, especialidade);
        validarEspecialidadeProfessor(professor, especialidade);

        logger.debug("Validação de agendamento concluída com sucesso");
    }

    private void validarConflitosBasicos(AgendamentoDTO dto, LocalDateTime dataHora, List<Aluno> alunos) {
        if (agendamentoRepository.existsBySalaIdAndDataHora(dto.getSalaId(), dataHora)) {
            throw new ConflitoHorarioException("Sala indisponível para o horário agendado.");
        }

        if (agendamentoRepository.existsByProfessorIdAndDataHora(dto.getProfessorId(), dataHora)) {
            throw new ConflitoHorarioException("Professor indisponível para o horário agendado.");
        }

        // Validar conflito de alunos
        List<String> nomesIndisponiveis = alunos.stream()
                .filter(aluno -> !agendamentoRepository.findAgendamentosByAlunoAndDataHora(aluno, dataHora).isEmpty())
                .map(Aluno::getNome)
                .toList();

        if (!nomesIndisponiveis.isEmpty()) {
            throw new ConflitoHorarioException("Alunos indisponíveis para o horário: " + String.join(", ", nomesIndisponiveis));
        }
    }

    private void validarLotacaoSala(Sala sala, int quantidadeAlunos) {
        if (quantidadeAlunos > sala.getQuantidadeMaximaAlunos()) {
            logger.warn("Tentativa de agendar {} alunos em sala que suporta apenas {}", quantidadeAlunos, sala.getQuantidadeMaximaAlunos());
            throw new SalaLotadaException(
                String.format("A sala %s suporta no máximo %d alunos, mas foram solicitados %d alunos.",
                    sala.getNome(),
                    sala.getQuantidadeMaximaAlunos(),
                    quantidadeAlunos)
            );
        }
    }

    private void validarEquipamentosPCD(Sala sala, List<Aluno> alunos) {
        long alunosComLimitacoes = alunos.stream()
            .filter(aluno -> Boolean.TRUE.equals(aluno.getAlunoComLimitacoesFisicas()))
            .count();

        if (alunosComLimitacoes > sala.getQuantidadeEquipamentosPCD()) {
            logger.warn("Tentativa de agendar {} alunos com limitações em sala com apenas {} equipamentos PCD",
                    alunosComLimitacoes, sala.getQuantidadeEquipamentosPCD());
            throw new EquipamentoPCDInsuficienteException(
                String.format("A sala %s possui apenas %d equipamentos PCD, mas %d alunos com limitações físicas foram agendados.",
                    sala.getNome(),
                    sala.getQuantidadeEquipamentosPCD(),
                    alunosComLimitacoes)
            );
        }
    }

    private void validarAusenciaProfessor(Professor professor, LocalDateTime dataHora) {
        List<Ausencia> ausencias = ausenciaRepository.findByProfessorId(professor.getId());

        boolean professorAusente = ausencias.stream()
            .anyMatch(ausencia -> {
                LocalDateTime inicio = ausencia.getDataInicio();
                LocalDateTime fim = ausencia.getDataFim();

                // Verificar se dataHora está dentro do período de ausência
                if (inicio != null && fim != null) {
                    return (dataHora.isEqual(inicio) || dataHora.isAfter(inicio)) 
                        && (dataHora.isEqual(fim) || dataHora.isBefore(fim));
                }

                // Se não há data específica, verificar dia da semana
                if (ausencia.getDiaSemanaInicio() != null && ausencia.getDiaSemanaFim() != null) {
                    DayOfWeek diaAgendamento = dataHora.getDayOfWeek();
                    DiaSemana diaSemanaAgendamento = mapearDayOfWeekParaDiaSemana(diaAgendamento);
                    return estaNoIntervaloDiasSemana(
                        diaSemanaAgendamento,
                        ausencia.getDiaSemanaInicio(),
                        ausencia.getDiaSemanaFim()
                    );
                }

                return false;
            });

        if (professorAusente) {
            logger.warn("Tentativa de agendar com professor {} que está ausente no horário {}", professor.getNome(), dataHora);
            throw new ProfessorAusenteException(
                String.format("O professor %s está ausente no horário agendado (%s).",
                    professor.getNome(),
                    dataHora.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")))
            );
        }
    }

    private void validarStatusAluno(List<Aluno> alunos) {
        List<String> alunosInativos = alunos.stream()
            .filter(aluno -> Boolean.FALSE.equals(aluno.getStatus()))
            .map(Aluno::getNome)
            .toList();

        if (!alunosInativos.isEmpty()) {
            logger.warn("Tentativa de agendar alunos inativos: {}", String.join(", ", alunosInativos));
            throw new AlunoInativoException(
                "Não é possível agendar alunos inativos: " + String.join(", ", alunosInativos)
            );
        }
    }

    private void validarStatusProfessor(Professor professor) {
        if (Boolean.FALSE.equals(professor.getStatus())) {
            logger.warn("Tentativa de agendar com professor inativo: {}", professor.getNome());
            throw new ProfessorInativoException(
                "Não é possível agendar com professor inativo: " + professor.getNome()
            );
        }
    }

    private void validarEspecialidadeSala(Sala sala, Especialidade especialidade) {
        boolean salaSuportaEspecialidade = sala.getEspecialidades().stream()
            .anyMatch(esp -> esp.getId().equals(especialidade.getId()));

        if (!salaSuportaEspecialidade) {
            logger.warn("Tentativa de agendar especialidade {} em sala {} que não a suporta", especialidade.getNome(), sala.getNome());
            throw new EspecialidadeIncompativelException(
                String.format("A sala %s não suporta a especialidade %s.",
                    sala.getNome(),
                    especialidade.getNome())
            );
        }
    }

    private void validarEspecialidadeProfessor(Professor professor, Especialidade especialidade) {
        boolean professorLecionaEspecialidade = professor.getEspecialidades().stream()
            .anyMatch(esp -> esp.getId().equals(especialidade.getId()));

        if (!professorLecionaEspecialidade) {
            logger.warn("Tentativa de agendar especialidade {} com professor {} que não a leciona", 
                    especialidade.getNome(), professor.getNome());
            throw new EspecialidadeIncompativelException(
                String.format("O professor %s não leciona a especialidade %s.",
                    professor.getNome(),
                    especialidade.getNome())
            );
        }
    }

    private DiaSemana mapearDayOfWeekParaDiaSemana(DayOfWeek dayOfWeek) {
        return switch (dayOfWeek) {
            case MONDAY -> DiaSemana.SEGUNDA;
            case TUESDAY -> DiaSemana.TERCA;
            case WEDNESDAY -> DiaSemana.QUARTA;
            case THURSDAY -> DiaSemana.QUINTA;
            case FRIDAY -> DiaSemana.SEXTA;
            case SATURDAY -> DiaSemana.SABADO;
            case SUNDAY -> DiaSemana.DOMINGO;
        };
    }

    private boolean estaNoIntervaloDiasSemana(DiaSemana dia, DiaSemana inicio, DiaSemana fim) {
        Map<DiaSemana, Integer> ordem = Map.of(
            DiaSemana.SEGUNDA, 1,
            DiaSemana.TERCA, 2,
            DiaSemana.QUARTA, 3,
            DiaSemana.QUINTA, 4,
            DiaSemana.SEXTA, 5,
            DiaSemana.SABADO, 6,
            DiaSemana.DOMINGO, 7
        );

        int diaNum = ordem.get(dia);
        int inicioNum = ordem.get(inicio);
        int fimNum = ordem.get(fim);

        if (inicioNum <= fimNum) {
            return diaNum >= inicioNum && diaNum <= fimNum;
        } else {
            // Intervalo que cruza o fim de semana (ex: SEXTA a SEGUNDA)
            return diaNum >= inicioNum || diaNum <= fimNum;
        }
    }
}

