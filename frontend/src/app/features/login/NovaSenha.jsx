import { useState } from "react";
import "./Login.scss";
import "./CodigoVerificacao.scss";
import { Link, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";
import axios from "axios";

export default function NovaSenha() {
  const [password1, setPassword1] = useState("");
  const [password2, setPassword2] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();

    if (password1 !== password2) {
      Swal.fire({
        icon: "error",
        title: "Senha inválida",
        text: "As senhas devem ser iguais",
      });
      return;
    }

    const email = sessionStorage.getItem("email");

    Swal.fire({
      title: "Redefinindo...",
      text: "Estamos atualizando sua senha",
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      },
    });

    try {
      const response = await axios.post(
        `http://localhost:8080/auth/alterarSenha`,
        {
          senha: password1,
          email: email,
        }
      );

      console.log("Resposta do servidor:", response.data);

      Swal.fire({
        icon: "success",
        title: "Senha cadastrada",
        text: "Sua nova senha foi cadastrada com sucesso",
      });

      navigate("/login");
    } catch (error) {
      console.error("Erro ao redefinir senha:", error);
      console.log("Detalhes do erro:", error.response?.data);

      Swal.fire({
        icon: "error",
        title: "Erro ao redefinir",
        text: "Não foi possível atualizar sua senha. Tente novamente.",
      });
    }
  };

  return (
    <div className="login">
      <div
        className="login__container"
        role="region"
        aria-label="Formulário de redefinição de senha"
      >
        <Link to="/Login" className="botao-voltar">
          <i className="bi bi-arrow-left-circle-fill"></i>Voltar
        </Link>

        <div className="login__header">
          <h1 id="login-title" className="login__title">
            Criar nova senha
          </h1>
          <p className="login__subtitle">
            Defina uma nova senha para sua conta
          </p>
        </div>

        <form
          className="login__form"
          onSubmit={handleLogin}
          aria-describedby="login-help"
        >
          <div className="login__field">
            <label htmlFor="password1" className="login__label">
              Senha
            </label>
            <input
              type="password"
              id="password1"
              name="password1"
              onChange={(e) => setPassword1(e.target.value)}
              className="login__input"
              required
              placeholder="*****"
            />
          </div>

          <div className="login__field">
            <label htmlFor="password2" className="login__label">
              Repetir Senha
            </label>
            <input
              type="password"
              id="password2"
              name="password2"
              onChange={(e) => setPassword2(e.target.value)}
              className="login__input"
              required
              placeholder="*****"
            />
          </div>

          <button type="submit" className="login__button">
            Redefinir Senha
          </button>
        </form>
      </div>

      <div className="background-login" aria-hidden="true">
        <img src="/logoBranca.png" alt="Logo branca" />
      </div>
    </div>
  );
}
