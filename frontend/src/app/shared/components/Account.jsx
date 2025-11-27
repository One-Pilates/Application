import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { FaChevronDown, FaCog, FaKey, FaMoon, FaSun, FaUserCircle } from "react-icons/fa";
import { useAuth } from "../../../hooks/useAuth.jsx";
import ContactAdm from "./ContactAdm.jsx";
import api from "../../../provider/api";
import userIconImg from "/user-icon.png";

function Account() {
  const navigate = useNavigate();
  const [menuAberto, setMenuAberto] = useState(false);
  const [modoEscuro, setModoEscuro] = useState(false);
  const { user } = useAuth() || {};

  const toggleModoEscuro = () => {
    setModoEscuro(!modoEscuro);
  };

  const [isAdminModalOpen, setIsAdminModalOpen] = useState(false);
  const openAdminModal = () => {
    setMenuAberto(false);
    setIsAdminModalOpen(true);
  };

  const nome = user?.nome || user?.name || "Usuário";
  const roleRaw = user?.role || user?.cargo || "";
  const papel = (() => {
    if (!roleRaw) return "";
    const r = roleRaw.toString().toUpperCase();
    if (r.includes("PROF")) return "Professor(a)";
    if (r.includes("SECRET")) return "Secretaria";
    if (r.includes("ADMIN")) return "Administrador";
    return roleRaw;
  })();

  return (
    <div className="relative">
      <button
        onClick={() => setMenuAberto(!menuAberto)}
        className="flex items-center gap-3 px-2 py-2 rounded-lg hover:bg-gray-100 transition-colors"
        aria-expanded={menuAberto}
        aria-haspopup="true"
      >
        {user && user.foto ? (
          <img
            src={`${api.defaults.baseURL}/api/imagens/${user.foto}`}
            alt={nome}
            className="w-10 h-10 rounded-full ring-2 ring-orange-500 object-cover"
          />
        ) : (
          <div className="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center">
            <FaUserCircle className="text-gray-500 text-2xl" />
          </div>
        )}

        <div className="hidden md:block text-left">
          <p className="font-semibold text-gray-800 leading-tight">{nome}</p>
          <p className="text-xs text-gray-500">{papel}</p>
        </div>

        <FaChevronDown 
          className={`text-gray-600 transition-transform ${menuAberto ? 'rotate-180' : ''}`}
        />
      </button>

      {menuAberto && (
        <>
          <div 
            onClick={() => setMenuAberto(false)}
            className="fixed inset-0 z-40"
          />

          <div className="absolute right-0 mt-2 w-72 bg-white rounded-lg shadow-lg border border-gray-200 z-50 overflow-hidden">
            <div className="bg-gradient-to-r from-orange-500 to-orange-600 p-4">
              <div className="flex items-center gap-3">
                <img
                  src={user?.foto ? `${api.defaults.baseURL}/api/imagens/${user.foto}` : userIconImg}
                  alt={nome}
                  className="w-14 h-14 rounded-full ring-2 ring-white object-cover"
                />
                <div className="text-white">
                  <p className="font-bold text-lg leading-tight">{nome}</p>
                  <p className="text-sm opacity-90">{papel}</p>
                </div>
              </div>
            </div>

            <div className="py-2">
              <button 
                onClick={openAdminModal}
                className="w-full px-4 py-3 text-left hover:bg-gray-50 transition-colors flex items-center gap-3"
              >
                <FaCog className="text-gray-600" />
                <span className="text-gray-700">Configurações</span>
              </button>

              <button
                onClick={() => navigate("/redifinir-senha")}
                className="w-full px-4 py-3 text-left hover:bg-gray-50 transition-colors flex items-center gap-3"
              >
                <FaKey className="text-gray-600" />
                <span className="text-gray-700">Senhas</span>
              </button>

              <button 
                onClick={toggleModoEscuro}
                className="w-full px-4 py-3 text-left hover:bg-gray-50 transition-colors flex items-center justify-between"
              >
                <div className="flex items-center gap-3">
                  {modoEscuro ? (
                    <FaSun className="text-yellow-500" />
                  ) : (
                    <FaMoon className="text-gray-600" />
                  )}
                  <span className="text-gray-700">Modo Escuro</span>
                </div>
                <div className={`w-11 h-6 rounded-full transition-colors ${modoEscuro ? 'bg-orange-500' : 'bg-gray-300'}`}>
                  <div className={`w-4 h-4 rounded-full bg-white mt-1 transition-transform ${modoEscuro ? 'translate-x-6 ml-1' : 'translate-x-1'}`}></div>
                </div>
              </button>
            </div>
          </div>
        </>
      )}

      <ContactAdm isOpen={isAdminModalOpen} onClose={() => setIsAdminModalOpen(false)} />
    </div>
  );
}

export default Account;