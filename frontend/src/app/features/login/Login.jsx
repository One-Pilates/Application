import React from "react";
import { useNavigate } from "react-router-dom";
import LoginView from "./View"; 
import { useLoginModel } from "./Model";

const Login = () => {
  const navigate = useNavigate();
  const model = useLoginModel();

  return <LoginView {...model} navigate={navigate} />;
};

export default Login;
