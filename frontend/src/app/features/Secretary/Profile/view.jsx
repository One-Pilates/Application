import React from "react";
import { FaPen } from "react-icons/fa";
import { useViewProfileModel } from "./model";
import "../../Teacher/Profile/styles.scss";

const ViewProfile = () => {
  const { dadosUser, tipo, loading } = useViewProfileModel();

  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-lg text-gray-600">Carregando perfil...</div>
      </div>
    );
  }

  if (!dadosUser) {
    return (
      <div className="flex items-center justify-center h-screen">
        <div className="text-lg text-red-600">Perfil não encontrado</div>
      </div>
    );
  }

    return (
      <div className="profile-user">
        {/* HEADER */}
        <div className="profile-user__header">
          <div className="profile-user__foto-container">
            {dadosUser.foto ? (
              <img
                src={dadosUser.foto}
                alt={dadosUser.nome}
                className="profile-user__foto"
              />
            ) : (
              <div className="profile-user__foto placeholder" />
            )}
          </div>
  
          <div className="profile-user__info">
            <h2 className="profile-user__nome">{dadosUser.nome}</h2>
            <p className="profile-user__cargo">
              {tipo === 'professor' ? 'Professor' : 'Aluno'}
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
                  value={dadosUser.nome || ''}
                  className="profile-user__input"
                  disabled
                />
              </div>
            </div>
  
            <div className="profile-user__field">
              <label className="profile-user__label">Email</label>
              <div className="profile-user__input-group">
                <input
                  type="email"
                  value={dadosUser.email || ''}
                  className="profile-user__input"
                  disabled
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
                value={dadosUser.dataNascimento || ''}
                className="profile-user__input"
                disabled
              />
            </div>
  
            <div className="profile-user__field">
              <label className="profile-user__label">Telefone</label>
              <input
                type="tel"
                value={dadosUser.telefone || ''}
                className="profile-user__input"
                disabled
              />
            </div>
          </div>
  
          {/* SENHA / NOTIFICAÇÃO */}
          <div className="profile-user__row profile-user__row--align-end">
            {tipo === 'professor' && (
              <div className="profile-user__notification">
                <span className="profile-user__notification-text">
                  Deseja receber notificação?
                </span>
                <label className="profile-user__switch">
                  <input
                    type="checkbox"
                    checked={dadosUser.notificacao || false}
                    aria-label="Receber notificações"
                    disabled
                  />
                  <span className="profile-user__switch-slider" />
                </label>
              </div>
            )}
          </div>
  
          {/* ESPECIALIDADES */}
          {tipo === 'professor' && dadosUser.especialidades?.length > 0 && (
            <div className="profile-user__especialidades">
              <label className="profile-user__label">Especialidades</label>
              <div className="profile-user__checkbox-container">
                {dadosUser.especialidades.map((esp) => (
                  <label
                    key={esp.id}
                    className="profile-user__checkbox"
                  >
                    <input
                      type="checkbox"
                      checked={true}
                      disabled
                    />
                    <span>{esp.nome}</span>
                  </label>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    );
};

export default ViewProfile;
