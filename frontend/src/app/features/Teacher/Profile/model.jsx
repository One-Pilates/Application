import { useState, useRef, useEffect } from "react";
import { useAuth } from "../../../../hooks/useAuth";
import api from "../../../../provider/api"

export const useProfileTeacherModel = () => {
  const [dadosProfessor, setDadosProfessor] = useState({
    nome: "",
    cargo: "",
    email: "",
    dataNascimento: "",
    telefone: "",
    senha: "",
    receberNotificacao: false,
    especialidades: {
      fisioterapia: false,
      pilates: false,
      drenagem: false,
      rpg: false,
      massagem: false,
      massoterapia: false,
      acupuntura: false,
      osteopatia: false,
    },
  });
  const [profileImage, setProfileImage] = useState(
    "https://i.pravatar.cc/150?img=45"
  );
  const fileInputRef = useRef(null);
  const { user } = useAuth();
  const [originalDados, setOriginalDados] = useState(dadosProfessor);
  const [hasChanged, setHasChanged] = useState(false);


  useEffect(() => {
    const fetchData = async () => {
      if (!user) return;
      try {
        const response = await api.get(`api/professores/${user.id}`);
        const data = response.data;
        console.log('data', data);

        const especialidadesMap = {
          fisioterapia: false,
          pilates: false,
          drenagem: false,
          rpg: false,
          massagem: false,
          massoterapia: false,
          acupuntura: false,
          osteopatia: false,
        };

        if (Array.isArray(data.especialidades)) {
          data.especialidades.forEach((esp) => {
            const espToLower = esp.nome.toLowerCase();
            if (esp.nome && Object.prototype.hasOwnProperty.call(especialidadesMap, espToLower)) {
              console.log('Definindo especialidade: ', espToLower);
              especialidadesMap[espToLower] = true;
            }
          });
        }

        const dadosCarregados = {
          nome: data.nome || "",
          cargo: data.cargo || data.role || "",
          email: data.email || "",
          dataNascimento: data.idade || "",
          telefone: data.telefone || "",
          senha: "",
          receberNotificacao: data.notificacaoAtiva || false,
          especialidades: especialidadesMap,
        };

        setDadosProfessor(dadosCarregados);
        setOriginalDados(dadosCarregados);

        console.log('dadosProfessor carregados com sucesso, ', dadosProfessor);
        console.log('especialidades: ', dadosProfessor.especialidades);
      } catch (err) {
        console.error(err);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    const verificarMudancas = () => {
      if (JSON.stringify(dadosProfessor) !== JSON.stringify(originalDados)) {
        setHasChanged(true);
      } else {
        setHasChanged(false);
      }
    };
    verificarMudancas();
  }, [dadosProfessor, originalDados]);




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
    setHasChanged(false);
  }

  const toggleEspecialidade = (especialidade) => {
    setDadosProfessor((prev) => ({
      ...prev,
      especialidades: {
        ...prev.especialidades,
        [especialidade]: !prev.especialidades[especialidade],
      },
    }));
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
    cancelChanges
  };
};
