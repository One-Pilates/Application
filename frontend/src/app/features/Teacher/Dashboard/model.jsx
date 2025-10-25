import { useState, useEffect } from "react";
import { FiActivity, FiUserX, FiUserCheck, FiUsers } from "react-icons/fi";
export const useDashboardModel = () => {
  const [kpis, setKpis] = useState([]);
  const [frequencia, setFrequencia] = useState([]);
  const [pie, setPie] = useState([]);

  useEffect(() => {
    const kpiData = [
      { title: 'Sessões Realizadas', value: '54', subtitle: '12% de Aumento do Último Mês', iconBgColor: 'purple', icon: <FiActivity size={24} color="#fff" /> },
      { title: 'Ausências de Alunos', value: '9%', subtitle: '50% de Redução do Último Mês', iconBgColor: 'orange', icon: <FiUserX size={24} color="#fff" /> },
      { title: 'Suas Ausências', value: '2%', subtitle: 'Por dia', iconBgColor: 'blue', icon: <FiUserCheck size={24} color="#fff" /> },
      { title: 'Alunos ativos', value: '10', subtitle: 'Por dia', iconBgColor: 'yellow', icon: <FiUsers size={24} color="#fff" /> }
    ];

    const frequenciaData = [
      { name: 'Meta atingida', data: [0, 21, 14, 0, 18, 11] },
      { name: 'Próximo da meta', data: [0, 0, 0, 25, 0, 0] },
      { name: 'Abaixo da meta', data: [17, 0, 0, 0, 0, 0] }
    ];

    const pieData = [
      { name: 'Pilates', y: 62.5 },
      { name: 'Massagem', y: 12.5 },
      { name: 'Fisioterapia', y: 25 }
    ];

    setKpis(kpiData);
    setFrequencia(frequenciaData);
    setPie(pieData);
  }, []);

  return { kpis, frequencia, pie };
};
