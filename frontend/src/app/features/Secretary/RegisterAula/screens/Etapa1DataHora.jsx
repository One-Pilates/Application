import React from "react";

export default function Etapa1DataHora(props) {
  const {
    dataHora,
    setDataHora,
    erros,
  } = props;

  const handleDataChange = (e) => {
    setDataHora((prev) => ({ ...prev, data: e.target.value }));
  };

  const handleHorarioChange = (e) => {
    setDataHora((prev) => ({ ...prev, horario: e.target.value }));
  };

  return (
    <div className="etapa-content">
      <h2>Quando será a aula?</h2>

      <div className="form-group">
        <label htmlFor="data">Data *</label>
        <input
          type="date"
          id="data"
          value={dataHora.data}
          onChange={handleDataChange}
          className={erros.data ? "input-error" : ""}
        />
        {erros.data && <span className="error-message">{erros.data}</span>}
      </div>

      <div className="form-group">
        <label htmlFor="horario">Horário *</label>
        <input
          type="time"
          id="horario"
          value={dataHora.horario}
          onChange={handleHorarioChange}
          className={erros.horario ? "input-error" : ""}
        />
        {erros.horario && <span className="error-message">{erros.horario}</span>}
      </div>
    </div>
  );
}
