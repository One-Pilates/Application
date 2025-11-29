import { useEffect, useState } from "react";
import api from "../../../../provider/api";
import Swal from "sweetalert2";

export const useStudioModel = () => {
  const [activeTab, setActiveTab] = useState("especialidades");

  // Especialidades States
  const [especialidades, setEspecialidades] = useState([]);
    // Modal Especialidades States
  const [showEspModal, setShowEspModal] = useState(false);
  const [editingEsp, setEditingEsp] = useState(null);
  const [formEsp, setFormEsp] = useState("");
  
  // Salas States
  const [salas, setSalas] = useState([]);
    // Modal Salas States
  const [showSalaModal, setShowSalaModal] = useState(false);
  const [editingSala, setEditingSala] = useState(null);
  const [formSala, setFormSala] = useState({ nome: '', quantidadeMaximaAlunos: '', quantidadeEquipamentosPCD: '' });

    useEffect(() => {
    fetchData();
  }, [activeTab]);

  
  // Funções Especialidades
  const handleAddEsp = () => {
    console.log("Adicionar Especialidade");
    setEditingEsp(null);
    setFormEsp('');
    setShowEspModal(true);
  };

  const handleEditEsp = (esp) => {
    setEditingEsp(esp);
    setFormEsp(esp.nome);
    setShowEspModal(true);
  };

  const handleSaveEsp = async() => {
    if (!formEsp.trim()) {
      Swal.fire({
        icon: "warning",
        title: "Atenção",
        text: "O nome da especialidade não pode estar vazio.",
        confirmButtonText: "OK",
      });
      return;
    }
    
    if (editingEsp) {
      try {
        const response = await api.patch(`api/especialidades/${editingEsp.id}`, {
          nome: formEsp
        });
        console.log("Especialidade atualizada:", response.data);
         setEspecialidades(especialidades.map(e => 
        e.id === editingEsp.id ? { ...e, nome: formEsp } : e
      ));
      Swal.fire({
        icon: "success",
        title: "Atualizado!",
        text: "A especialidade foi atualizada com sucesso.",
        confirmButtonText: "OK",
      });
      } catch (error) {
        console.error("Erro ao atualizar especialidade:", error);
        Swal.fire({
          icon: "error",
          title: "Erro",
          text: "Ocorreu um erro ao atualizar a especialidade.",
          confirmButtonText: "OK",
        });
      }
    } else {
      try {
        const response = await api.post(`api/especialidades`, {
          nome: formEsp
        });
        console.log("Especialidade criada:", response.data);
        Swal.fire({
          icon: "success",
          title: "Criado!",
          text: "A especialidade foi criada com sucesso.",
          confirmButtonText: "OK",
        });
        setEspecialidades([...especialidades, response.data]);
      } catch (error) {
        console.error("Erro ao criar especialidade:", error);
        Swal.fire({
          icon: "error",
          title: "Erro",
          text: "Ocorreu um erro ao criar a especialidade.",
          confirmButtonText: "OK",
        });
      }
    }
    setShowEspModal(false);
  };

  const handleDeleteEspecialidade = async (id) => {
     Swal.fire({
          title: "Tem certeza?",
          text: "Essa ação não poderá ser desfeita!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#d33",
          cancelButtonColor: "#3085d6",
          confirmButtonText: "Sim, deletar!",
          cancelButtonText: "Cancelar",
        }).then(async (result) => {
          if (result.isConfirmed) {
            try {
              const response = await api.delete(`api/especialidades/${id}`);
              console.log("Especialidade deletada:", response.data);
              setEspecialidades(especialidades.filter(esp => esp.id !== id));
              Swal.fire({
                icon: "success",
                title: "Deletado!",
                text: "A especialidade foi deletada com sucesso.",
                confirmButtonText: "OK",
              });
              
            } catch (error) {
              console.error("Erro ao deletar especialidade:", error);
              Swal.fire({
                icon: "error",
                title: "Erro",
                text: "Ocorreu um erro ao deletar a especialidade.",
                confirmButtonText: "OK",
              });
            }
          }
        });
    };

  // Funções Salas
  const handleAddSala = () => {
    setEditingSala(null);
    setFormSala({ nome: '', quantidadeMaximaAlunos: '', quantidadeEquipamentosPCD: '' });
    setShowSalaModal(true);
  };

  const handleEditSala = (sala) => {
    setEditingSala(sala);
    setFormSala({ nome: sala.nome, quantidadeMaximaAlunos: sala.quantidadeMaximaAlunos, quantidadeEquipamentosPCD: sala.quantidadeEquipamentosPCD });
    setShowSalaModal(true);
  };

  const handleSaveSala = () => {
    if (!formSala.nome.trim() || !formSala.quantidadeMaximaAlunos || !formSala.quantidadeEquipamentosPCD) return;
    
    if (editingSala) {
      setSalas(salas.map(s => 
        s.id === editingSala.id ? { ...s, ...formSala, capacidade: Number(formSala.capacidade) } : s
      ));
    } else {
      setSalas([...salas, { id: Date.now(), ...formSala, capacidade: Number(formSala.capacidade) }]);
    }
    setShowSalaModal(false);
  };

  const handleDeleteSala = (id) => {
    Swal.fire({
          title: "Tem certeza?",
          text: "Essa ação não poderá ser desfeita!",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#d33",
          cancelButtonColor: "#3085d6",
          confirmButtonText: "Sim, deletar!",
          cancelButtonText: "Cancelar",
        }).then(async (result) => {
          if (result.isConfirmed) {
            try {
              const response = await api.delete(`api/salas/${id}`);
              console.log("Sala deletada:", response.data);
              setSalas(salas.filter(s => s.id !== id));
              Swal.fire({
                icon: "success",
                title: "Deletado!",
                text: "A sala foi deletada com sucesso.",
                confirmButtonText: "OK",
              });
              
            } catch (error) {
              console.error("Erro ao deletar sala:", error);
              Swal.fire({
                icon: "error",
                title: "Erro",
                text: "Ocorreu um erro ao deletar a sala.",
                confirmButtonText: "OK",
              });
            }
          }
        });
  };

  const fetchData = async () => {
    if (activeTab === "especialidades") {
      try {
        const response = await api.get(`api/especialidades`);
        const data = response.data;
        setEspecialidades(data);
      } catch (error) {
        console.error("Erro ao buscar especialidades:", error);
      }
      } else if (activeTab === 'salas') {
        try {
          const response = await api.get(`api/salas`);
          const data = response.data
          setSalas(data)
        } catch (error) {
          console.error("Erro ao buscar salas:", error);
        }
    }
  };


  return {
    especialidades,
    setEspecialidades,
    salas,
    setSalas,
    activeTab,
    setActiveTab,
    handleDeleteEspecialidade,
    showEspModal,
    setShowEspModal,
    editingEsp,
    setEditingEsp,
    formEsp,
    setFormEsp,
    handleAddEsp,
    handleEditEsp,
    handleSaveEsp,
    showSalaModal,
    setShowSalaModal,
    editingSala,
    setEditingSala,
    formSala,
    setFormSala,
    handleAddSala,
    handleEditSala,
    handleSaveSala,
    handleDeleteSala,
  };
};
