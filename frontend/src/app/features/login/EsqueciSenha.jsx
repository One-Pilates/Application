import { useState, useRef } from "react";
import "./CodigoVerificacao.scss";
import { Link } from "react-router-dom";

export default function EsqueciSenha() {
    const inputsRef = useRef([]);



    return (
        <div className="login">
            <div className="login__container">

                <Link to="/Login" className="botao-voltar">
                    <i class="bi bi-arrow-left-circle-fill"></i>Voltar
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
                        onChange={(e) => setEmail(e.target.value)}
                        className="login__input"
                        required
                    />
                    <br /><br />
                </div>
                <button onClick={EsqueciSenha} className="login__button">
                    Enviar
                </button>

            </div>

            <div className="background-login">
                <img src="/logoBranca.png" alt="Logo branca" />
            </div>
        </div>

    );
}
