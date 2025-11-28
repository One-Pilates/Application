import React from "react";
import { FaChartBar, FaUser, FaCalendarAlt, FaSignOutAlt, FaChalkboardTeacher, FaUsers, FaSlidersH } from "react-icons/fa";
import ItemSidebar from "./ItemSidebar";
import { useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "../../../hooks/useAuth";


export default function SidebarTeacher({ navAberta}) {
  const navigate = useNavigate();
  const location = useLocation();
  const {logout} = useAuth();
  const isActive = (path) => location.pathname === path;

  return (
    <div
      className={`${
        navAberta ? "w-60" : "w-20"
      } bg-orange-500 text-white flex flex-col justify-between transition-all duration-300`}
    >
      <div>
        <div className="flex justify-center py-8">
          <img
            src="../logoMinimalistaBranca.png"
            alt="logo"
            className={`${navAberta ? "w-32" : "w-12"} transition-all`}
          />
        </div>

        <nav className="mt-6">
          <ItemSidebar
            icon={FaCalendarAlt}
            texto="Agenda"
            navAberta={navAberta}
            ativo={isActive("/professora/agenda")}
            onClick={() => navigate("/professora/agenda")}
          />
          <ItemSidebar
            icon={FaChartBar}
            texto="Dashboard"
            navAberta={navAberta}
            ativo={isActive("/professora/dashboard")}
            onClick={() => navigate("/professora/dashboard")}
          />
          <ItemSidebar
            icon={FaUser}
            texto="Perfil"
            navAberta={navAberta}
            ativo={isActive("/professora/perfil")}
            onClick={() => navigate("/professora/perfil")}
          />
        </nav>
      </div>

      <div className="mb-6">
        <div
          onClick={logout}
          className="flex items-center gap-4 px-4 py-3 cursor-pointer transition rounded-full mx-2 my-2 hover:bg-orange-600"
        >
          <FaSignOutAlt size={22} />
          {navAberta && <span>Sair</span>}
        </div>
      </div>
    </div>
  );
}

// Secretary Sidebar

export function SidebarSecretary({ navAberta }) {
  const navigate = useNavigate();
  const {user, logout} = useAuth();
  const location = useLocation();

  const isActive = (path) => location.pathname === path;

  return (
    <div
      className={`${
        navAberta ? "w-60" : "w-20"
      } bg-orange-500 text-white flex flex-col justify-between transition-all duration-300`}
    >
      <div>
        <div className="flex justify-center py-8">
          <img
            src="../logoMinimalistaBranca.png"
            alt="logo"
            className={`${navAberta ? "w-32" : "w-12"} transition-all`}
          />
        </div>
        <nav className="mt-6">
          <ItemSidebar
            icon={FaChartBar}
            texto="Dashboard"
            navAberta={navAberta}
            ativo={isActive("/secretaria/dashboard")}
            onClick={() => navigate("/secretaria/dashboard")}
          />
          <ItemSidebar
            icon={FaUser}
            texto="Perfil"
            navAberta={navAberta}
            ativo={isActive("/secretaria/perfil")}
            onClick={() => navigate("/secretaria/perfil")}
          />
          <ItemSidebar
            icon={FaCalendarAlt}
            texto="Agenda"
            navAberta={navAberta}
            ativo={isActive("/secretaria/agenda")}
            onClick={() => navigate("/secretaria/agenda")}
          />
          <ItemSidebar
            icon={FaChalkboardTeacher}
            texto="Professor"
            navAberta={navAberta}
            ativo={isActive("/secretaria/professor")}
            onClick={() => navigate("/secretaria/professor")}
          />
          <ItemSidebar
            icon={FaUsers}
            texto="Alunos"
            navAberta={navAberta}
            ativo={isActive("/secretaria/alunos")}
            onClick={() => navigate("/secretaria/alunos")}
          />
          {user.role === "ADMINISTRADOR" && (
            <ItemSidebar
            icon={FaSlidersH}
            texto="Studio"
            navAberta={navAberta}
            ativo={isActive("/secretaria/studio")}
            onClick={() => navigate("/secretaria/studio")}
          />
          )
          }
        </nav>
      </div>

      <div className="mb-6">
        <div
          onClick={logout}
          className="flex items-center gap-4 px-4 py-3 cursor-pointer transition rounded-full mx-2 my-2 hover:bg-orange-600"
        >
          <FaSignOutAlt size={22} />
          {navAberta && <span>Sair</span>}
        </div>
      </div>
    </div>
  );
}
