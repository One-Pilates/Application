import { useState, useRef, useEffect } from 'react';
import axios from 'axios';

export const useProfileModel = () => {
  const [dadosProfessor, setDadosProfessor] = useState({
    nome: 'Carregando...',
    cargo: 'Carregando...',
    email: '',
    dataNascimento: '',
    telefone: '',
    senha: '',
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

  const [profileImage, setProfileImage] = useState(null); // null evita src=""
  const [editavel, setEditavel] = useState(false);
  const fileInputRef = useRef(null);

  useEffect(() => {
    const userId = 1; 
    const fetchProfile = async () => {
      try {
        const res = await axios.get(`/funcionarios/${userId}`);
        if (res.data) {
          setDadosProfessor({
            ...res.data,
            especialidades: res.data.especialidades || dadosProfessor.especialidades
          });
          setProfileImage(res.data.profileImage || null);
        }
      } catch (err) {
        console.error("Erro ao buscar dados do professor:", err);
        // manter valores padrão para mostrar a página
      }
    };
    fetchProfile();
  }, []);

  const handleEditFotoClick = () => {
    if (fileInputRef.current) fileInputRef.current.click();
  };

  const handleFileChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => setProfileImage(reader.result);
    reader.readAsDataURL(file);
  };

  const handleEditInput = () => setEditavel(!editavel);

  const toggleEspecialidade = (especialidade) => {
    setDadosProfessor(prev => ({
      ...prev,
      especialidades: {
        ...prev.especialidades,
        [especialidade]: !prev.especialidades[especialidade]
      }
    }));
  };

  const handleSalvar = () => alert('Perfil salvo com sucesso!');
  const handleCancelar = () => console.log('Cancelado');

  return {
    dadosProfessor,
    setDadosProfessor,
    profileImage,
    fileInputRef,
    editavel,
    handleEditFotoClick,
    handleFileChange,
    handleEditInput,
    toggleEspecialidade,
    handleSalvar,
    handleCancelar
  };
};
