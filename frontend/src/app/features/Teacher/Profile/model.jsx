import { useState, useRef, useEffect } from "react";

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
      rPG: false,
      massagem: false,
      massoterapia: false,
      acupuntura: false,
      osteopatia: false,
    },
  });

  const [profileImage, setProfileImage] = useState("https://i.pravatar.cc/150?img=45");;
  const [originalDados, setOriginalDados] = useState(null);
  const [hasChanges, setHasChanges] = useState(false);
  const fileInputRef = useRef(null);

  useEffect(() => {
    const fetchData = async () => {
      console.warn("API desativada, usando dados locais.");
      const initialData = {
        nome: "Flavia Lima Silva",
        cargo: "Professor",
        email: "flavia@onepilates.com",
        dataNascimento: "1988-06-15",
        telefone: "(11) 91234-5678",
        senha: "********",
        receberNotificacao: true,
        especialidades: {
          fisioterapia: true,
          pilates: true,
          drenagem: false,
          rPG: false,
          massagem: true,
          massoterapia: false,
          acupuntura: false,
          osteopatia: false,
        },
      };

      setDadosProfessor(initialData);
      // guarda cópia original para comparação de alterações
      setOriginalDados(initialData);
    };
    fetchData();
  }, []);

  const handleEditFotoClick = () => {
    if (fileInputRef.current) fileInputRef.current.click();
  };
  
  useEffect(() => {
    if (!originalDados) {
      setHasChanges(false);
      return;
    }
    try {
      setHasChanges(JSON.stringify(dadosProfessor) !== JSON.stringify(originalDados));
    } catch {
      setHasChanges(false);
    }
  }, [dadosProfessor, originalDados]);

  const handleFileChange = (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => setProfileImage(reader.result);
    reader.readAsDataURL(file);
  };

  const toggleEspecialidade = (especialidade) => {
    setDadosProfessor((prev) => ({
      ...prev,
      especialidades: {
        ...prev.especialidades,
        [especialidade]: !prev.especialidades[especialidade],
      },
    }));
  };

  const handleSalvar = () => {
    console.log("Dados salvos:", dadosProfessor);
    alert("Perfil salvo com sucesso!");
    // após salvar, atualiza a cópia original para refletir que não há mais mudanças
    setOriginalDados(dadosProfessor);
  };

  const handleCancelar = () => {
    console.log("Edição cancelada.");
    // restaurar os dados originais e resetar o estado de alterações
    if (originalDados) {
      setDadosProfessor(originalDados);
      setHasChanges(false);
    }
  };

  return {
    dadosProfessor,
    setDadosProfessor,
    profileImage,
    fileInputRef,
    handleEditFotoClick,
    handleFileChange,
    toggleEspecialidade,
    handleSalvar,
    handleCancelar,
    hasChanges,
  };
};
