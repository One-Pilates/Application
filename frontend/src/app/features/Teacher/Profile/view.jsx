import React from 'react';
import { FaPen } from 'react-icons/fa';
import './style.scss';

const ProfileView = ({
  dadosProfessor,
  profileImage,
  fileInputRef,
  editavel,
  handleEditFotoClick,
  handleFileChange,
  handleEditInput,
  toggleEspecialidade,
  handleSalvar,
  handleCancelar,
  setDadosProfessor
}) => {
  
  return (
    <div className="profile">
      {/* Header */}
      <div className="profile__header">
        <div className="profile__foto-container">
          <img src={profileImage} alt={dadosProfessor.nome} className="profile__foto" />
          <button type="button" className="profile__foto-edit" onClick={handleEditFotoClick} aria-label="Editar foto">
            <FaPen size={12} aria-hidden="true" />
          </button>
          <input ref={fileInputRef} type="file" accept="image/*" style={{ display: 'none' }} onChange={handleFileChange} />
        </div>
        <div className="profile__info">
          <h2 className="profile__nome">{dadosProfessor.nome}</h2>
          <p className="profile__cargo">{dadosProfessor.cargo || 'Professor'}</p>
        </div>
      </div>

      {/* Formulário */}
      <div className="profile__form">
        {/* Nome e Email */}
        <div className="profile__row">
          <div className="profile__field">
            <label className="profile__label">Nome Completo</label>
            <div className="profile__input-group">
              <input disabled={!editavel} type="text" value={dadosProfessor.nome} onChange={(e) => setDadosProfessor({ ...dadosProfessor, nome: e.target.value })} className="profile__input" />
              <button onClick={handleEditInput} className="profile__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>

          <div className="profile__field">
            <label className="profile__label">Email</label>
            <div className="profile__input-group">
              <input disabled={!editavel} type="email" value={dadosProfessor.email} onChange={(e) => setDadosProfessor({ ...dadosProfessor, email: e.target.value })} className="profile__input" />
              <button onClick={handleEditInput} className="profile__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>
        </div>

        {/* Data de Nascimento e Telefone */}
        <div className="profile__row">
          <div className="profile__field">
            <label className="profile__label">Data de nascimento</label>
            <input disabled={!editavel} type="date" value={dadosProfessor.dataNascimento} onChange={(e) => setDadosProfessor({ ...dadosProfessor, dataNascimento: e.target.value })} className="profile__input" />
          </div>
          <div className="profile__field">
            <label className="profile__label">Telefone</label>
            <input disabled={!editavel} type="tel" value={dadosProfessor.telefone} onChange={(e) => setDadosProfessor({ ...dadosProfessor, telefone: e.target.value })} className="profile__input" />
          </div>
        </div>

        {/* Senha e Notificação */}
        <div className="profile__row profile__row--align-end">
          <div className="profile__field">
            <label className="profile__label">Senha</label>
            <input disabled={!editavel} type="text" value={dadosProfessor.senha} onChange={(e) => setDadosProfessor({ ...dadosProfessor, senha: e.target.value })} className="profile__input" />
          </div>
          <div className="profile__notification">
            <span className="profile__notification-text">Deseja receber notificação?</span>
            <label>
              <input type="radio" checked={!dadosProfessor.receberNotificacao} onChange={() => setDadosProfessor({ ...dadosProfessor, receberNotificacao: false })} />
              Não
            </label>
            <label>
              <input type="radio" checked={dadosProfessor.receberNotificacao} onChange={() => setDadosProfessor({ ...dadosProfessor, receberNotificacao: true })} />
              Sim
            </label>
          </div>
        </div>

        {/* Especialidades */}
        <div className="profile__especialidades">
          <label className="profile__label">Especialidades</label>
          {Object.keys(dadosProfessor.especialidades).map(key => (
            <label key={key} className="profile__checkbox">
              <input type="checkbox" checked={dadosProfessor.especialidades[key]} onChange={() => toggleEspecialidade(key)} />
              <span>{key.charAt(0).toUpperCase() + key.slice(1)}</span>
            </label>
          ))}
        </div>

        {/* Botões */}
        <div className="profile__buttons">
          <button onClick={handleCancelar} className="profile__btn profile__btn--cancel">Cancelar</button>
          <button onClick={handleSalvar} className="profile__btn profile__btn--save">Salvar</button>
        </div>
      </div>
    </div>
  );
};

export default ProfileView;
