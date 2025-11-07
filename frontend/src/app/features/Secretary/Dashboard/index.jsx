import React from "react";
import { useDashboardSecretaryModel } from "./model";
import DashboardSecretaryView from "./view";

export default function DashboardSecretary() {
  const model = useDashboardSecretaryModel();
  return <DashboardSecretaryView {...model} />;
}
