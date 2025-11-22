import React from "react";
import { FiSearch, FiPhone, FiMail, FiTrash2, FiCalendar } from "react-icons/fi";
import Botao from "../../../shared/components/Button";
import api from "../../../../provider/api";
import userIconImg from "/user-icon.png";

const GerenciamentoProfessorView = ({
  professores,
  user,
  deletarProfessor,
  filterByNome,
}) => {
  return (
    <>
      <div className="flex flex-col gap-6 py-6 px-16  h-full mx-auto ml-auto">
        {/* Titulo mais botão criar professor */}
        <div className="flex flex-row w-full justify-between items-center">
          <h1 className="text-3xl font-bold">Gerenciamento de Professor</h1>
          {user && user.role === 'ADMINISTRADOR' && 
            <Botao cor="bg-blue-500" texto={"Adicionar Professor"}></Botao>
          }
        </div>

        <div className="relative w-80">
          <FiSearch
            className="absolute left-3 top-1/2 transform -translate-y-1/2 text-orange-500"
            size={20}
          />
          <input
            type="text"
            placeholder="Buscar por nome"
            onChange={filterByNome}
            className="w-full pl-10 pr-8 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent"
          />
        </div>

        {/* Container de cards de professores - Área scrollável */}
        <div className=" mt-2 w-full h-auto max-h-90 overflow-y-auto pb-4">
          {professores && professores.length > 0 ? (
            professores.map((professor) => (
              <div 
                key={professor.id}
                className="flex flex-col bg-white mb-6 rounded-2xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300"
              >
            
                {/* ===== PARTE SUPERIOR DO CARD ===== */}
                <div className="flex items-start justify-between mb-4">
                  {/* ===== SEÇÃO ESQUERDA: Informações do Professor ===== */}
                  <div className="flex items-center gap-4">
                
                    <button className="group relative flex-shrink-0">
                      <img
                        src={professor.foto ? `${api.defaults.baseURL}/api/imagens/${professor.foto}` : userIconImg}
                        alt={professor.nome}
                        className="w-24 h-24 rounded-full object-cover ring-4 ring-orange-200 group-hover:ring-orange-400 transition-all duration-300"
                      />
                    </button>
                
                    {/* Container de textos (nome, status, cargo) */}
                    <div className="flex flex-col gap-2">
                  
                      {/* Linha superior: Nome + Badge de Status */}
                      <div className="flex flex-row items-center gap-3">
                        <h2 className="text-3xl font-bold text-orange-600 hover:text-orange-700 cursor-pointer transition-colors">
                          {professor.nome}
                        </h2>
                        <span className={`px-3 py-1 ${professor.status ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'} rounded-full text-sm font-semibold`}>
                          {professor.status ? 'Ativo' : 'Inativo'}
                        </span>
                      </div>
                  
                      {/* Cargo/Especialidade */}
                      <p className="text-gray-600 text-base">{professor.cargo || 'Professor'}</p>
                    </div>
                
                  </div>
                  {/* ===== SEÇÃO DIREITA: Botão de Ação ===== */}
                  <button className="group flex items-center gap-2 px-5 py-3 bg-orange-500 text-white rounded-xl font-semibold transition-all ease-in-out shadow-sm hover:bg-white hover:text-orange-500 hover:shadow-md">
                    <span>Ver agenda</span>
                    <FiCalendar className="group-hover:text-orange-500" size={18} />
                  </button>
                </div>

                {/* ===== PARTE INFERIOR DO CARD ===== */}
                <div className="flex items-center justify-between pt-4 border-t border-gray-200">
              
                  {/* Coluna Esquerda: Contato e Especialidades */}
                  <div className="flex flex-col gap-3">
                    {/* Contato: Telefone e Email */}
                    <div className="flex items-center gap-6">
                      <div className="flex items-center gap-2 text-gray-700">
                        <FiPhone className="text-orange-500" size={18} />
                        <span className="text-sm">{professor.telefone || 'Sem telefone'}</span>
                      </div>
                      <div className="flex items-center gap-2 text-gray-700">
                        <FiMail className="text-orange-500" size={18} />
                        <span className="text-sm">{professor.email}</span>
                      </div>
                    </div>

                    {/* Tags de Especialidades */}
                    <div className="flex gap-2 flex-wrap">
                      {professor.especialidades && professor.especialidades.length > 0 ? (
                        professor.especialidades.map((esp) => (
                          <span 
                            key={esp.id}
                            className="px-3 py-1 bg-orange-100 text-orange-700 rounded-full text-sm font-medium"
                          >
                            {esp.nome}
                          </span>
                        ))
                      ) : (
                        <span className="text-sm text-gray-500">Sem especialidades</span>
                      )}
                    </div>
                  </div>

                  {/* Botão Deletar */}
                  {user && user.role === 'ADMINISTRADOR' && 
                  <button onClick={()=> deletarProfessor(professor.id)} className="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                    <FiTrash2 size={24} />
                  </button>
                  } 
                </div>
              </div>
            ))
          ) : (
            <div className="flex items-center justify-center h-40 text-gray-500">
              Nenhum professor encontrado
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default GerenciamentoProfessorView;
