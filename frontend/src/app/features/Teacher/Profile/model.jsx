import { useState, useRef, useEffect } from "react";
import { useAuth } from "../../../../hooks/useAuth";
import api from "../../../../provider/api"
import Swal from "sweetalert2";

export const useProfileTeacherModel = () => {
  const [dadosProfessor, setDadosProfessor] = useState({
    nome: "",
    cargo: "",
    email: "",
    dataNascimento: "",
    telefone: "",
    receberNotificacao: false,
  });
  const [profileImage, setProfileImage] = useState(
    "https://i.pravatar.cc/150?img=45"
  );
  const fileInputRef = useRef(null);
  const { user } = useAuth();
  const [originalDados, setOriginalDados] = useState(dadosProfessor);
  const [hasChanged, setHasChanged] = useState(false);
  const [especialidadesMap, setEspecialidadesMap] = useState([]);
  const [especialidadesSelecionadas, setEspecialidadesSelecionadas] = useState(new Set());
  const [especialidadesOriginais, setEspecialidadesOriginais] = useState(new Set());

  useEffect(() => {
    const fetchData = async () => {
      if (!user) return;
      try {
        const response = await api.get(`api/professores/${user.id}`);
        const data = response.data;
        console.log('data', data);

        const especialidadesResponse = await api.get(`api/especialidades`);
        const especialidadesData = await especialidadesResponse.data;
        console.log('especialidadesData', especialidadesData);
        console.log('professorEspecialidadedata', data.especialidades);

        const dadosCarregados = {
          nome: data.nome || "",
          cargo: data.cargo || data.role || "",
          email: data.email || "",
          dataNascimento: data.idade || "",
          telefone: data.telefone || "",
          receberNotificacao: data.notificacaoAtiva || false,
        };
        
        if (data.especialidades) {
          const idsEspecialidadesProfessor = new Set(
            data.especialidades.map(esp => esp.id)
          
          );
          setEspecialidadesSelecionadas(idsEspecialidadesProfessor);
          setEspecialidadesOriginais(new Set(idsEspecialidadesProfessor));
        }

        setDadosProfessor(dadosCarregados);
        setOriginalDados(dadosCarregados);
        setEspecialidadesMap(especialidadesData);

        console.log('dadosProfessor carregados com sucesso');
      } catch (err) {
        console.error(err);
      }
    };
    fetchData();
  }, [user]);

  useEffect(() => {
    const verificarMudancas = () => {
      const dadosMudaram = JSON.stringify(dadosProfessor) !== JSON.stringify(originalDados);
      
      const especialidadesMudaram = 
        especialidadesSelecionadas.size !== especialidadesOriginais.size ||
        ![...especialidadesSelecionadas].every(id => especialidadesOriginais.has(id));
      
      if (dadosMudaram || especialidadesMudaram) {
        setHasChanged(true);
      } else {
        setHasChanged(false);
      }
    };
    verificarMudancas();
  }, [dadosProfessor, originalDados, especialidadesSelecionadas, especialidadesOriginais]);

  const handleEditFotoClick = () => {
    if (fileInputRef.current) fileInputRef.current.click();
  };

  const handleFileChange = (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => setProfileImage(reader.result);
    reader.readAsDataURL(file);
  };

  const cancelChanges = () => {
    setDadosProfessor(originalDados);
    setEspecialidadesSelecionadas(new Set(especialidadesOriginais));
    setHasChanged(false);
  }

  const saveChanges = async () => {
    if (!hasChanged) {
      console.log("Nenhuma alteração detectada");
      return;
    }

    try {
      const professorDTO = {
        nome: dadosProfessor.nome,
        email: dadosProfessor.email,
        idade: dadosProfessor.dataNascimento,
        notificacaoAtiva: dadosProfessor.receberNotificacao,
        especialidadeIds: Array.from(especialidadesSelecionadas),
      };

      const response = await api.patch(`api/professores/${user.id}`, professorDTO);
      const data = response.data;
      
      console.log("✅ Dados atualizados com sucesso:", data);
      console.log("Headers da resposta:", response.headers);

      setOriginalDados(dadosProfessor);
      setEspecialidadesOriginais(new Set(especialidadesSelecionadas));
      setHasChanged(false);

      Swal.fire({
        icon: 'success',
        title: 'Perfil atualizado!',
        text: 'Seus dados foram atualizados com sucesso.',
        confirmButtonText: 'OK',

      });
    } catch (error) {
      Swal.fire({
        icon: 'error',
        title: 'Erro ao atualizar perfil',
        text: 'Ocorreu um erro ao atualizar seus dados. Por favor, tente novamente mais tarde.',
        confirmButtonText: 'OK',
      });
      console.error("========== ERRO ==========");
      console.error("❌ Erro ao atualizar dados:", error.message);
      console.error("Status HTTP:", error.response?.status);
      console.error("Mensagem do backend:", error.response?.data);
      console.error("Token usado na requisição:", error.config?.headers?.Authorization?.substring(0, 50) + "...");
    }
  };

  const toggleEspecialidade = (especialidadeId) => {
    setEspecialidadesSelecionadas((prev) => {
      const novoSet = new Set(prev);
      
      if (novoSet.has(especialidadeId)) {
        novoSet.delete(especialidadeId);
        console.log(`Especialidade ${especialidadeId} desmarcada`);
      } else {
        novoSet.add(especialidadeId);
        console.log(`Especialidade ${especialidadeId} marcada`);
      }
      
      console.log('Especialidades atuais:', Array.from(novoSet));
      return novoSet;
    });
  };
  
  const isEspecialidadeSelecionada = (especialidadeId) => {
    return especialidadesSelecionadas.has(especialidadeId);
  };

  return {
    dadosProfessor,
    setDadosProfessor,
    profileImage,
    fileInputRef,
    handleEditFotoClick,
    handleFileChange,
    hasChanged,
    toggleEspecialidade,
    isEspecialidadeSelecionada,
    cancelChanges,
    especialidadesMap,
    saveChanges
  };
};
