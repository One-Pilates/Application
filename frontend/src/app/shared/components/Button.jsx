import React from "react";

function Botao({ cor, icone: Icone, texto, onClick }) {
  return (
    <button
      onClick={onClick}
      className={`${cor} text-white font-semibold flex items-center gap-2 px-8 py-3 rounded-md shadow-md hover:opacity-90 transition`}
    >
      {Icone && <Icone size={18} />}
      {texto}
    </button>
  );
}

export default Botao;
