import React from "react";
import { FaPen } from "react-icons/fa";
import "./style.scss";

const ProfileTeacherView = ({
  dadosUser,
  profileImage,
  fileInputRef,
  handleEditFotoClick,
  handleFileChange,
  setDadosUser,
  hasChanged,
  cancelChanges,
  toggleEspecialidade,
  isEspecialidadeSelecionada,
  especialidadesMap,
  saveChanges,
}) => {
  return (
    <div className="profile-user">
      {/* HEADER */}
      <div className="profile-user__header">
        <div className="profile-user__foto-container">
          {profileImage ? (
            <img
              src={profileImage}
              alt={dadosUser.nome}
              className="profile-user__foto"
            />
          ) : (
            <div className="profile-user__foto placeholder" />
          )}

          <button
            type="button"
            className="profile-user__foto-edit"
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

        <div className="profile-user__info">
          <h2 className="profile-user__nome">{dadosUser.nome}</h2>
          <p className="profile-user__cargo">
            {dadosUser.cargo || "Professor"}
          </p>
        </div>
      </div>
      <hr className="mt-2 mb-2" />
      {/* FORM */}
      <div className="profile-user__form">
        {/* NOME / EMAIL */}
        <div className="profile-user__row">
          <div className="profile-user__field">
            <label className="profile-user__label">Nome Completo</label>
            <div className="profile-user__input-group">
              <input
                type="text"
                value={dadosUser.nome}
                onChange={(e) =>
                  setDadosUser({ ...dadosUser, nome: e.target.value })
                }
                className="profile-user__input"
              />
            </div>
          </div>

          <div className="profile-user__field">
            <label className="profile-user__label">Email</label>
            <div className="profile-user__input-group">
              <input
                type="email"
                value={dadosUser.email}
                onChange={(e) =>
                  setDadosUser({
                    ...dadosUser,
                    email: e.target.value,
                  })
                }
                className="profile-user__input"
              />
            </div>
          </div>
        </div>

        {/* DATA / TELEFONE */}
        <div className="profile-user__row">
          <div className="profile-user__field">
            <label className="profile-user__label">Data de nascimento</label>
            <input
              type="date"
              value={dadosUser.dataNascimento}
              onChange={(e) =>
                setDadosUser({
                  ...dadosUser,
                  dataNascimento: e.target.value,
                })
              }
              className="profile-user__input"
            />
          </div>

          <div className="profile-user__field">
            <label className="profile-user__label">Telefone</label>
            <input
              type="tel"
              value={dadosUser.telefone}
              onChange={(e) =>
                setDadosUser({
                  ...dadosUser,
                  telefone: e.target.value,
                })
              }
              className="profile-user__input"
            />
          </div>
        </div>

        {/* SENHA / NOTIFICAÇÃO */}
        <div className="profile-user__row profile-user__row--align-end">
          {/* <div className="profile-user__field">
            <label className="profile-user__label">Senha</label>
            <input
              type="text"
              value={dadosUser.senha}
              onChange={(e) =>
                setDadosUser({
                  ...dadosUser,
                  senha: e.target.value,
                })
              }
              className="profile-user__input"
            />
          </div> */}

          <div className="profile-user__notification">
              <span className="profile-user__notification-text">
                Deseja receber notificação?
              </span>
              <label className="profile-user__switch">
                <input
                  type="checkbox"
                  checked={Boolean(dadosUser.receberNotificacao)}
                  onChange={(e) =>
                    setDadosUser({
                      ...dadosUser,
                      receberNotificacao: e.target.checked,
                    })
                  }
                  aria-label="Receber notificações"
                />
                <span className="profile-user__switch-slider" />
              </label>
            </div>
        </div>

        {/* ESPECIALIDADES */}
        {dadosUser.role === 'PROFESSOR' && (
        <div className="profile-user__especialidades">
          <label className="profile-user__label">Especialidades</label>
          <div className="profile-user__checkbox-container">
            {especialidadesMap && especialidadesMap.map((especialidade) => (
              <label
                key={especialidade.id}
                className="profile-user__checkbox"
              >
                <input
                  type="checkbox"
                  checked={isEspecialidadeSelecionada(especialidade.id)}
                  onChange={() => toggleEspecialidade(especialidade.id)}
                />
                <span>{especialidade.nome}</span>
              </label>
            ))}
          </div>
        </div>
        )}


        {/* BOTÕES */}
        <div className="profile-user__buttons">
          <button
            onClick={cancelChanges}
            hidden={!hasChanged}
            className="profile-user__btn profile-user__btn--cancel"
          >
            Cancelar
          </button>
          <button
            onClick={saveChanges}
            disabled={!hasChanged}
            className="profile-user__btn profile-user__btn--save"
          >
            Salvar
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProfileTeacherView;
