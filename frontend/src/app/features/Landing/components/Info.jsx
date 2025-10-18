import React from "react";
import { FaPhoneAlt } from "react-icons/fa";
import { MdEmail } from "react-icons/md";
import { FaRegBuilding } from "react-icons/fa";
import "../styles/Info.scss";

export default function Info() {
  return (
    <section className="info">
      <div className="info-item">
        <FaPhoneAlt className="icon" />
        <p>
          <strong>+55 (11) 3051-4139</strong>
          Ligue para nós ou clique no número para falar conosco e marcar sua visita.
        </p>
      </div>

      <div className="info-item">
        <MdEmail className="icon" />
        <p>
          <strong>atendimento@onepilates.com.br</strong>
          Ficou com alguma dúvida ou tem alguma sugestão?<br />
          Envie para nós.
        </p>
      </div>

      <div className="info-item">
        <FaRegBuilding className="icon" />
        <p>
          <strong>Horário de Atendimento</strong>
          Nosso horário de atendimento é de Seg. a Qui. das 7h às 22h<br />
          e Sex das 7h às 19h
        </p>
      </div>
    </section>
  );
}
