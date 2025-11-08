import { useState, useEffect } from "react";
import { FiActivity, FiUserX, FiUserCheck, FiUsers } from "react-icons/fi";

export const useDashboardModel = (professorId, period) => {
  const [kpis] = useState([
    { title: 'Sessões Realizadas', value: '54', subtitle: '12% de Aumento do Último Mês', iconBgColor: '#d8b4fe', icon: <FiActivity size={24} color="#fff" /> },
    { title: 'Ausências de Alunos', value: '9%', subtitle: '50% de Redução do Último Mês', iconBgColor: '#fdba74', icon: <FiUserX size={24} color="#fff" /> },
    { title: 'Suas Ausências', value: '2%', subtitle: 'Por dia', iconBgColor: '#93c5fd', icon: <FiUserCheck size={24} color="#fff" /> },
    { title: 'Alunos ativos', value: '10', subtitle: 'Por dia', iconBgColor: '#fef08a', icon: <FiUsers size={24} color="#fff" /> }
  ]);

  const [frequencia] = useState([
    { name: 'Meta atingida', data: [0, 21, 14, 0, 18, 11] },
    { name: 'Próximo da meta', data: [0, 0, 0, 25, 0, 0] },
    { name: 'Abaixo da meta', data: [17, 0, 0, 0, 0, 0] }
  ]);

  const [pie, setPie] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!professorId || !period) return;

    const fetchPieData = async () => {
      setLoading(true);

      try {
        const token = localStorage.getItem("token");
       
        if (!token) throw new Error("Token JWT não encontrado");

        const response = await fetch(`http://localhost:8080/api/professores/5/30`, {
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`
          }
        });

        if (!response.ok) {
          console.error(`Erro na requisição: ${response.status}`);
          setPie([]);
          return;
        }

        const data = await response.json();

        const distribuicao = data.distribuicaoEspecialidades || [];
        const pieData = distribuicao.map(item => ({
          name: item.especialidade,
          y: item.percentual
        }));

        setPie(pieData);

      } catch (error) {
        console.error("❌ Erro ao buscar dados do professor:", error);
        setPie([]);
      } finally {
        setLoading(false);
      }
    };

    fetchPieData();
  }, [professorId, period]);

  return { kpis, frequencia, pie, loading };
};
