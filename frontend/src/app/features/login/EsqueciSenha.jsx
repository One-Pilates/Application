import { useState, useRef } from "react";
import "./CodigoVerificacao.scss";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";
import Swal from "sweetalert2";

export default function EsqueciSenha() {
  const inputsRef = useRef([]);
  const [email, setEmail] = useState("");
  const navigate = useNavigate();

  const handleEnviar = async () => {
    if (!email) {
      Swal.fire({
        icon: "error",
        title: "Email inválido",
        text: "Por favor, insira um email válido.",
      });
      return;
    }

    Swal.fire({
      title: "Enviando...",
      text: "Estamos processando sua solicitação",
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      },
    });

    try {
      const response = await axios.post(
        "http://localhost:8080/auth/criarCodigoVerificacao",
        { email }
      );

      console.log("Resposta do servidor:", response.data);
      sessionStorage.setItem("email", email);

      Swal.fire({
        icon: "success",
        title: "Código enviado!",
        text: "Verifique seu e-mail",
      });

      navigate("/login/codigo-verificacao");
    } catch (error) {
      console.error("Erro ao enviar requisição:", error);

      Swal.fire({
        icon: "error",
        title: "Erro ao enviar",
        text: "Não foi possível enviar o código. Tente novamente.",
      });
    }
  };

  return (
    <div className="login">
      <div className="login__container">
        <Link to="/Login" className="botao-voltar">
          <i className="bi bi-arrow-left-circle-fill"></i>Voltar
        </Link>

        <div className="login__header">
          <h1 className="login__title">Esqueci minha senha</h1>
          <p className="login__subtitle">
            Informe seu e-mail para recuperar o acesso.
          </p>
        </div>

        <div className="login__field">
          <label htmlFor="email" className="login__label">
            Email
          </label>

          <input
            placeholder="onepilates@onepilates.com"
            type="email"
            id="email"
            name="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="login__input"
            required
          />
          <br />
          <br />
        </div>
        <button onClick={handleEnviar} className="login__button">
          Enviar
        </button>
      </div>

      <div className="background-login">
        <img src="/logoBranca.png" alt="Logo branca" />
      </div>
    </div>
  );
}
