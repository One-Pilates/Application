import { FaEdit } from "react-icons/fa";
import { FiEdit, FiTrash2, FiX } from "react-icons/fi";
import Botao from "../../../shared/components/Button";

const ViewStudio = ({ 
  especialidades, 
  salas, 
  activeTab, 
  setActiveTab, 
  deleteEspecialidade,
  showEspModal,
  setShowEspModal,
  editingEsp,
  formEsp,
  setFormEsp,
  handleAddEsp,
  handleEditEsp,
  handleSaveEsp,
 }) => {
  return (
    <div className="flex flex-col gap-6 py-6 px-16 h-full mx-auto ml-auto">
      <div className="flex flex-row w-full items-center">
        <h1 className="text-3xl font-bold">Configurações do Studio</h1>
        {/* <Botao  onClick={()=> navigate("/secretaria/professor/cadastrar")} cor="bg-blue-500" texto={"Adicionar Professor"}></Botao> */}
      </div>
      <div className=" bg-white rounded-xl shadow mt-4 w-full h-auto py-6 px-16">
        {/* Tabs */}
        <div className="border-b-2">
          <nav className="flex">
            <button
              onClick={() => setActiveTab("especialidades")}
              className={`px-6 py-4 text-base font-medium border-b-4 transition-colors 
                ${activeTab === "especialidades" ? "border-orange-500 text-orange-600" : "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"}
                `}
            >
              Especialidades
            </button>
            <button
              onClick={() => setActiveTab("salas")}
              className={`px-6 py-4 text-base font-medium border-b-4 transition-colors
                ${activeTab === "salas" ? "border-orange-500 text-orange-600" : "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"}`}
            >
              Salas
            </button>
          </nav>
        </div>
        {/* Content */}
        <div className="p-6 max-h-96 overflow-y-auto pb-4">
          {activeTab === "especialidades" ? (
            <div>
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-semibold text-gray-800">
                  Especialidades Cadastradas
                </h2>
                <Botao onClick={handleAddEsp} cor="bg-blue-500" texto={"Nova Especialidade"} />
              </div>

              <div className="grid grid-cols-1 gap-4">
                {especialidades.map((esp) => (
                  <div
                    key={esp.id}
                    className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow"
                  >
                    <div className="flex justify-between items-center">
                      <h3 className="font-medium text-gray-900">{esp.nome}</h3>
                      <div className="flex gap-2">
                        <button className="p-2 text-blue-600 hover:bg-blue-100 rounded-lg transition">
                          <FiEdit onClick={() => handleEditEsp(esp)} size={18} />
                        </button>
                        <button 
                        onClick={() => deleteEspecialidade(esp.id)}
                        className="p-2 text-red-600 hover:bg-red-100 rounded-lg transition">
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
                        <FiEdit size={18} />
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
      {/* Modal de Especialidade */}
    {showEspModal && (
      <div className="modal-overlay animate-slideUp">
          <div className="bg-white rounded-lg max-w-md w-full p-6 ">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-xl font-semibold text-gray-900">
                {editingEsp ? 'Editar Especialidade' : 'Nova Especialidade'}
              </h3>
              <button onClick={() => setShowEspModal(false)} className="text-gray-400 hover:text-gray-600">
                <FiX size={24} />
              </button>
            </div>

            <div className="mb-6">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Nome da Especialidade
              </label>
              <input
                type="text"
                value={formEsp}
                onChange={(e) => setFormEsp(e.target.value)}
                placeholder="Ex: Fisioterapia"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>

            <div className="flex gap-3 justify-end">
              <Botao
                onClick={() => setShowEspModal(false)}
                cor="bg-gray-500"
                texto="Cancelar"
              />
              <Botao
                onClick={handleSaveEsp}
                cor="bg-blue-600"
                texto="Salvar"
              />
            </div>
          </div>
        </div>
    )}
    </div>
  );
};

export default ViewStudio;
