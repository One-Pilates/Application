import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../../provider/api.js";
import "./styles/Login.scss";
import { validacaoEmail } from "../../utils/funcoesUtils";
import Swal from "sweetalert2";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    if (!validacaoEmail(email)) {
      Swal.fire({
        icon: "error",
        title: "Email inválido",
        text: "Por favor, insira um email válido.",
      });
      return;
    } else if (!password) {
      Swal.fire({
        icon: "error",
        title: "Senha inválida",
        text: "Por favor, insira uma senha válida.",
      });
      return;
    }

    api.post("/funcionarios/login", {
        email: email,
        password: password,
      })
      .then((response) => {
        const data = response.data;
        if (data && data.token) {
          localStorage.setItem("token", data.token);
          Swal.fire({
            icon: "success",
            title: "Login bem-sucedido",
            text: "Você foi logado com sucesso.",
          });
          navigate("/dashboard");
        }
        console.log("Login bem-sucedido:", data);
      })
      .catch((error) => {
        const status = error.status;
        const message =
          status === 401
            ? "Email ou senha incorretos."
            : "Ocorreu um erro inesperado. Tente novamente mais tarde.";
        Swal.fire({
          icon: "error",
          title: "Erro ao fazer login",
          text: message,
        });
        console.error("Erro ao fazer login:", error);
      });
  };

  return (
    <div className="login">
      <div
        className="login__container"
        role="region"
        aria-label="Formulário de login"
      >
        <div className="login__header">
          <h1 id="login-title" className="login__title">
            Login
          </h1>
          <p className="login__subtitle">Porque seu corpo é único!</p>
        </div>
        <form
          className="login__form"
          onSubmit={handleLogin}
          aria-describedby="login-help"
        >
          <div className="login__field">
            <label htmlFor="email" className="login__label">
              Email
            </label>
            <input
              type="email"
              id="email"
              name="email"
              onChange={(e) => setEmail(e.target.value)}
              className="login__input"
              required
            />
          </div>
          <div className="login__field">
            <label htmlFor="password" className="login__label">
              Senha
            </label>
            <input
              type="password"
              id="password"
              name="password"
              onChange={(e) => setPassword(e.target.value)}
              className="login__input"
              required
            />
          </div>
          <button type="submit" className="login__button">
            Entrar
          </button>
          <div className="login__links" id="login-help">
            <a href="#/recuperar-senha" className="login__forgot">
              Esqueci minha senha
            </a>
            <p className="login__contact">
              Precisa de acesso? Contate o administrador.
            </p>
          </div>
        </form>
      </div>
      <div className="background-login" aria-hidden="true">
        <img src="/logoBranca.png" alt="Logo branca" />
      </div>
    </div>
  );
}
