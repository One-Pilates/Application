import React from "react";

const KPICard = ({ title, value, subtitle, iconBgColor, icon }) => {
  return (
    <div className="kpi-card">
      <div
        className="kpi-icon"
        style={{ backgroundColor: iconBgColor }}
      >
        {icon}
      </div>

      <div className="kpi-content">
        <p className="kpi-title">{title}</p>
        <h2 className="kpi-value">{value}</h2>
        <p className="kpi-subtitle">{subtitle}</p>
      </div>
    </div>
  );
};

export default KPICard;
