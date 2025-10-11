import { useState, useRef } from 'react';

export const useProfileModel = () => {
  const [dadosProfessor, setDadosProfessor] = useState({
    nome: 'Flavia Lima Silva',
    email: 'flavia@gmail.com',
    dataNascimento: 'xx/xx/xxxx',
    telefone: '(11) 96224 - 2005',
    senha: '4165HiLdo%!%',
    receberNotificacao: false,
    especialidades: {
      fisioterapia: true,
      pilates: true,
      drenagem: true,
      rPG: true,
      massagem: true,
      massoterapia: true,
      acupuntura: true
    }
  });

  const [profileImage, setProfileImage] = useState('https://i.pravatar.cc/150?img=45');
  const fileInputRef = useRef(null);

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

  const toggleEspecialidade = (especialidade) => {
    setDadosProfessor(prev => ({
      ...prev,
      especialidades: {
        ...prev.especialidades,
        [especialidade]: !prev.especialidades[especialidade]
      }
    }));
  };

  const handleSalvar = () => {
    console.log('Dados salvos:', dadosProfessor);
    alert('Perfil salvo com sucesso!');
  };

  const handleCancelar = () => {
    console.log('Cancelado');
  };

  return {
    dadosProfessor,
    setDadosProfessor,
    profileImage,
    setProfileImage,
    fileInputRef,
    handleEditFotoClick,
    handleFileChange,
    toggleEspecialidade,
    handleSalvar,
    handleCancelar
  };
};
