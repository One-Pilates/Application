import React from "react";
import { FaPen } from "react-icons/fa";
import "./style.scss";

const ProfileTeacherView = ({
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
  setDadosProfessor,
}) => {
  return (
    <div className="profile-teacher">
      {/* HEADER */}
      <div className="profile-teacher__header">
        <div className="profile-teacher__foto-container">
          {profileImage ? (
            <img
              src={profileImage}
              alt={dadosProfessor.nome}
              className="profile-teacher__foto"
            />
          ) : (
            <div className="profile-teacher__foto placeholder" />
          )}

          <button
            type="button"
            className="profile-teacher__foto-edit"
            onClick={handleEditFotoClick}
            aria-label="Editar foto"
          >
            <FaPen size={12} aria-hidden="true" />
          </button>
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            style={{ display: "none" }}
            onChange={handleFileChange}
          />
        </div>

        <div className="profile-teacher__info">
          <h2 className="profile-teacher__nome">{dadosProfessor.nome}</h2>
          <p className="profile-teacher__cargo">
            {dadosProfessor.cargo || "Professor"}
          </p>
        </div>
      </div>

      {/* FORM */}
      <div className="profile-teacher__form">
        {/* NOME / EMAIL */}
        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Nome Completo</label>
            <div className="profile-teacher__input-group">
              <input
                disabled={!editavel}
                type="text"
                value={dadosProfessor.nome}
                onChange={(e) =>
                  setDadosProfessor({ ...dadosProfessor, nome: e.target.value })
                }
                className="profile-teacher__input"
              />
              <button
                onClick={handleEditInput}
                className="profile-teacher__edit-icon"
              >
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
                onChange={(e) =>
                  setDadosProfessor({ ...dadosProfessor, email: e.target.value })
                }
                className="profile-teacher__input"
              />
              <button
                onClick={handleEditInput}
                className="profile-teacher__edit-icon"
              >
                <FaPen size={14} />
              </button>
            </div>
          </div>
        </div>

        {/* DATA / TELEFONE */}
        <div className="profile-teacher__row">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Data de nascimento</label>
            <input
              disabled={!editavel}
              type="date"
              value={dadosProfessor.dataNascimento}
              onChange={(e) =>
                setDadosProfessor({
                  ...dadosProfessor,
                  dataNascimento: e.target.value,
                })
              }
              className="profile-teacher__input"
            />
          </div>

          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Telefone</label>
            <input
              disabled={!editavel}
              type="tel"
              value={dadosProfessor.telefone}
              onChange={(e) =>
                setDadosProfessor({
                  ...dadosProfessor,
                  telefone: e.target.value,
                })
              }
              className="profile-teacher__input"
            />
          </div>
        </div>

        {/* SENHA / NOTIFICAÇÃO */}
        <div className="profile-teacher__row profile-teacher__row--align-end">
          <div className="profile-teacher__field">
            <label className="profile-teacher__label">Senha</label>
            <input
              disabled={!editavel}
              type="text"
              value={dadosProfessor.senha}
              onChange={(e) =>
                setDadosProfessor({
                  ...dadosProfessor,
                  senha: e.target.value,
                })
              }
              className="profile-teacher__input"
            />
          </div>

          <div className="profile-teacher__notification">
            <span className="profile-teacher__notification-text">
              Deseja receber notificação?
            </span>
            <label>
              <input
                type="radio"
                checked={!dadosProfessor.receberNotificacao}
                onChange={() =>
                  setDadosProfessor({
                    ...dadosProfessor,
                    receberNotificacao: false,
                  })
                }
              />
              Não
            </label>
            <label>
              <input
                type="radio"
                checked={dadosProfessor.receberNotificacao}
                onChange={() =>
                  setDadosProfessor({
                    ...dadosProfessor,
                    receberNotificacao: true,
                  })
                }
              />
              Sim
            </label>
          </div>
        </div>

{/* ESPECIALIDADES */}
        <div className="profile-teacher__especialidades">
          <label className="profile-teacher__label">Especialidades</label>
          {/* Adicionei a classe CSS que configura o grid de 2 colunas */}
          <div className="profile-teacher__checkbox-container"> 
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

        {/* BOTÕES */}
        <div className="profile-teacher__buttons">
          <button
            onClick={handleCancelar}
            className="profile-teacher__btn profile-teacher__btn--cancel"
          >
            Cancelar
          </button>
          <button
            onClick={handleSalvar}
            className="profile-teacher__btn profile-teacher__btn--save"
          >
            Salvar
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProfileTeacherView;
