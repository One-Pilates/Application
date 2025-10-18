import React from "react";
import './style.scss';

const DashboardView = ({ kpis, charts }) => {
  return (
    <div>
      <div className="dashboard__kpis">
        {kpis.map((kpi, index) => (
          <div key={index}>{kpi}</div>
        ))}
      </div>

      <div className="dashboard__charts">
        {charts.map((chart, index) => (
          <div key={index}>{chart}</div>
        ))}
      </div>
    </div>
  );
};

export default DashboardView;
