import { FaEdit } from "react-icons/fa";
import { FiTrash2 } from "react-icons/fi";
import Botao from "../../../shared/components/Button";

const ViewStudio = ({ especialidades, salas, activeTab, setActiveTab }) => {
  return (
    <div className="flex flex-col gap-6 py-6 px-16 h-full mx-auto ml-auto">
      <div className="flex flex-row w-full items-center">
        <h1 className="text-3xl font-bold">Configurações do Studio</h1>
        {/* <Botao  onClick={()=> navigate("/secretaria/professor/cadastrar")} cor="bg-blue-500" texto={"Adicionar Professor"}></Botao> */}
      </div>
      <div className=" bg-white rounded-xl shadow mt-4 w-full h-auto py-4 px-8">
        {/* Tabs */}
        <div className="border-b ">
          <nav className="flex">
            <button
              onClick={() => setActiveTab("especialidades")}
              className={`px-6 py-4 text-base font-medium border-b-2 transition-colors
                `}
            >
              Especialidades
            </button>
            <button
              onClick={() => setActiveTab("salas")}
              className={`px-6 py-4 text-base font-medium border-b-2 transition-colors
                `}
            >
              Salas
            </button>
          </nav>
          <hr />
        </div>
        {/* Content */}
        <div className="p-6">
          {activeTab === "especialidades" ? (
            <div>
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-semibold text-gray-800">
                  Especialidades Cadastradas
                </h2>
                <Botao cor="bg-blue-500" texto={"Nova Especialidade"} />
              </div>

              <div className="grid grid-cols-1 gap-4">
                {especialidades.map((esp) => (
                  <div
                    key={esp.id}
                    className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
                  >
                    <div className="flex justify-between items-start">
                      <h3 className="font-medium text-gray-900">{esp.nome}</h3>
                      <div className="flex gap-2">
                        <button className="p-2 text-blue-600 hover:bg-blue-100 rounded-lg transition">
                          <FaEdit size={18} />
                        </button>
                        <button className="p-2 text-red-600 hover:bg-red-100 rounded-lg transition">
                          <FiTrash2 size={18} />
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ) : (
          <div>
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-xl font-semibold text-gray-800">
                Salas Cadastradas
              </h2>
              <Botao cor="bg-blue-500" texto={"Nova Sala"} />
            </div>

            <div className="grid grid-cols-1 gap-4">
              {salas.map((sala) => (
                <div
                  key={sala.id}
                  className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
                >
                  <div className="flex justify-between items-center mb-2">
                    <h3 className="font-medium text-gray-900">{sala.nome}</h3>
                  {/* <p className="text-sm text-gray-600">
                    Capacidade: até{" "}
                    <span className="font-semibold">{sala.capacidade}</span>{" "}
                    alunos
                  </p> */}
                    <div className="flex gap-2">
                      <button className="p-2 text-blue-600 hover:bg-blue-100 rounded-lg transition">
                        <FaEdit size={18} />
                      </button>
                      <button className="p-2 text-red-600 hover:bg-red-100 rounded-lg transition">
                        <FiTrash2 size={18} />
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default ViewStudio;
