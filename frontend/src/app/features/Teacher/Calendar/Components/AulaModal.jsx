import React, { useState } from 'react';
import { FiX } from 'react-icons/fi';
import AlunoItem from './AlunoItem';
import '../Styles/Modal.scss';

const AulaModal = ({ isOpen, aula, onClose }) => {
  const [activeTab, setActiveTab] = useState('informacoes');

  if (!isOpen || !aula) return null;

  const formatTime = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
  };

  const handleClose = () => {
    setActiveTab('informacoes');
    onClose();
  };

  return (
    <div className="modal-overlay" onClick={handleClose}>
      <div className="modal-content" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>{aula.title} - {formatTime(aula.start).slice(0, 5)}h</h2>
          <button className="modal-close" onClick={handleClose}><FiX size={24} /></button>
        </div>

        <div className="modal-tabs">
          <button className={`modal-tab ${activeTab === 'informacoes' ? 'active' : ''}`} onClick={() => setActiveTab('informacoes')}>
            Informações
          </button>
          <button className={`modal-tab ${activeTab === 'alunos' ? 'active' : ''}`} onClick={() => setActiveTab('alunos')}>
            Alunos ({aula.alunos.length})
          </button>
        </div>

        <div className="modal-body">
          {activeTab === 'informacoes' && (
            <div className="info-section">
              <div className="info-group">
                <div className="info-item"><span className="info-label">Tipo:</span><span className="info-value">{aula.tipo}</span></div>
                <div className="info-item"><span className="info-label">Serviço:</span><span className="info-value">{aula.servico}</span></div>
                <div className="info-item"><span className="info-label">Professor:</span><span className="info-value">{aula.professor}</span></div>
                <div className="info-item"><span className="info-label">Horário:</span><span className="info-value">{formatTime(aula.start)} - {formatTime(aula.end)}</span></div>
                <div className="info-item"><span className="info-label">Andar:</span><span className="info-value">{aula.andar}</span></div>
                <div className="info-item"><span className="info-label">Sala:</span><span className="info-value">{aula.sala}</span></div>
                <div className="info-item"><span className="info-label">Total de Alunos:</span><span className="info-value">{aula.alunos.length}</span></div>
                {aula.observacoes && <div className="info-item"><span className="info-label">Observações:</span><span className="info-value">{aula.observacoes}</span></div>}
              </div>
            </div>
          )}

          {activeTab === 'alunos' && (
            <div className="alunos-section">
              {aula.alunos.map((aluno, i) => <AlunoItem key={i} nome={aluno.nome} status={aluno.status} />)}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AulaModal;
