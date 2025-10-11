import React, { useState } from "react";
import { FaChevronDown, FaCog, FaMoon, FaSun } from "react-icons/fa";

function Account() {
  const [menuAberto, setMenuAberto] = useState(false);
  const [modoEscuro, setModoEscuro] = useState(false);

  const toggleModoEscuro = () => {
    setModoEscuro(!modoEscuro);
    // aqui vai ficar a logica do modo escuro depois eu faço
  };

  return (
    <div className="relative">
      <button
        onClick={() => setMenuAberto(!menuAberto)}
        className="flex items-center gap-3 px-2 py-2 rounded-lg hover:bg-gray-100 transition-colors"
      >
        <img
          src="https://i.pravatar.cc/150?img=45"
          alt="Perfil"
          className="w-10 h-10 rounded-full ring-2 ring-orange-500"
        />
        <div className="hidden md:block text-left">
          <p className="font-semibold text-gray-800">Flavia Lima Silva</p>
          <p className="text-xs text-gray-500">Fisioterapeuta</p>
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
          
          <div className="absolute right-0 mt-2 w-64 bg-white rounded-lg shadow-lg border border-gray-200 z-50 overflow-hidden">
            <div className="bg-gradient-to-r from-orange-500 to-orange-600 p-4">
              <div className="flex items-center gap-3">
                <img
                  src="https://i.pravatar.cc/150?img=45"
                  alt="Perfil"
                  className="w-14 h-14 rounded-full ring-2 ring-white"
                />
                <div className="text-white">
                  <p className="font-bold text-lg">Flavia Lima Silva</p>
                  <p className="text-sm opacity-90">Fisioterapeuta</p>
                </div>
              </div>
            </div>

            <div className="py-2">
              <button 
                onClick={() => {
                  setMenuAberto(false);
                  //ação de configurações
                }}
                className="w-full px-4 py-3 text-left hover:bg-gray-50 transition-colors flex items-center gap-3"
              >
                <FaCog className="text-gray-600" />
                <span className="text-gray-700">Configurações</span>
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
    </div>
  );
}

export default Account;