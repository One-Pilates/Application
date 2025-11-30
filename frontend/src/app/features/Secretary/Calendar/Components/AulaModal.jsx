import React, { useState, useEffect } from "react";
import { FiEdit2, FiX, FiPlus, FiTrash2 } from "react-icons/fi";
import AlunoItem from "./AlunoItem";
import api from "../../../../../provider/api";
import Swal from 'sweetalert2';
import "../Styles/Modal.scss";

const AgendamentoModal = ({ isOpen, agendamento, onClose }) => {
  const [activeTab, setActiveTab] = useState("informacoes");
  const [editFields, setEditFields] = useState({});
  const [professores, setProfessores] = useState([]);
  const [especialidades, setEspecialidades] = useState([]);
  const [salas, setSalas] = useState([]);
  const [todosAlunos, setTodosAlunos] = useState([]);
  const [alunosSelecionados, setAlunosSelecionados] = useState([]);
  const [alunoParaAdicionar, setAlunoParaAdicionar] = useState("");

  useEffect(() => {
    if (editFields.professor !== undefined) {
      api.get("/api/professores").then(res => setProfessores(res.data || []));
    }
    if (editFields.especialidade !== undefined) {
      api.get("/api/especialidades").then(res => setEspecialidades(res.data || []));
    }
    if (editFields.sala !== undefined) {
      api.get("/api/salas").then(res => setSalas(res.data || []));
    }
  }, [editFields]);

  useEffect(() => {
    if (activeTab === "alunos" && todosAlunos.length === 0) {
      api.get("/api/alunos")
        .then(res => setTodosAlunos(res.data || []))
        .catch(err => console.error("Erro ao carregar alunos:", err));
    }
  }, [activeTab, todosAlunos.length]);

  useEffect(() => {
    if (agendamento?.alunos) {
      setAlunosSelecionados(agendamento.alunos.map(a => ({
        id: a.id || 0,
        nome: a.nome
      })));
    }
  }, [agendamento]);

  if (!isOpen || !agendamento) return null;

  const formatTime = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
  };

  const handleClose = () => {
    setActiveTab("informacoes");
    setEditFields({});
    setAlunosSelecionados(agendamento?.alunos?.map(a => ({
      id: a.id || 0,
      nome: a.nome
    })) || []);
    setAlunoParaAdicionar("");
    onClose();
  };

  const handleAdicionarAluno = () => {
    if (!alunoParaAdicionar) return;

    const aluno = todosAlunos.find(a => a.id.toString() === alunoParaAdicionar);
    if (aluno && !alunosSelecionados.find(a => a.id === aluno.id)) {
      setAlunosSelecionados([...alunosSelecionados, { 
        id: aluno.id, 
        nome: aluno.nome
      }]);
      setAlunoParaAdicionar("");
    }
  };

  const handleRemoverAluno = (alunoId) => {
    setAlunosSelecionados(alunosSelecionados.filter(a => a.id !== alunoId));
  };

  const handleSave = async () => {
    const result = await Swal.fire({
      title: 'Confirmar alteração?',
      text: 'Tem certeza que deseja salvar estas alterações?',
      icon: 'question',
      showCancelButton: true,
      confirmButtonText: 'Sim, salvar',
      cancelButtonText: 'Cancelar',
      reverseButtons: true
    });

    if (result.isConfirmed) {
      let patchData = {};

      if (editFields.horario !== undefined) {
        const dataAtual = new Date(agendamento.dataHora);
        const [horas, minutos] = editFields.horario.split(":");
        dataAtual.setHours(parseInt(horas), parseInt(minutos));
        patchData.dataHora = dataAtual.toISOString();
      }

      if (editFields.professor !== undefined) {
        const prof = professores.find((p) => p.nome === editFields.professor);
        if (prof) patchData.professorId = prof.id;
      }

      if (editFields.sala !== undefined) {
        const sala = salas.find((s) => s.nome === editFields.sala);
        if (sala) patchData.salaId = sala.id;
      }

      if (editFields.especialidade !== undefined) {
        const esp = especialidades.find((e) => e.nome === editFields.especialidade);
        if (esp) patchData.especialidadeId = esp.id;
      }

      if (editFields.observacoes !== undefined) {
        patchData.observacoes = editFields.observacoes;
      }

      const alunosOriginais = agendamento.alunos?.map(a => a.id) || [];
      const alunosAtuais = alunosSelecionados.map(a => a.id);
      
      const alunosMudaram = 
        alunosOriginais.length !== alunosAtuais.length ||
        !alunosOriginais.every(id => alunosAtuais.includes(id));

      if (alunosMudaram) {
        patchData.alunoIds = alunosSelecionados.map(a => a.id);
      }

      console.log('PATCH enviado para o backend:', patchData);

      try {
        await api.patch(`/api/agendamento/${agendamento.id}`, patchData);
        setEditFields({});
        Swal.fire('Alteração salva!', '', 'success');
        window.location.reload(); 
      } catch (e) {
        console.error('Erro ao salvar:', e);
        if (e.response) {
          console.error('Resposta do backend:', e.response);
          const errorMsg = e.response.data && typeof e.response.data === 'object' 
            ? JSON.stringify(e.response.data) 
            : e.response.data;
          Swal.fire('Erro ao salvar', `Erro do backend: ${errorMsg}`, 'error');
        } else {
          Swal.fire('Erro ao salvar', 'Tente novamente', 'error');
        }
      }
    }
  };

  const handleCancel = () => {
    setEditFields({});
    setAlunosSelecionados(agendamento?.alunos?.map(a => ({
      id: a.id || 0,
      nome: a.nome
    })) || []);
    setAlunoParaAdicionar("");
  };

  const alunosDisponiveis = todosAlunos.filter(
    aluno => !alunosSelecionados.find(a => a.id === aluno.id)
  );

  const alunosMudaram = 
    (agendamento.alunos?.length || 0) !== alunosSelecionados.length ||
    !agendamento.alunos?.every(a => alunosSelecionados.find(s => s.id === a.id));

  const temMudancas = Object.keys(editFields).length > 0 || alunosMudaram;

  return (
    <div className="modal-overlay" onClick={handleClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>
            {agendamento.especialidade} - {formatTime(agendamento.dataHora)}h
          </h2>
          <button className="modal-close" onClick={handleClose}>
            <FiX size={24} />
          </button>
        </div>

        <div className="modal-tabs">
          <button
            className={`modal-tab ${activeTab === "informacoes" ? "active" : ""}`}
            onClick={() => setActiveTab("informacoes")}
          >
            Informações
          </button>
          <button
            className={`modal-tab ${activeTab === "alunos" ? "active" : ""}`}
            onClick={() => setActiveTab("alunos")}
          >
            Alunos ({alunosSelecionados.length})
          </button>
        </div>

        <div className="modal-body">
          {activeTab === "informacoes" && (
            <div className="info-section">
              <div className="info-group">
                
                <div className="info-item">
                  <span className="info-label">Professor:</span>
                  <div className="info-content">
                    {editFields.professor !== undefined ? (
                      <select
                        className="info-edit-input"
                        value={editFields.professor}
                        onChange={e => setEditFields(fields => ({ ...fields, professor: e.target.value }))}
                      >
                        <option value="">Selecione</option>
                        {professores.map((p) => (
                          <option key={p.id} value={p.nome}>{p.nome}</option>
                        ))}
                      </select>
                    ) : (
                      <>
                        <span className="info-value">{agendamento.professor}</span>
                        <button
                          className="icon-btn"
                          onClick={() => setEditFields(fields => ({ ...fields, professor: agendamento.professor || "" }))}
                          title="Editar Professor"
                        >
                          <FiEdit2 size={16} />
                        </button>
                      </>
                    )}
                  </div>
                </div>

                <div className="info-item">
                  <span className="info-label">Horário:</span>
                  <div className="info-content">
                    {editFields.horario !== undefined ? (
                      <input
                        type="time"
                        className="info-edit-input"
                        value={editFields.horario}
                        onChange={e => setEditFields(fields => ({ ...fields, horario: e.target.value }))}
                      />
                    ) : (
                      <>
                        <span className="info-value">{formatTime(agendamento.dataHora)}</span>
                        <button
                          className="icon-btn"
                          onClick={() => setEditFields(fields => ({ ...fields, horario: agendamento.dataHora ? agendamento.dataHora.substring(11,16) : "" }))}
                          title="Editar Horário"
                        >
                          <FiEdit2 size={16} />
                        </button>
                      </>
                    )}
                  </div>
                </div>

                <div className="info-item">
                  <span className="info-label">Sala:</span>
                  <div className="info-content">
                    {editFields.sala !== undefined ? (
                      <select
                        className="info-edit-input"
                        value={editFields.sala}
                        onChange={e => setEditFields(fields => ({ ...fields, sala: e.target.value }))}
                      >
                        <option value="">Selecione</option>
                        {salas.map((s) => (
                          <option key={s.id} value={s.nome}>{s.nome}</option>
                        ))}
                      </select>
                    ) : (
                      <>
                        <span className="info-value">{agendamento.sala}</span>
                        <button
                          className="icon-btn"
                          onClick={() => setEditFields(fields => ({ ...fields, sala: agendamento.sala || "" }))}
                          title="Editar Sala"
                        >
                          <FiEdit2 size={16} />
                        </button>
                      </>
                    )}
                  </div>
                </div>

                <div className="info-item">
                  <span className="info-label">Especialidade:</span>
                  <div className="info-content">
                    {editFields.especialidade !== undefined ? (
                      <select
                        className="info-edit-input"
                        value={editFields.especialidade}
                        onChange={e => setEditFields(fields => ({ ...fields, especialidade: e.target.value }))}
                      >
                        <option value="">Selecione</option>
                        {especialidades.map((e) => (
                          <option key={e.id} value={e.nome}>{e.nome}</option>
                        ))}
                      </select>
                    ) : (
                      <>
                        <span className="info-value">{agendamento.especialidade}</span>
                        <button
                          className="icon-btn"
                          onClick={() => setEditFields(fields => ({ ...fields, especialidade: agendamento.especialidade || "" }))}
                          title="Editar Especialidade"
                        >
                          <FiEdit2 size={16} />
                        </button>
                      </>
                    )}
                  </div>
                </div>

                <div className="info-item">
                  <span className="info-label">Observações:</span>
                  <div className="info-content">
                    {editFields.observacoes !== undefined ? (
                      <textarea
                        className="info-edit-input"
                        value={editFields.observacoes}
                        onChange={e => setEditFields(fields => ({ ...fields, observacoes: e.target.value }))}
                        rows={3}
                      />
                    ) : (
                      <>
                        <span className="info-value">
                          {agendamento.observacoes && agendamento.observacoes.trim() !== ''
                            ? agendamento.observacoes
                            : 'Essa aula não possui observações.'}
                        </span>
                        <button
                          className="icon-btn"
                          onClick={() => setEditFields(fields => ({ ...fields, observacoes: agendamento.observacoes || "" }))}
                          title="Editar Observações"
                        >
                          <FiEdit2 size={16} />
                        </button>
                      </>
                    )}
                  </div>
                </div>

              </div>

              {temMudancas && (
                <div className="edit-actions">
                  <button className="btn-cancel" onClick={handleCancel}>
                    Cancelar
                  </button>
                  <button className="btn-save" onClick={handleSave}>
                    Salvar Alteração
                  </button>
                </div>
              )}
            </div>
          )}

          {activeTab === "alunos" && (
            <div className="alunos-section">
              <div className="adicionar-aluno-box">
                <div className="adicionar-aluno-label">Adicionar Aluno</div>
                <div className="adicionar-aluno-form">
                  <select
                    className="aluno-select"
                    value={alunoParaAdicionar}
                    onChange={(e) => setAlunoParaAdicionar(e.target.value)}
                  >
                    <option value="">Selecione um aluno</option>
                    {alunosDisponiveis.map((aluno) => (
                      <option key={aluno.id} value={aluno.id}>
                        {aluno.nome}
                      </option>
                    ))}
                  </select>
                  <button
                    className="btn-adicionar-aluno"
                    onClick={handleAdicionarAluno}
                    disabled={!alunoParaAdicionar}
                  >
                    <FiPlus size={16} /> Adicionar
                  </button>
                </div>
              </div>

              <div className="lista-alunos-label">
                Alunos na Aula ({alunosSelecionados.length})
              </div>
              {alunosSelecionados.length > 0 ? (
                <div className="lista-alunos">
                  {alunosSelecionados.map((aluno) => (
                    <div key={aluno.id} className="aluno-item-wrapper">
                      <AlunoItem nome={aluno.nome} />
                      <button
                        className="btn-remover-aluno"
                        onClick={() => handleRemoverAluno(aluno.id)}
                        title="Remover aluno"
                      >
                        <FiTrash2 size={14} />
                      </button>
                    </div>
                  ))}
                </div>
              ) : (
                <p style={{ textAlign: "center", color: "#888", padding: "2rem" }}>
                  Nenhum aluno neste agendamento.
                </p>
              )}

              {alunosMudaram && (
                <div className="edit-actions">
                  <button className="btn-cancel" onClick={handleCancel}>
                    Cancelar
                  </button>
                  <button className="btn-save" onClick={handleSave}>
                    Salvar Alteração
                  </button>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AgendamentoModal;