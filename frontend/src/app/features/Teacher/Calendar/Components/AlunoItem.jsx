import React from 'react';
import { FiUser } from 'react-icons/fi';
import '../Styles/AlunoItem.scss';


const AlunoItem = ({ nome, status }) => (
  <div className="aluno-item">
    <div className="aluno-avatar">
      <FiUser size={20} color="#FF6B35" />
    </div>
    <div className="aluno-info">
      <span className="aluno-nome">{nome}</span>
      <span className={`aluno-status status-${status}`}>
        {status === 'confirmado' ? 'Confirmado' : status === 'pendente' ? 'Pendente' : 'Cancelado'}
      </span>
    </div>
  </div>
);

export default AlunoItem;
