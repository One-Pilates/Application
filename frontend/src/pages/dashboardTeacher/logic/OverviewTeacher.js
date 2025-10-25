// OverviewDashboard.js
export const getKpiData = () => [
    { title: 'Sessões Realizadas', value: '54', subtitle: '12% de Aumento do Último Mês', iconBgColor: 'purple' },
    { title: 'Ausências de Alunos', value: '9%', subtitle: '50% de Redução do Último Mês', iconBgColor: 'orange' },
    { title: 'Suas Ausências', value: '2%', subtitle: 'Por dia', iconBgColor: 'blue' },
    { title: 'Alunos ativos', value: '10', subtitle: 'Por dia', iconBgColor: 'yellow' }
];

export const getFrequenciaData = () => [
    { name: 'Meta atingida', data: [0, 21, 14, 0, 18, 11] },
    { name: 'Próximo da meta', data: [0, 0, 0, 25, 0, 0] },
    { name: 'Abaixo da meta', data: [17, 0, 0, 0, 0, 0] }
];

export const getPieData = () => [
    { name: 'Pilates', y: 62.5 },
    { name: 'Massagem', y: 12.5 },
    { name: 'Fisioterapia', y: 25 }
];
