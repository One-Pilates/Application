import React from "react";
import { FaChevronDown } from "react-icons/fa";
import Notiflix from "notiflix";

function Account() {
  const abrirModal = () => {
    Notiflix.Report.info("Conta", "Aqui você pode gerenciar o perfil do usuário.", "Fechar");
  };

  return (
    <div className="flex items-center gap-3 bg-white rounded-full px-3 py-2 shadow cursor-pointer">
      <img
        src="https://via.placeholder.com/40"
        alt="Perfil"
        className="w-10 h-10 rounded-full"
      />
      <div className="hidden md:block">
        <p className="font-semibold">Amanda</p>
        <p className="text-sm text-gray-500">Recepcionista</p>
      </div>
      <FaChevronDown onClick={abrirModal} className="text-gray-600 cursor-pointer" />
    </div>
  );
}

export default Account;
