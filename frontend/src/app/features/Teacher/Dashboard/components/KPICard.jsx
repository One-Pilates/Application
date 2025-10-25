const KPICard = ({ title, value, subtitle, iconBgColor }) => {
    return (
        <div className="kpi-card">
            <div className="kpi-card-header">
                <div className={`kpi-icon ${iconBgColor}`}></div>
            </div>
            <div className="kpi-card-body">
                <p className="kpi-title">{title}</p>
                <p className="kpi-value">{value}</p>
                {subtitle && <p className="kpi-subtitle">{subtitle}</p>}
            </div>
        </div>
    );
};

export default KPICard;
