import React, { useState } from "react";
import Botao from "../components/Button";
import DefinirAusenciaModal from "./components/AusenciaModal";

export default function CalendarSecretary() {
  const [isModalOpen, setIsModalOpen] = useState(false);

  return (
    <>
      <Botao texto="Definir Ausência" cor="bg-main" onClick={() => setIsModalOpen(true)}> </Botao>

      {isModalOpen && (
        <DefinirAusenciaModal 
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
        />
      )}
    </>
  )
}