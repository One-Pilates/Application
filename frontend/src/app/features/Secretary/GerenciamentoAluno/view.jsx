import React from "react";
import {
  FiArrowLeft,
  FiArrowRight,
  FiFilter,
  FiSearch,
  FiTrash2,
  FiDownload
} from "react-icons/fi";
import Botao from "../../../shared/components/Button";
import { abrirModalDownload } from "./components/Export";

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
      <div className="flex flex-col gap-6 py-6 px-16 h-full mx-auto">

        <div className="flex w-full justify-between items-center">
          <h1 className="text-3xl font-bold">Gerenciamento de Aluno</h1>

          <Botao
            onClick={() => navigate("/secretaria/aluno/cadastrar")}
            cor="bg-blue-500"
            texto={"Adicionar Aluno"}
          />
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
              className="w-full pl-10 pr-8 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-orange-500"
            />
          </div>

          <div className="flex items-center gap-3">

            <button
              onClick={() => abrirModalDownload(filteredStudents, calculateAge)}
              className="flex items-center gap-2 px-4 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition focus:outline-none focus:ring-2 focus:ring-orange-500"
            >
              <FiDownload size={20} />
              <span>Exportar</span>
            </button>

            <div className="relative">
              <FiFilter
                size={18}
                className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-600 pointer-events-none"
              />
              <select
                onChange={(e) => setStatusFilter(e.target.value)}
                className="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 appearance-none"
              >
                <option value="todos">Status: Todos</option>
                <option value="ativo">Status: Ativo</option>
                <option value="inativo">Status: Inativo</option>
              </select>
            </div>

          </div>



        </div>


        <div className="bg-white rounded-xl shadow-md border border-gray-200 flex flex-col overflow-hidden">
          <div className="overflow-x-auto flex-1">
            <table className="w-full table-fixed">
              <thead className="bg-gray-100 border-b border-gray-300">
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
                      className="hover:bg-gray-100 transition"
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
                          className={`inline-flex px-3 py-1 rounded-full text-xs font-medium ${aluno.status
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
                          <span className="inline-flex px-3 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-400">
                            Não
                          </span>
                        )}
                      </td>

                      <td className="px-6 py-4">
                        <div className="flex gap-2 justify-center">
                          <button
                            onClick={() => deleteAluno(aluno.id)}
                            className="p-2 text-red-600 hover:bg-red-100 rounded-lg transition"
                          >
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


          {filteredStudents && filteredStudents.length > 0 && (
            <div className="px-6 py-4 border-t border-gray-200 bg-gray-50 flex items-center justify-between">
              <div className="text-sm text-gray-800">
                Mostrando {startIndex + 1} a {Math.min(endIndex, filteredStudents.length)} de{" "}
                {filteredStudents.length} alunos
              </div>

              <div className="flex items-center gap-2">

                <button
                  onClick={() => setCurrentPage((prev) => Math.max(1, prev - 1))}
                  disabled={currentPage === 1}
                  className="p-2 rounded-lg bg-white text-gray-600 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition"
                >
                  <FiArrowLeft size={18} />
                </button>


                <div className="flex items-center gap-1">
                  {(() => {
                    const pages = [];
                    const total = totalPages;

                    const renderPage = (p) => (
                      <button
                        key={p}
                        onClick={() => setCurrentPage(p)}
                        className={`w-10 h-10 rounded-full text-sm font-medium transition ${currentPage === p
                            ? "bg-orange-500 text-white shadow-md"
                            : "bg-white text-gray-700 hover:bg-gray-100"
                          }`}
                      >
                        {p}
                      </button>
                    );


                    pages.push(renderPage(1));


                    if (currentPage > 3) {
                      pages.push(
                        <span key="dots1" className="px-2 text-gray-500">
                          …
                        </span>
                      );
                    }

                    const start = Math.max(2, currentPage - 1);
                    const end = Math.min(total - 1, currentPage + 1);

                    for (let p = start; p <= end; p++) {
                      pages.push(renderPage(p));
                    }


                    if (currentPage < total - 2) {
                      pages.push(
                        <span key="dots2" className="px-2 text-gray-500">
                          …
                        </span>
                      );
                    }

                    if (total > 1) pages.push(renderPage(total));

                    return pages;
                  })()}
                </div>

                <button
                  onClick={() =>
                    setCurrentPage((prev) => Math.min(totalPages, prev + 1))
                  }
                  disabled={currentPage === totalPages}
                  className="p-2 rounded-lg bg-white text-gray-600 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed transition"
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