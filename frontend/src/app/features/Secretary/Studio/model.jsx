import { useState } from "react";

export const useStudioModel = () => {
  const [especialidades, setEspecialidades] = useState([
    { id: 1, nome: 'Fisioterapia' },
    { id: 2, nome: 'Massoterapia' },
    { id: 3, nome: 'Acupuntura' }
  ]);
    const [salas, setSalas] = useState([
    { id: 1, nome: 'Sala 1', capacidade: 8 },
    { id: 2, nome: 'Sala VIP', capacidade: 4 },
    { id: 3, nome: 'Sala Reformer', capacidade: 6 }
  ]);
  const [activeTab, setActiveTab] = useState('especialidades');

  return {
    especialidades,
    setEspecialidades,
    salas,
    setSalas,
    activeTab,
    setActiveTab,
  };
};
