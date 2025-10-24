import { useState } from "react";
import "./Login.scss";
import "./CodigoVerificacao.scss";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";

export default function NovaSenha() {
  const [password1, setPassword1] = useState("");
  const [password2, setPassword2] = useState("");

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

    Swal.fire({
      icon: "success",
      title: "Senha cadastrada",
      text: "Sua nova senha foi cadastrada com sucesso",
    });

  };

  return (
    <div className="login">
      <div
        className="login__container"
        role="region"
        aria-label="Formulário de redefinição de senha"
      >
         <Link to="/Login" className="botao-voltar">
         <i class="bi bi-arrow-left-circle-fill"></i>Voltar
        </Link>
        
        <div className="login__header">
          <h1 id="login-title" className="login__title">
            Criar nova senha
          </h1>
          <p className="login__subtitle">Defina uma nova senha para sua conta</p>
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
