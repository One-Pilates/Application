import React from "react";
import { FiArrowLeft, FiArrowRight, FiEdit2, FiFilter, FiSearch, FiTrash2 } from "react-icons/fi";
import Botao from "../../../shared/components/Button";

const GerenciamentoAlunoView = ({
  filteredStudents,
  currentStudents,
  setFilterByNome,
  setStatusFilter,
  currentPage,
  setCurrentPage,
  totalPages,
  startIndex,
  endIndex,
  calculateAge,
  deleteAluno,
  navigate,
}) => {
  return (
    <>
      <div className="flex flex-col gap-6 py-6 px-16  h-full mx-auto ml-auto">
        <div className="flex flex-row w-full justify-between items-center">
          <h1 className="text-3xl font-bold">Gerenciamento de Aluno</h1>
          <Botao onClick={()=> navigate("/secretaria/aluno/cadastrar")}  cor="bg-blue-500" texto={"Adicionar Aluno"}></Botao>
        </div>
        <div className="flex w-full items-center gap-4 justify-between">
          <div className="relative w-80">
            <FiSearch
              className="absolute left-3 top-1/2 transform -translate-y-1/2 text-orange-500"
              size={20}
            />
            <input
              type="text"
              onChange={(e) => setFilterByNome(e.target.value)}
              placeholder="Buscar por nome"
              className="w-full pl-10 pr-8 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500 focus:border-transparent"
            />
          </div>
          <div className="flex items-center gap-2">
            <FiFilter size={20} className="text-gray-600" />
            <select
              onChange={(e) => setStatusFilter(e.target.value)}
              className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="todos">Status: Todos</option>
              <option value="ativo">Status: Ativo</option>
              <option value="inativo">Status: Inativo</option>
            </select>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm border border-gray-200 flex flex-col">
          <div className="overflow-x-auto flex-1">
            <table className="w-full table-fixed">
              <thead className="bg-gray-50 border-b border-gray-200">
                <tr>
                  <th className="w-[20%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    Nome do Aluno
                  </th>
                  <th className="w-[20%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    Email
                  </th>
                  <th className="w-[12%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    CPF
                  </th>
                  <th className="w-[8%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    Idade
                  </th>
                  <th className="w-[12%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    Status
                  </th>
                  <th className="w-[12%] px-6 py-4 text-left text-sm font-semibold text-gray-900">
                    Limitações
                  </th>
                  <th className="w-[16%] px-6 py-4 text-center text-sm font-semibold text-gray-900">
                    Ações
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {currentStudents && currentStudents.length > 0 ? (
                  currentStudents.map((aluno) => (
                    <tr
                      key={aluno.id}
                      className="hover:bg-gray-50 transition-colors"
                    >
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {aluno.nome}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {aluno.email}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {aluno.cpf}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {calculateAge(aluno.dataNascimento)}
                      </td>
                      <td className="px-6 py-4">
                        <span
                          className={`inline-flex px-3 py-1 rounded-full text-xs font-medium ${
                            aluno.status
                              ? "bg-green-100 text-green-700"
                              : "bg-red-100 text-red-700"
                          }`}
                        >
                          {aluno.status ? "Ativo" : "Inativo"}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        {aluno.alunoComLimitacoesFisicas ? (
                          <span className="inline-flex px-3 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                            Sim
                          </span>
                        ) : (
                          <span className="inline-flex px-3 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-400 ">Não</span>
                        )}
                      </td>
                      <td className="px-6 py-4">
                        <div className="flex gap-2 justify-center">
                          {/* <button className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors">
                            <FiEdit2 size={18} />
                          </button> */}
                          <button onClick={() => deleteAluno(aluno.id)} className="p-2 text-red-600 hover:bg-red-100 rounded-lg transition-colors">
                            <FiTrash2 size={18} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td
                      colSpan="7"
                      className="px-6 py-12 text-center text-sm text-gray-500"
                    >
                      Nenhum aluno encontrado.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* pagination */}
          {filteredStudents && filteredStudents.length > 0 && (
            <div className="px-6 py-4 border-t border-gray-200 bg-gray-50 flex items-center justify-between">
              <div className="text-sm text-gray-800">
                Mostrando {startIndex + 1} a {Math.min(endIndex, filteredStudents.length)} de {filteredStudents.length} alunos
              </div>
              
              <div className="flex items-center gap-2">
                <button
                  onClick={() => setCurrentPage(prev => Math.max(1, prev - 1))}
                  disabled={currentPage === 1}
                  className="p-2 text-sm text-gray-700 bg-white hover:text-gray-950 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  <FiArrowLeft size={18} />
                </button>
                
                <div className="flex gap-1">
                  {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
                    <button
                      key={page}
                      onClick={() => setCurrentPage(page)}
                      className={`w-10 h-10 rounded-full text-sm font-medium transition-colors ${
                        currentPage === page
                          ? 'bg-orange-500 text-white'
                          : ' text-gray-700 hover:bg-gray-50'
                      }`}
                    >
                      {page}
                    </button>
                  ))}
                </div>

                <button
                  onClick={() => setCurrentPage(prev => Math.min(totalPages, prev + 1))}
                  disabled={currentPage === totalPages}
                  className="p-2 text-sm text-gray-700 bg-white hover:text-gray-950 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  <FiArrowRight size={18} />
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default GerenciamentoAlunoView;
