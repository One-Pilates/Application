import React, { useState } from "react";
import { FaBars } from "react-icons/fa";
import Account from "../components/Account";
import Navbar from "../components/Navbar";
import ProfileTeacher from "../dashboardTeacher/components/ProfileTeacher";

function DashboardTeacher() {
  const [navAberta, setNavAberta] = useState(true);
  const [paginaAtual, setPaginaAtual] = useState("dashboard");

  return (
    <div className="flex h-screen bg-gray-100">
      <Navbar 
        navAberta={navAberta} 
        paginaAtual={paginaAtual} 
        setPaginaAtual={setPaginaAtual} 
        userType="teacher"
      />
      <div className="flex flex-col flex-1">
        <div className="flex justify-between items-center bg-white px-6 py-3 border-b shadow-sm">
          <div className="flex items-center gap-4">
            <button 
              onClick={() => setNavAberta(!navAberta)} 
              className="p-2 rounded hover:bg-gray-100 transition"
            >
              <FaBars size={20} />
            </button>
            <h1 className="text-xl font-bold capitalize">{paginaAtual}</h1>
          </div>
          <Account />
        </div>
        <div className="flex-1 bg-gray-100 p-6 overflow-auto">
          {paginaAtual === 'perfil' && <ProfileTeacher />}
        </div>
      </div>
    </div>
  );
}

export default DashboardTeacher;