import React, { useState, useRef, useEffect } from 'react';
import { FaPen } from 'react-icons/fa';
import './styles/ProfileTeacher.scss';
import axios from 'axios';
// import { ca } from 'date-fns/locale';

const ProfileTeacher = () => {
  const [dadosProfessor, setDadosProfessor] = useState([]);
  const [profileImage, setProfileImage] = useState('');
  const [editavel, setEditavel] = useState(false);
  const fileInputRef = useRef(null);

  useEffect(()=>{
    axios.get("/funcionarios/${userId)")
    .then((json) => {
      const result = json.data
      const data = result.map(item => ({
        id: item.id,
        nome: item.nome,
        cargo: item.cargo,
        email: item.email,
        dataNascimento: item.dataNascimento,
        telefone: item.telefone,
        senha: item.senha,
        receberNotificacao: item.receberNotificacao,
        especialidades: {
          fisioterapia: item.especialidades.fisioterapia,
          pilates: item.especialidades.pilates,
          drenagem: item.especialidades.drenagem,
          rPG: item.especialidades.rPG,
          massagem: item.especialidades.massagem,
          massoterapia: item.especialidades.massoterapia,
          acupuntura: item.especialidades.acupuntura,
        }
      }));
        setDadosProfessor(data[0]);
    })
    .catch((error) => {
      console.error("Erro ao buscar dados do professor:", error, error.status);
    });
  }, []);

  useEffect(() => {
    
  }, [setDadosProfessor]);

  const handleEditFotoClick = () => {
    if (fileInputRef.current) fileInputRef.current.click();
  };

  const handleFileChange = (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      setProfileImage(reader.result);
    };
    reader.readAsDataURL(file);
  };

  const handleEditInput = () =>{
    setEditavel(!editavel);
  }

  const toggleEspecialidade = (especialidade) => {
    setDadosProfessor({
      ...dadosProfessor,
      especialidades: {
        ...dadosProfessor.especialidades,
        [especialidade]: !dadosProfessor.especialidades[especialidade]
      }
    });
  };

  const handleSalvar = () => {
    console.log('Dados salvos:', dadosProfessor);
    alert('Perfil salvo com sucesso!');
  };

  const handleCancelar = () => {
    console.log('Cancelado');
  };

  return (
    <div className="profile-teacher">
      {/* Header com foto e nome */}
      <div className="profile-teacher__header">
        <div className="profile-teacher__foto-container">
          <img
            src={profileImage}
            alt={dadosProfessor.nome}
            className="profile-teacher__foto"
          />
          <button type="button" className="profile-teacher__foto-edit" onClick={handleEditFotoClick} aria-label="Editar foto">
            <FaPen size={12} aria-hidden="true" />
          </button>
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            style={{ display: 'none' }}
            onChange={handleFileChange}
          />
        </div>
        <div className="profile-teacher__info">
          <h2 className="profile-teacher__nome">{dadosProfessor.nome}</h2>
          <p className="profile-teacher__cargo">{dadosProfessor.cargo}</p>
        </div>
      </div>

      {/* Formulário */}
      <div className="profile-teacher__form">
        {/* Nome Completo e Email */}
        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Nome Completo</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="text"
                value={dadosProfessor.nome}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, nome: e.target.value })}
                className="profile-teacher__input"
              />
              <button onClick={handleEditInput} className="profile-teacher__edit-icon">
                <FaPen size={14} />
              </button>
            </div>
          </div>
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Email</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="email"
                value={dadosProfessor.email}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, email: e.target.value })}
                className="profile-teacher__input"
              />
              <button onClick={handleEditInput} className="profile-teacher__edit-icon">
                <FaPen size={14} />
              </button>
            </div>
          </div>
        </div>

        {/* Data de Nascimento e Telefone */}
        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Data de nascimento</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="date"
                value={dadosProfessor.dataNascimento}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, dataNascimento: e.target.value })}
                className="profile-teacher__input profile-teacher__input--placeholder"
              />
              <button onClick={handleEditInput} className="profile-teacher__edit-icon">
                <FaPen size={14} />
              </button>
            </div>
          </div>
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Telefone</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="tel"
                value={dadosProfessor.telefone}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, telefone: e.target.value })}
                className="profile-teacher__input"
              />
              <button onClick={handleEditInput} className="profile-teacher__edit-icon">
                <FaPen size={14} />
              </button>
            </div>
          </div>
        </div>

        {/* Senha e Notificação */}
        <div className="profile-teacher__row profile-teacher__row--align-end">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Senha</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="text"
                value={dadosProfessor.senha}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, senha: e.target.value })}
                className="profile-teacher__input"
              />
              <button onClick={handleEditInput} className="profile-teacher__edit-icon" >
                <FaPen size={14}  />
              </button>
            </div>
          </div>
          <div className="profile-teacher__notification">
            <span className="profile-teacher__notification-text">Deseja receber notificação?</span>
            <div className="profile-teacher__radio-group">
              <label className="profile-teacher__radio">
                <input
                  type="radio"
                  name="notificacao"
                  checked={!dadosProfessor.receberNotificacao}
                  onChange={() => setDadosProfessor({ ...dadosProfessor, receberNotificacao: false })}
                />
                <span>Não</span>
              </label>
              <label className="profile-teacher__radio">
                <input
                  type="radio"
                  name="notificacao"
                  checked={dadosProfessor.receberNotificacao}
                  onChange={() => setDadosProfessor({ ...dadosProfessor, receberNotificacao: true })}
                />
                <span>Sim</span>
              </label>
            </div>
          </div>
        </div>

        {/* Especialidades */}
        <div className="profile-teacher__especialidades">
          <label className="profile-teacher__label">Especialidades</label>
          <div className="profile-teacher__checkbox">
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.fisioterapia}
                onChange={() => toggleEspecialidade('fisioterapia')}
              />
              <span>Fisioterapia</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.pilates}
                onChange={() => toggleEspecialidade('pilates')}
              />
              <span>Pilates</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.drenagem}
                onChange={() => toggleEspecialidade('drenagem')}
              />
              <span>Drenagem</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.rPG}
                onChange={() => toggleEspecialidade('rPG')}
              />
              <span>rPG</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.massagem}
                onChange={() => toggleEspecialidade('massagem')}
              />
              <span>Massagem</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.massoterapia}
                onChange={() => toggleEspecialidade('massoterapia')}
              />
              <span>Massoterapia</span>
            </label>
            <label className="profile-teacher__checkbox">
              <input
                type="checkbox"
                checked={dadosProfessor.especialidades.acupuntura}
                onChange={() => toggleEspecialidade('acupuntura')}
              />
              <span>Acupuntura</span>
            </label>
          </div>
        </div>

        {/* Botões */}
        <div className="profile-teacher__buttons">
          <button onClick={handleCancelar} className="profile-teacher__btn profile-teacher__btn--cancel">
            Cancelar
          </button>
          <button onClick={handleSalvar} className="profile-teacher__btn profile-teacher__btn--save">
            Salvar
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProfileTeacher;