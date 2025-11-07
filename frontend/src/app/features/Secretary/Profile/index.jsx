import React from "react";
import { useProfileSecretaryModel } from "./model";
import ProfileSecretaryView from "./view";

export default function ProfileSecretary() {
  const model = useProfileSecretaryModel();
  return <ProfileSecretaryView {...model} />;
}
