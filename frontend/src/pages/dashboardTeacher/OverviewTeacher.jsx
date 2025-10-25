import React from 'react';
import KPICard from './components/KPICard';
import FrequenciaChart from './components/FrequenciaChart';
import PieChart from './components/PieChart';
import { getKpiData, getFrequenciaData, getPieData } from './logic/OverviewTeacher';
import './styles/OverviewTeacher.scss';

const OverviewTeacher = () => {
    // Pega os dados da "ViewModel" (arquivo de lógica)
    const kpiData = getKpiData();
    const frequenciaSeries = getFrequenciaData();
    const pieData = getPieData();

    return (
        <div className="overview-teacher">
            <div className="overview-header">
                <h1>Visão Geral</h1>
                <select>
                    <option>Últimos 30 dias</option>
                    <option>Últimos 7 dias</option>
                    <option>Últimos 90 dias</option>
                </select>
            </div>

            <div className="kpi-grid">
                {kpiData.map((kpi, idx) => (
                    <KPICard key={idx} {...kpi} />
                ))}
            </div>

            <div className="charts-grid">
                <FrequenciaChart title="Frequência por Dia da Semana" series={frequenciaSeries} />
                <PieChart title="TOP 3 Aulas mais Realizadas" data={pieData} />
            </div>
        </div>
    );
};

export default OverviewTeacher;
