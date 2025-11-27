import { useState, useEffect } from "react";
import { FiActivity, FiUserX, FiUserCheck, FiUsers } from "react-icons/fi";
import { useAuth } from "../../../../hooks/useAuth";
import api from "../../../../provider/api";

export const useDashboardSecretaryModel = (period) => {
  const [kpis, setKpis] = useState([]);
  const [pie, setPie] = useState([]);
  const [frequencia, setFrequencia] = useState([]);
  const [totalAulas, setTotalAulas] = useState(0);
  const [top3, setTop3] = useState([]);
  const [loading, setLoading] = useState(false);
  const [hasData, setHasData] = useState(true);

  const { user } = useAuth();

  useEffect(() => {
    if (!user || !user.id) return;

    const fetchDashboardData = async () => {
      setLoading(true);

      try {
        const dias = period || 30;
        const endpoint = `api/secretarias/qtdUltimosDias/${dias}`;

        const { data } = await api.get(endpoint);

        const graficoDias = data.agendamentosPorDias || [];
        setFrequencia(graficoDias);

        const graficoProf = data.qtdSessoesPorProfessor || [];

        const pieData = graficoProf.map((p) => ({
          name: p.nomeProfessor,
          y: p.totalAgendamentosPorProfessor,
        }));

        setPie(pieData);

        const total = graficoProf.reduce(
          (sum, item) => sum + item.totalAgendamentosPorProfessor,
          0
        );

        setTotalAulas(total);

        let diaComMaiorAtendimento =
          graficoDias.length > 0
            ? graficoDias.reduce((a, b) =>
                a.totalAgendamentos > b.totalAgendamentos ? a : b
              ).diaSemana
            : "-";

        const diasPT = {
          Monday: "Segunda-feira",
          Tuesday: "Terça-feira",
          Wednesday: "Quarta-feira",
          Thursday: "Quinta-feira",
          Friday: "Sexta-feira",
          Saturday: "Sábado",
          Sunday: "Domingo",
        };

        diaComMaiorAtendimento = diasPT[diaComMaiorAtendimento] || "-";

        const especialidadeMaisRequisitada =
          graficoProf.length > 0
            ? graficoProf.reduce((a, b) =>
                a.totalAgendamentosPorProfessor >
                b.totalAgendamentosPorProfessor
                  ? a
                  : b
              ).nomeProfessor
            : "-";
        console.log(diaComMaiorAtendimento);

        const newKpis = [
          {
            title: "Sessões Realizadas",
            value: total.toString(),
            iconBgColor: "#d8b4fe",
            icon: <FiActivity size={24} color="#fff" />,
          },
          {
            title: "Alunos Atendidos",
            value: total.toString(),
            iconBgColor: "#fdba74",
            icon: <FiUserX size={24} color="#fff" />,
          },
          {
            title: "Dia com Maior Atendimento",
            value: diaComMaiorAtendimento,
            iconBgColor: "#93c5fd",
            icon: <FiUserCheck size={24} color="#fff" />,
          },
          {
            title: "Professor Mais Atendido",
            value: especialidadeMaisRequisitada,
            iconBgColor: "#fef08a",
            icon: <FiUsers size={24} color="#fff" />,
          },
        ];

        setKpis(newKpis);

        const top = [...graficoProf]
          .sort(
            (a, b) =>
              b.totalAgendamentosPorProfessor - a.totalAgendamentosPorProfessor
          )
          .slice(0, 3)
          .map((item) => ({
            professor: item.nomeProfessor,
            total: item.totalAgendamentosPorProfessor,
            percentual: Math.round(
              (item.totalAgendamentosPorProfessor / total) * 100
            ),
          }));

        setTop3(top);

        setHasData(graficoDias.length > 0 || graficoProf.length > 0);
      } catch (error) {
        console.error("Erro ao buscar dados:", error);
        setPie([]);
        setFrequencia([]);
        setTotalAulas(0);
        setTop3([]);
        setHasData(false);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, [user?.id, period]);

  return { kpis, pie, frequencia, loading, totalAulas, top3, hasData };
};
