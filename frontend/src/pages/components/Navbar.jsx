import React from "react";
import { FaChartBar, FaUser, FaCalendarAlt, FaSignOutAlt, FaChalkboardTeacher, FaUsers } from "react-icons/fa";
import Sidebar from "./Sidebar";
import { useNavigate, useLocation } from "react-router-dom";

export default function NavbarTeacher({ navAberta, userType }) {
  const navigate = useNavigate();
  const location = useLocation();

  const isActive = (path) => location.pathname === path;

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
          <Sidebar
            Icon={FaChartBar}
            texto="Dashboard"
            navAberta={navAberta}
            ativo={isActive("/dashboardTeacher")}
            onClick={() => navigate("/dashboardTeacher")}
          />
          <Sidebar
            Icon={FaUser}
            texto="Perfil"
            navAberta={navAberta}
            ativo={isActive("/dashboardTeacher/perfil")}
            onClick={() => navigate("/dashboardTeacher/perfil")}
          />
          <Sidebar
            Icon={FaCalendarAlt}
            texto="Agenda"
            navAberta={navAberta}
            ativo={isActive("/dashboardTeacher/agenda")}
            onClick={() => navigate("/dashboardTeacher/agenda")}
          />
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


export function NavbarSecretary({ navAberta }) {
  const navigate = useNavigate();
  const location = useLocation();

  const isActive = (path) => location.pathname === path;

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
          <Sidebar
            Icon={FaChartBar}
            texto="Dashboard"
            navAberta={navAberta}
            ativo={isActive("/dashboardSecretary")}
            onClick={() => navigate("/dashboardSecretary")}
          />
          <Sidebar
            Icon={FaUser}
            texto="Perfil"
            navAberta={navAberta}
            ativo={isActive("/dashboardSecretary/perfil")}
            onClick={() => navigate("/dashboardSecretary/perfil")}
          />
          <Sidebar
            Icon={FaCalendarAlt}
            texto="Agenda"
            navAberta={navAberta}
            ativo={isActive("/dashboardSecretary/agenda")}
            onClick={() => navigate("/dashboardSecretary/agenda")}
          />
          <Sidebar
            Icon={FaChalkboardTeacher}
            texto="Professor"
            navAberta={navAberta}
            ativo={isActive("/dashboardSecretary/professor")}
            onClick={() => navigate("/dashboardSecretary/professor")}
          />
          <Sidebar
            Icon={FaUsers}
            texto="Alunos"
            navAberta={navAberta}
            ativo={isActive("/dashboardSecretary/alunos")}
            onClick={() => navigate("/dashboardSecretary/alunos")}
          />
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


