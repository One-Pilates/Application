import React, { useState } from 'react';
import { FiX } from 'react-icons/fi';
import Button from './Button';
import '../Styles/Modal.scss';

const DefinirAusenciaModal = ({ isOpen, onClose }) => {
  const [dataInicio, setDataInicio] = useState('');
  const [dataFim, setDataFim] = useState('');
  const [motivo, setMotivo] = useState('');

  if (!isOpen) return null;

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Ausência definida:', { dataInicio, dataFim, motivo });
    onClose();
    setDataInicio(''); setDataFim(''); setMotivo('');
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content ausencia-modal" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>Definir Ausência</h2>
          <button className="modal-close" onClick={onClose}><FiX size={24} /></button>
        </div>

        <form onSubmit={handleSubmit} className="ausencia-form">
          <div className="form-group">
            <label htmlFor="dataInicio">Data de Início</label>
            <input type="date" id="dataInicio" value={dataInicio} onChange={e => setDataInicio(e.target.value)} required />
          </div>

          <div className="form-group">
            <label htmlFor="dataFim">Data de Término</label>
            <input type="date" id="dataFim" value={dataFim} onChange={e => setDataFim(e.target.value)} required />
          </div>

          <div className="form-group">
            <label htmlFor="motivo">Motivo (opcional)</label>
            <textarea id="motivo" value={motivo} onChange={e => setMotivo(e.target.value)} rows="3" placeholder="Descreva o motivo da ausência..." />
          </div>

          <div className="form-actions">
            <Button variant="secondary" onClick={onClose}>Cancelar</Button>
            <Button variant="primary" type="submit">Confirmar Ausência</Button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default DefinirAusenciaModal;
