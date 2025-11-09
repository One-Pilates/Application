import { useState } from 'react';
import './style.scss';
import KPICard from './components/KPICard';
import FrequenciaChart from './components/FrequenciaChart';
import PieChart from './components/PieChart';
import Filter from './components/Filter';

const DashboardView = ({ kpis, frequencia, pie }) => {
  const [selectedPeriod, setSelectedPeriod] = useState(30);

  const handleFilterChange = (newPeriod) => {
    setSelectedPeriod(newPeriod);
  };

  return (
    <div className="overview-teacher">
      <div className="overview-header">
        <h1>Visão Geral</h1>
        <Filter value={selectedPeriod} onChange={handleFilterChange} />
      </div>

      <div className="kpi-grid">
        {kpis.map((kpi, idx) => (
          <KPICard key={idx} {...kpi} />
        ))}
      </div>

      <div className="charts-grid">
        <FrequenciaChart title="Frequência por Dia da Semana" data={frequencia} />
        
        <PieChart title="TOP 3 Aulas mais Realizadas" data={pie} />
      </div>
    </div>
  );
};

export default DashboardView;