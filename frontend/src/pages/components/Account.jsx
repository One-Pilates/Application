import React from "react";
import { FaChevronDown } from "react-icons/fa";
import Swal from "sweetalert2";

function Account() {
  const abrirModal = () => {
    Swal.fire({
      title: "Conta",
      text: "Aqui você pode gerenciar o perfil do usuário.",
      icon: "info",
      confirmButtonText: "Fechar",
      confirmButtonColor: "#ff6b35",
      background: "#1e1e1e",
      color: "#fff", 
    });
  };

  return (
    <div
      onClick={abrirModal}
      className="flex items-center gap-3 bg-white rounded-full px-3 py-2 shadow cursor-pointer hover:bg-gray-100 transition"
    >
      <img
        src="https://via.placeholder.com/40"
        alt="Perfil"
        className="w-10 h-10 rounded-full"
      />
      <div className="hidden md:block">
        <p className="font-semibold">Amanda</p>
        <p className="text-sm text-gray-500">Recepcionista</p>
      </div>
      <FaChevronDown className="text-gray-600" />
    </div>
  );
}

export default Account;
