import { useState, useEffect } from "react";

export const useDashboardModel = () => {
  const [kpis, setKpis] = useState([]);
  const [charts, setCharts] = useState([]);

  useEffect(() => {
    setKpis(["Kpi 1", "Kpi 2", "Kpi 3", "Kpi 4"]);
    setCharts(["Grafico 1", "Grafico 2"]);
  }, []);

  return { kpis, charts };
};
