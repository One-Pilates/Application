import React from "react";
import { useProfileTeacherModel } from "./model";
import ProfileTeacherView from "./view";

const ProfileTeacher = () => {
  const model = useProfileTeacherModel();
  return <ProfileTeacherView {...model} />;
};

export default ProfileTeacher;
