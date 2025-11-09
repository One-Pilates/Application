import { useState, useEffect } from "react";
import { FiActivity, FiUserX, FiUserCheck, FiUsers } from "react-icons/fi";
import { useAuth } from "../../../../hooks/useAuth";
import api from "../../../../provider/api";

export const useDashboardModel = (period) => {
  const [kpis] = useState([
    { title: 'Sessões Realizadas', value: '54', subtitle: '12% de Aumento do Último Mês', iconBgColor: '#d8b4fe', icon: <FiActivity size={24} color="#fff" /> },
    { title: 'Ausências de Alunos', value: '9%', subtitle: '50% de Redução do Último Mês', iconBgColor: '#fdba74', icon: <FiUserX size={24} color="#fff" /> },
    { title: 'Suas Ausências', value: '2%', subtitle: 'Por dia', iconBgColor: '#93c5fd', icon: <FiUserCheck size={24} color="#fff" /> },
    { title: 'Alunos Ativos', value: '10', subtitle: 'Por dia', iconBgColor: '#fef08a', icon: <FiUsers size={24} color="#fff" /> }
  ]);

  const [pie, setPie] = useState([]);
  const [frequencia, setFrequencia] = useState([]);
  const [totalAulas, setTotalAulas] = useState(0);
  const [top3, setTop3] = useState([]);
  const [loading, setLoading] = useState(false);

  const { user } = useAuth();

  useEffect(() => {
    if (!user || !user.id) return;

    const fetchDashboardData = async () => {
      setLoading(true);
      try {
        const dias = period || 30;
        const response = await api.get(`api/professores/${user.id}/${dias}`);
        const data = response.data;

        // === GRÁFICO DE FREQUÊNCIA ===
        const grafico1 = data.agendamentosPorDiasDTO || [];
        setFrequencia(grafico1); // ⚡ Passa direto para o chart, sem mapear ainda

        // === GRÁFICO DE PIZZA === (não muda nada)
        const grafico2 = data.aulasPorEspecialidadesDTO || [];
        const pieData = grafico2.map(item => ({
          name: item.especialidade,
          y: item.percentualAulas || 0
        }));
        setPie(pieData);

        // TOTAL DE AULAS
        const total = grafico2.reduce((sum, item) => sum + (item.percentualAulas || 0), 0);
        setTotalAulas(total);

        // TOP 3
        const top = [...grafico2]
          .sort((a, b) => (b.percentualAulas || 0) - (a.percentualAulas || 0))
          .slice(0, 3)
          .map(item => ({
            especialidade: item.especialidade,
            percentual: item.percentualAulas,
            totalEstimado: Math.round(((item.percentualAulas || 0) * total) / 100)
          }));
        setTop3(top);

      } catch (error) {
        console.error("Erro ao buscar dados do professor:", error);
        setPie([]);
        setFrequencia([]);
        setTotalAulas(0);
        setTop3([]);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, [user?.id, period]);

  return { kpis, pie, frequencia, loading, totalAulas, top3 };
};
