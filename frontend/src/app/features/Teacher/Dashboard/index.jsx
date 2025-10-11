import React from "react";
import { useDashboardModel } from "./model";
import DashboardView from "./view";

const Dashboard = () => {
  const model = useDashboardModel();
  return <DashboardView {...model} />;
};

export default Dashboard;
