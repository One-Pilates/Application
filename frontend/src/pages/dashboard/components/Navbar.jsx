import React from "react";
import { FaChartBar, FaUser, FaCalendarAlt, FaChalkboardTeacher, FaUsers, FaSignOutAlt } from "react-icons/fa";
import Sidebar from "./Sidebar";
import { useNavigate } from "react-router-dom";

function NavBar({ navAberta, paginaAtual, setPaginaAtual }) {
  const navigate = useNavigate();

  return (
    <div className={`${navAberta ? "w-60" : "w-20"} bg-orange-500 text-white flex flex-col justify-between transition-all duration-300`}>
      <div>
        <div className="flex justify-center py-8">
          <img
            src="../logoMinimalistaBranca.png"
            alt="logo"
            className={`${navAberta ? "w-32" : "w-12"} transition-all`}
          />
        </div>
        <nav className="mt-6">
          <Sidebar Icon={FaChartBar} texto="Dashboard" navAberta={navAberta} ativo={paginaAtual === "dashboard"} onClick={() => setPaginaAtual("dashboard")} />
          <Sidebar Icon={FaUser} texto="Perfil" navAberta={navAberta} ativo={paginaAtual === "perfil"} onClick={() => setPaginaAtual("perfil")} />
          <Sidebar Icon={FaCalendarAlt} texto="Agenda" navAberta={navAberta} ativo={paginaAtual === "agenda"} onClick={() => setPaginaAtual("agenda")} />
          <Sidebar Icon={FaChalkboardTeacher} texto="Professor" navAberta={navAberta} ativo={paginaAtual === "professor"} onClick={() => setPaginaAtual("professor")} />
          <Sidebar Icon={FaUsers} texto="Alunos" navAberta={navAberta} ativo={paginaAtual === "alunos"} onClick={() => setPaginaAtual("alunos")} />
        </nav>
      </div>
      <div className="mb-6">
        <div
          onClick={() => navigate("/login")}
          className="flex items-center gap-4 px-4 py-3 cursor-pointer transition rounded-full mx-2 my-2 hover:bg-orange-600"
        >
          <FaSignOutAlt size={22} />
          {navAberta && <span>Sair</span>}
        </div>
      </div>
    </div>
  );
}

export default NavBar;
