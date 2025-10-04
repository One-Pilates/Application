import React, { useState } from "react";
import { FaBars } from "react-icons/fa";
import Account from "./components/Account";
import NavBar from "./components/Navbar";

function Dashboard() {
  const [navAberta, setNavAberta] = useState(true);
  const [paginaAtual, setPaginaAtual] = useState("agenda");

  return (
    <div className="flex h-screen bg-gray-100">
      <NavBar navAberta={navAberta} paginaAtual={paginaAtual} setPaginaAtual={setPaginaAtual} />
      <div className="flex flex-col flex-1">
        <div className="flex justify-between items-center bg-gray-200 px-6 py-3 border-b">
          <div className="flex items-center gap-4">
            <button onClick={() => setNavAberta(!navAberta)} className="p-2 rounded hover:bg-gray-300 transition">
              <FaBars size={20} />
            </button>
            <h1 className="text-xl font-bold capitalize">{paginaAtual}</h1>
          </div>
          <Account />
        </div>
        <div className="flex-1 bg-gray-100 p-6">
          <p className="text-gray-600">Aqui entra o conteúdo da página <b>{paginaAtual}</b></p>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
