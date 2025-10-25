import './style.scss';
import KPICard from './components/KPICard';
import FrequenciaChart from './components/FrequenciaChart';
import PieChart from './components/PieChart';

const DashboardView = ({ kpis, frequencia, pie }) => {
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
        {kpis.map((kpi, idx) => (
          <KPICard key={idx} {...kpi} />
        ))}
      </div>

      <div className="charts-grid">
        <FrequenciaChart title="Frequência por Dia da Semana" series={frequencia} />
        <PieChart title="TOP 3 Aulas mais Realizadas" data={pie} />
      </div>
    </div>
  );
};

export default DashboardView;
