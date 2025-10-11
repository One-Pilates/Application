import React from 'react';
import { FaPen } from 'react-icons/fa';
import './style.scss';

const ProfileView = ({
  dadosProfessor,
  setDadosProfessor,
  profileImage,
  fileInputRef,
  handleEditFotoClick,
  handleFileChange,
  toggleEspecialidade,
  handleSalvar,
  handleCancelar
}) => {
  return (
    <div className="profile-teacher">
      <div className="profile-teacher__header">
        <div className="profile-teacher__foto-container">
          <img src={profileImage} alt={dadosProfessor.nome} className="profile-teacher__foto" />
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
          <p className="profile-teacher__cargo">Fisioterapeuta</p>
        </div>
      </div>

      <div className="profile-teacher__form">
        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Nome Completo</label>
            <div className="profile-teacher__input-group">
              <input
                type="text"
                value={dadosProfessor.nome}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, nome: e.target.value })}
                className="profile-teacher__input"
              />
              <button className="profile-teacher__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Email</label>
            <div className="profile-teacher__input-group">
              <input
                type="email"
                value={dadosProfessor.email}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, email: e.target.value })}
                className="profile-teacher__input"
              />
              <button className="profile-teacher__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>
        </div>

        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Data de nascimento</label>
            <div className="profile-teacher__input-group">
              <input
                type="date"
                value={dadosProfessor.dataNascimento}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, dataNascimento: e.target.value })}
                className="profile-teacher__input"
              />
              <button className="profile-teacher__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Telefone</label>
            <div className="profile-teacher__input-group">
              <input
                type="tel"
                value={dadosProfessor.telefone}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, telefone: e.target.value })}
                className="profile-teacher__input"
              />
              <button className="profile-teacher__edit-icon"><FaPen size={14} /></button>
            </div>
          </div>
        </div>

        <div className="profile-teacher__row profile-teacher__row--align-end">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Senha</label>
            <div className="profile-teacher__input-group">
              <input
                type="password"
                value={dadosProfessor.senha}
                onChange={(e) => setDadosProfessor({ ...dadosProfessor, senha: e.target.value })}
                className="profile-teacher__input"
              />
              <button className="profile-teacher__edit-icon"><FaPen size={14} /></button>
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

        <div className="profile-teacher__especialidades">
          <label className="profile-teacher__label">Especialidades</label>
          <div className="profile-teacher__checkbox">
            {Object.keys(dadosProfessor.especialidades).map((key) => (
              <label key={key} className="profile-teacher__checkbox">
                <input
                  type="checkbox"
                  checked={dadosProfessor.especialidades[key]}
                  onChange={() => toggleEspecialidade(key)}
                />
                <span>{key.charAt(0).toUpperCase() + key.slice(1)}</span>
              </label>
            ))}
          </div>
        </div>

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

export default ProfileView;
