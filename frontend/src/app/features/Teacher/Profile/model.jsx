import { useState, useRef, useEffect} from "react";
import { useAuth } from "../../../../hooks/useAuth";
import api from "../../../../provider/api"
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";

export const useProfileUserModel = () => {
  const { user, setUser } = useAuth();
  const [dadosUser, setDadosUser] = useState({
    nome:  "",
    cargo: "",
    role: "",
    email: "",
    dataNascimento: "",
    telefone: "",
    receberNotificacao: false,
  });
  const [profileImage, setProfileImage] = useState(
    "https://i.pravatar.cc/150?img=45"
  );
  const fileInputRef = useRef(null);
  const [originalDados, setOriginalDados] = useState(dadosUser);
  const [hasChanged, setHasChanged] = useState(false);
  const [especialidadesMap, setEspecialidadesMap] = useState([]);
  const [especialidadesSelecionadas, setEspecialidadesSelecionadas] = useState(new Set());
  const navigate = useNavigate();
  const [especialidadesOriginais, setEspecialidadesOriginais] = useState(new Set());

  useEffect(() => {
    const fetchData = async () => {
      if (!user || user.role !== 'PROFESSOR') return;
      try {
        const especialidadesResponse = await api.get(`api/especialidades`);
        const especialidadesData = especialidadesResponse.data;

        console.log('especialidadesData', especialidadesData);
        console.log('professorEspecialidadedata', user.especialidades);

        if (user.especialidades && Array.isArray(user.especialidades)) {
          const idsEspecialidadesProfessor = new Set(
            user.especialidades.map(esp => esp.id)
          );
          setEspecialidadesSelecionadas(idsEspecialidadesProfessor);
          setEspecialidadesOriginais(new Set(idsEspecialidadesProfessor));
        }

        setEspecialidadesMap(especialidadesData);

      } catch (err) {
        console.error('Erro ao carregar especialidades:', err);
      }
    };
    fetchData();
  }, [user]);

  useEffect(() => {
    const dadosAtuais = {
          nome: user?.nome || "",
          cargo: user?.cargo || "",
          role: user?.role || "",
          email: user?.email || "",
          dataNascimento: user?.idade || user?.dataNascimento || "",
          telefone: user?.telefone || "",
          receberNotificacao: user?.notificacaoAtiva ?? user?.receberNotificacao ?? false,
        };

        setDadosUser(dadosAtuais);
        setOriginalDados(dadosAtuais);

        console.log('dadosUser carregados com sucesso');
  }, [user]);

  useEffect(() => {
    const verificarMudancas = () => {
      const dadosMudaram = JSON.stringify(dadosUser) !== JSON.stringify(originalDados);

      const especialidadesMudaram = 
        dadosUser.role === 'PROFESSOR' && (
          especialidadesSelecionadas.size !== especialidadesOriginais.size ||
          ![...especialidadesSelecionadas].every(id => especialidadesOriginais.has(id))
        );
      
      if (dadosMudaram || especialidadesMudaram) {
        setHasChanged(true);
      } else {
        setHasChanged(false);
      }
    };
    verificarMudancas();
  }, [dadosUser, originalDados, especialidadesSelecionadas, especialidadesOriginais]);

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
    setDadosUser(originalDados);
    if (user.role === 'PROFESSOR') {
      setEspecialidadesSelecionadas(new Set(especialidadesOriginais));
    }
    setHasChanged(false);
  }

  const saveChanges = async () => {
    if (!hasChanged) {
      console.log("Nenhuma alteração detectada");
      return;
    }

    const emailAlterado = dadosUser.email !== originalDados.email;

    try {
      const userDTO = {
        nome: dadosUser.nome.trim(),
        email: dadosUser.email,
        idade: dadosUser.dataNascimento,
        telefone: dadosUser.telefone,
        notificacaoAtiva: dadosUser.receberNotificacao,
      };

      if (user.role === 'PROFESSOR') {
        userDTO.especialidadeIds = Array.from(especialidadesSelecionadas);
      }

      let endpoint = '';
      switch (user.role) {
        case 'PROFESSOR':
          endpoint = `api/professores/${user.id}`;
          break;
        case 'ADMINISTRADOR':
          endpoint = `api/administradores/${user.id}`;
          break;
        case 'SECRETARIA':
          endpoint = `api/secretarias/${user.id}`;
          break;
        default:
          throw new Error('Role não reconhecida');
      }

      console.log("Enviando dados para atualização:", userDTO);
      console.log("Endpoint:", endpoint);

      const response = await api.patch(endpoint, userDTO);
      const data = response.data;
      
      console.log("✅ Dados atualizados com sucesso:", data);

      setOriginalDados(dadosUser);
      setEspecialidadesOriginais(new Set(especialidadesSelecionadas));
      
      setUser(data);
      localStorage.setItem("user", JSON.stringify(data));
      
      setHasChanged(false);

      if (emailAlterado) {
        await Swal.fire({
          icon: 'success',
          title: 'Perfil atualizado!',
          text: 'Seu email foi alterado. Por segurança, você precisa fazer login novamente.',
          confirmButtonText: 'OK',
        });
        localStorage.removeItem("token");
        localStorage.removeItem("user");
        setUser(null);
        navigate("/login");
      } else {
        Swal.fire({
          icon: 'success',
          title: 'Perfil atualizado!',
          text: 'Seus dados foram atualizados com sucesso.',
          confirmButtonText: 'OK',
        });
      }
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
      } else {
        novoSet.add(especialidadeId);
      }
      return novoSet;
    });
  };
  
  const isEspecialidadeSelecionada = (especialidadeId) => {
    return especialidadesSelecionadas.has(especialidadeId);
  };

  return {
    dadosUser,
    setDadosUser,
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
