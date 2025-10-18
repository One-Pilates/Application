import { useState, useRef, useEffect } from "react";
import axios from "axios";

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
    },
  });

  const [profileImage, setProfileImage] = useState("");
  const [editavel, setEditavel] = useState(false);
  const fileInputRef = useRef(null);

  useEffect(() => {
    const fetchData = async () => {
      console.warn("API desativada, usando dados locais.");
      setDadosProfessor({
        nome: "Fulano de Tal",
        cargo: "Professor de Pilates",
        email: "fulano@onepilates.com",
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
        },
      });
    };

    fetchData();
  }, []);

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

  const handleEditInput = () => setEditavel(!editavel);

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
  };

  const handleCancelar = () => {
    console.log("Edição cancelada.");
  };

  return {
    dadosProfessor,
    setDadosProfessor,
    profileImage,
    editavel,
    fileInputRef,
    handleEditFotoClick,
    handleFileChange,
    handleEditInput,
    toggleEspecialidade,
    handleSalvar,
    handleCancelar,
  };
};
