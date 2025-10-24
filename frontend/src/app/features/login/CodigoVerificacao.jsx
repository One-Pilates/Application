import { useState, useRef } from "react";
import "./CodigoVerificacao.scss";
import { Link } from "react-router-dom";

export default function CodigoVerificacao() {
  const [codigo, setCodigo] = useState(["", "", "", "", ""]);
  const inputsRef = useRef([]);

  const handleChange = (index, value) => {
    if (!/^[A-Za-z0-9]?$/.test(value)) return;

    const novoCodigo = [...codigo];
    novoCodigo[index] = value.toUpperCase();
    setCodigo(novoCodigo);

    if (value && index < 4) {
      inputsRef.current[index + 1].focus();
    }
  };

  const handleKeyDown = (index, e) => {
    if (e.key === "Backspace" && !codigo[index] && index > 0) {
      inputsRef.current[index - 1].focus();
    }
  };

  const confirmarCodigo = () => {
    const codigoFinal = codigo.join("");
    console.log("Código digitado:", codigoFinal);
    alert("Código digitado: " + codigoFinal);
  };

  return (
    <div className="login">
      <div className="login__container">
        
        <Link to="/Login" className="botao-voltar">
         <i class="bi bi-arrow-left-circle-fill"></i>Voltar
        </Link>

        <div className="login__header">
          <h1 className="login__title">Código de verificação</h1>
          <p className="login__subtitle">
            Confira sua caixa de entrada e informe o código <br /> recebido
          </p>
        </div>

        <p className="login__success">O e-mail foi enviado com sucesso</p>

        <div className="code-inputs">
          {codigo.map((valor, index) => (
            <input
              key={index}
              type="text"
              maxLength="1"
              value={valor}
              ref={(el) => (inputsRef.current[index] = el)}
              onChange={(e) => handleChange(index, e.target.value)}
              onKeyDown={(e) => handleKeyDown(index, e)}
              className="input-codigo"
            />
          ))}
        </div>

        <button onClick={confirmarCodigo} className="login__button">
          Confirmar código
        </button>
      </div>

      <div className="background-login">
        <img src="/logoBranca.png" alt="Logo branca" />
      </div>
    </div>
  );
}
