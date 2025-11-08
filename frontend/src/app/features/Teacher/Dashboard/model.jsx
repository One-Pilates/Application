import { useState, useEffect } from "react";
import { FiActivity, FiUserX, FiUserCheck, FiUsers } from "react-icons/fi";

export const useDashboardModel = (period) => {
  const [kpis] = useState([
    { title: 'Sessões Realizadas', value: '54', subtitle: '12% de Aumento do Último Mês', iconBgColor: '#d8b4fe', icon: <FiActivity size={24} color="#fff" /> },
    { title: 'Ausências de Alunos', value: '9%', subtitle: '50% de Redução do Último Mês', iconBgColor: '#fdba74', icon: <FiUserX size={24} color="#fff" /> },
    { title: 'Suas Ausências', value: '2%', subtitle: 'Por dia', iconBgColor: '#93c5fd', icon: <FiUserCheck size={24} color="#fff" /> },
    { title: 'Alunos ativos', value: '10', subtitle: 'Por dia', iconBgColor: '#fef08a', icon: <FiUsers size={24} color="#fff" /> }
  ]);

  const [pie, setPie] = useState([]);
  const [frequencia, setFrequencia] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const professorId = sessionStorage.getItem("professorId"); // pegando do sessionStorage
    if (!professorId || !period) return;

    const fetchDashboardData = async () => {
      setLoading(true);

      try {
        const token = localStorage.getItem("token");
        if (!token) throw new Error("Token JWT não encontrado");

        const response = await fetch(`http://localhost:8080/api/professores/${professorId}/${period}`, {
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
          }
        });

        if (!response.ok) {
          console.error(`Erro na requisição: ${response.status}`);
          setPie([]);
          setFrequencia([]);
          return;
        }

        const data = await response.json();

        // Grafico de Pizza
        const distribuicao = data.distribuicaoEspecialidades || [];
        const pieData = distribuicao.map(item => ({
          name: item.especialidade,
          y: item.percentual
        }));
        setPie(pieData);

        // Frequencia
        const freqData = data.frequencia || []; // assumindo que a API retorne isso
        setFrequencia(freqData);

      } catch (error) {
        console.error("❌ Erro ao buscar dados do professor:", error);
        setPie([]);
        setFrequencia([]);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboardData();
  }, [period]);

  return { kpis, pie, frequencia, loading };
};
  