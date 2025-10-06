import { Calendar } from 'fullcalendar/index.js';
import React, { useState, useEffect, useRef } from 'react';
import { FiCalendar, FiX, FiUser } from 'react-icons/fi';

const MOCK_AULAS = [
  {
    id: '1',
    title: 'Aula Pilates',
    start: '2025-10-06T10:00:00',
    end: '2025-10-06T11:00:00',
    tipo: 'Aula Pilates',
    alunos: [
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Maria Silva', status: 'confirmado' },
      { nome: 'João Santos', status: 'pendente' }
    ],
    andar: '1º Andar',
    sala: 'Sala 1',
    professor: 'Flávia',
    servico: 'Pilates Mat',
    observacoes: 'Trazer tapete próprio',
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
    textColor: '#ffffff'
  },
  {
    id: '2',
    title: 'Fisioterapia',
    start: '2025-10-06T11:00:00',
    end: '2025-10-06T12:00:00',
    tipo: 'Fisioterapia',
    alunos: [
      { nome: 'Pedro Oliveira', status: 'confirmado' }
    ],
    andar: '2º Andar',
    sala: 'Sala 3',
    professor: 'Flávia',
    servico: 'Sessão Individual',
    observacoes: 'Paciente com restrição lombar',
    backgroundColor: '#4169E1',
    borderColor: '#4169E1',
    textColor: '#ffffff'
  },
  {
    id: '3',
    title: 'Aula Pilates',
    start: '2025-10-06T12:00:00',
    end: '2025-10-06T13:00:00',
    tipo: 'Aula Pilates',
    alunos: [
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' }
    ],
    andar: '1º Andar',
    sala: 'Sala 2',
    professor: 'Flávia',
    servico: 'Pilates Reformer',
    observacoes: '',
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
    textColor: '#ffffff'
  },
  {
    id: '4',
    title: 'RPG',
    start: '2025-10-06T13:00:00',
    end: '2025-10-06T14:00:00',
    tipo: 'RPG',
    alunos: [
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' }
    ],
    andar: '1º Andar',
    sala: 'Sala 1',
    professor: 'Flávia',
    servico: 'Reeducação Postural Global',
    observacoes: '',
    backgroundColor: '#2ECC71',
    borderColor: '#2ECC71',
    textColor: '#ffffff'
  },
  {
    id: '5',
    title: 'Aula Pilates',
    start: '2025-10-07T10:00:00',
    end: '2025-10-07T11:00:00',
    tipo: 'Aula Pilates',
    alunos: [
      { nome: 'Amanda Souza', status: 'confirmado' },
      { nome: 'Marcos Pereira', status: 'confirmado' },
      { nome: 'Patrícia Lima', status: 'cancelado' }
    ],
    andar: '1º Andar',
    sala: 'Sala 1',
    professor: 'Flávia',
    servico: 'Pilates Mat',
    observacoes: '',
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
    textColor: '#ffffff'
  },
  {
    id: '6',
    title: 'Aula Pilates',
    start: '2025-10-08T14:00:00',
    end: '2025-10-08T15:00:00',
    tipo: 'Aula Pilates',
    alunos: [
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' }
    ],
    andar: '1º Andar',
    sala: 'Sala 1',
    professor: 'Flávia',
    servico: 'Pilates Reformer',
    observacoes: '',
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
    textColor: '#ffffff'
  },
  {
    id: '7',
    title: 'RPG',
    start: '2025-10-08T16:00:00',
    end: '2025-10-08T17:00:00',
    tipo: 'RPG',
    alunos: [
      { nome: 'Gabriel Santos', status: 'confirmado' }
    ],
    andar: '2º Andar',
    sala: 'Sala 3',
    professor: 'Flávia',
    servico: 'Reeducação Postural Global',
    observacoes: '',
    backgroundColor: '#2ECC71',
    borderColor: '#2ECC71',
    textColor: '#ffffff'
  },
  {
    id: '8',
    title: 'Aula Pilates',
    start: '2025-10-09T10:00:00',
    end: '2025-10-09T11:00:00',
    tipo: 'Aula Pilates',
    alunos: [
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' },
      { nome: 'Gustavo', status: 'confirmado' }
    ],
    andar: '1º Andar',
    sala: 'Sala 2',
    professor: 'Flávia',
    servico: 'Pilates Mat',
    observacoes: '',
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
    textColor: '#ffffff'
  }
];

// Modal de Definir Ausência
const DefinirAusenciaModal = ({ isOpen, onClose }) => {
  const [dataInicio, setDataInicio] = useState('');
  const [dataFim, setDataFim] = useState('');
  const [motivo, setMotivo] = useState('');

  if (!isOpen) return null;

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Ausência definida:', { dataInicio, dataFim, motivo });
    onClose();
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content ausencia-modal" onClick={(e) => e.stopPropagation()}>
        <form onSubmit={handleSubmit} className="ausencia-form">
          <div className="form-group">
            <label htmlFor="dataInicio">Data de Início</label>
            <input
              type="date"
              id="dataInicio"
              value={dataInicio}
              onChange={(e) => setDataInicio(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="dataFim">Data de Término</label>
            <input
              type="date"
              id="dataFim"
              value={dataFim}
              onChange={(e) => setDataFim(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label htmlFor="motivo">Motivo (opcional)</label>
            <textarea
              id="motivo"
              value={motivo}
              onChange={(e) => setMotivo(e.target.value)}
              rows="3"
              placeholder="Descreva o motivo da ausência..."
            />
          </div>

          <div className="form-actions">
            <button type="button" className="btn-secondary" onClick={onClose}>
              Cancelar
            </button>
            <button type="submit" className="btn-primary">
              Confirmar Ausência
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

const CalendarTeacher = () => {
  const [selectedAula, setSelectedAula] = useState(null);
  const [isAulaModalOpen, setIsAulaModalOpen] = useState(false);
  const [isAusenciaModalOpen, setIsAusenciaModalOpen] = useState(false);
  const calendarRef = useRef(null);
  const calendarInstance = useRef(null);

  useEffect(() => {
    const loadFullCalendar = async () => {
      if (window.FullCalendar) {
        initCalendar();
        return;
      }

      // Adicionar CSS do FullCalendar
      const link = document.createElement('link');
      link.rel = 'stylesheet';
      link.href = 'https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css';
      document.head.appendChild(link);

      // Adicionar JS do FullCalendar
      const script = document.createElement('script');
      script.src = 'https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js';
      script.onload = () => {
        initCalendar();
      };
      document.body.appendChild(script);
    };

    const initCalendar = () => {
      if (!calendarRef.current || calendarInstance.current) return;

      const calendar = new window.FullCalendar.Calendar(calendarRef.current, {
        initialView: 'timeGridWeek',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        buttonText: {
          today: 'Hoje',
          month: 'Mês',
          week: 'Semana',
          day: 'Dia'
        },
        locale: 'pt-br',
        slotMinTime: '07:00:00',
        slotMaxTime: '22:00:00',
        allDaySlot: false,
        height: 'auto',
        slotDuration: '00:30:00',
        expandRows: true,
        events: MOCK_AULAS,
        eventClick: (info) => {
          const aulaData = MOCK_AULAS.find(a => a.id === info.event.id);
          if (aulaData) {
            setSelectedAula(aulaData);
            setIsAulaModalOpen(true);
          }
        },
        eventDidMount: (info) => {
          info.el.style.cursor = 'pointer';
        }
      });

      calendar.render();
      calendarInstance.current = calendar;
    };

    loadFullCalendar();

    return () => {
      if (calendarInstance.current) {
        calendarInstance.current.destroy();
      }
    };
  }, []);

  const closeAulaModal = () => {
    setIsAulaModalOpen(false);
    setSelectedAula(null);
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: 'long',
      year: 'numeric'
    });
  };

  const formatTime = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleTimeString('pt-BR', {
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <div className="calendar-container">
      <main className="calendar-main">
        <div className="calendar-header-info">
          <button 
            className="btn-definir-ausencia" 
            onClick={() => setIsAusenciaModalOpen(true)}
          >
            Definir Ausência
          </button>
        </div>
        
        <div className="calendar-wrapper">
          <div ref={calendarRef} className="fullcalendar"></div>
        </div>
      </main>

      {/* Modal de Visualização de Aula */}
      {isAulaModalOpen && selectedAula && (
        <div className="modal-overlay" onClick={closeAulaModal}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h2>{selectedAula.title} - {formatTime(selectedAula.start).slice(0, 5)}h</h2>
              <button className="modal-close" onClick={closeAulaModal}>
                <FiX size={24} />
              </button>
            </div>

            <div className="modal-tabs">
              <button className="modal-tab active">Alunos</button>
              <button className="modal-tab">Informações</button>
            </div>

            <div className="modal-body">
              <div className="alunos-section">
                <div className="alunos-list">
                  {selectedAula.alunos.map((aluno, index) => (
                    <div key={index} className="aluno-item">
                      <div className="aluno-avatar">
                        <FiUser size={20} color="#FF6B35" />
                      </div>
                      <span className="aluno-nome">{aluno.nome}</span>
                    </div>
                  ))}
                </div>
              </div>

              <div className="info-section">
                <div className="info-group">
                  <div className="info-item">
                    <span className="info-label orange">Andar:</span>
                    <span className="info-value">{selectedAula.andar}</span>
                  </div>
                  <div className="info-item">
                    <span className="info-label orange">Sala:</span>
                    <span className="info-value">{selectedAula.sala}</span>
                  </div>
                  <div className="info-item">
                    <span className="info-label orange">Horário:</span>
                    <span className="info-value">
                      {formatTime(selectedAula.start)} - {formatTime(selectedAula.end)}
                    </span>
                  </div>
                  <div className="info-item">
                    <span className="info-label orange">Serviço:</span>
                    <span className="info-value">{selectedAula.servico}</span>
                  </div>
                  {selectedAula.observacoes && (
                    <div className="info-item">
                      <span className="info-label orange">Observações:</span>
                      <span className="info-value">{selectedAula.observacoes}</span>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Definir Ausência */}
      <DefinirAusenciaModal 
        isOpen={isAusenciaModalOpen}
        onClose={() => setIsAusenciaModalOpen(false)}
      />
    </div>
  );
};

// Estilos SASS compilados para CSS
const styles = `
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.calendar-container {
  min-height: 100vh;
  background: #F5F5F5;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
}

.calendar-header {
  background: #FF6B35;
  color: white;
  padding: 1.25rem 2rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header-content {
  max-width: 1400px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.logo-box {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo-section h1 {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 0;
}

.user-section {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: white;
  color: #FF6B35;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.125rem;
}

.user-info {
  display: flex;
  flex-direction: column;
}

.user-name {
  font-weight: 600;
  font-size: 0.938rem;
}

.user-role {
  font-size: 0.813rem;
  opacity: 0.9;
}

.calendar-main {
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem;
}

.calendar-header-info {
  margin-bottom: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-info-left h2 {
  font-size: 1.75rem;
  color: #333;
  margin-bottom: 0.25rem;
}

.calendar-subtitle {
  color: #666;
  font-size: 0.938rem;
}

.btn-definir-ausencia {
  background: #FF6B35;
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 6px;
  font-size: 0.938rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-definir-ausencia:hover {
  background: #e85a28;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
}

.btn-definir-ausencia:active {
  transform: translateY(0);
}

.calendar-wrapper {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.fullcalendar {
  font-family: inherit;
}

.fc-theme-standard .fc-scrollgrid {
  border: 1px solid #e0e0e0;
}

.fc .fc-button-primary {
  background-color: #FF6B35;
  border-color: #FF6B35;
}

.fc .fc-button-primary:hover {
  background-color: #e85a28;
  border-color: #e85a28;
}

.fc .fc-button-primary:not(:disabled).fc-button-active {
  background-color: #d04d1e;
  border-color: #d04d1e;
}

.fc-event {
  cursor: pointer;
  border-radius: 4px;
  border: none !important;
}

.fc-event:hover {
  opacity: 0.85;
}

.fc-daygrid-day-number {
  color: #333;
  font-weight: 500;
}

.fc-col-header-cell {
  background-color: #fafafa;
  font-weight: 600;
  color: #666;
  text-transform: uppercase;
  font-size: 0.75rem;
  padding: 0.75rem 0;
}

.fc-timegrid-slot {
  height: 3rem;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1rem;
  animation: fadeIn 0.2s ease-in-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.modal-content {
  background: white;
  border-radius: 12px;
  max-width: 500px;
  width: 100%;
  max-height: 90vh;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  animation: slideUp 0.3s ease-in-out;
  display: flex;
  flex-direction: column;
}

.ausencia-modal {
  max-width: 450px;
}

@keyframes slideUp {
  from {
    transform: translateY(20px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.modal-header {
  padding: 1.5rem;
  border-bottom: 1px solid #e5e5e5;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: white;
}

.modal-header h2 {
  margin: 0;
  font-size: 1.125rem;
  color: #333;
  font-weight: 600;
}

.modal-close {
  background: none;
  border: none;
  cursor: pointer;
  color: #999;
  padding: 0.5rem;
  border-radius: 4px;
  transition: all 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover {
  background: #f5f5f5;
  color: #666;
}

.modal-tabs {
  display: flex;
  border-bottom: 2px solid #f0f0f0;
  background: white;
}

.modal-tab {
  flex: 1;
  padding: 1rem;
  background: none;
  border: none;
  cursor: pointer;
  font-size: 0.938rem;
  font-weight: 500;
  color: #999;
  transition: all 0.2s;
  position: relative;
}

.modal-tab.active {
  color: #FF6B35;
}

.modal-tab.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  right: 0;
  height: 2px;
  background: #FF6B35;
}

.modal-tab:hover {
  color: #FF6B35;
  background: #fff5f2;
}

.modal-body {
  padding: 1.5rem;
  overflow-y: auto;
  flex: 1;
}

.alunos-section {
  margin-bottom: 1.5rem;
}

.alunos-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.aluno-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem;
  background: #fafafa;
  border-radius: 6px;
  transition: background 0.2s;
}

.aluno-item:hover {
  background: #f5f5f5;
}

.aluno-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.aluno-nome {
  font-weight: 500;
  color: #333;
  font-size: 0.938rem;
}

.info-section {
  border-top: 1px solid #f0f0f0;
  padding-top: 1.5rem;
}

.info-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.info-item {
  display: flex;
  align-items: flex-start;
  gap: 0.5rem;
}

.info-label {
  font-weight: 600;
  color: #666;
  min-width: 100px;
  font-size: 0.875rem;
}

.info-label.orange {
  color: #FF6B35;
}

.info-value {
  color: #333;
  flex: 1;
  font-size: 0.875rem;
}

.ausencia-form {
  padding: 1.5rem;
}

.form-group {
  margin-bottom: 1.25rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  color: #333;
  font-weight: 600;
  font-size: 0.875rem;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  font-size: 0.938rem;
  font-family: inherit;
  transition: border-color 0.2s;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #FF6B35;
}

.form-group textarea {
  resize: vertical;
}

.form-actions {
  display: flex;
  gap: 0.75rem;
  justify-content: flex-end;
  margin-top: 1.5rem;
}

.btn-secondary,
.btn-primary {
  padding: 0.75rem 1.5rem;
  border-radius: 6px;
  font-size: 0.938rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
}

.btn-secondary {
  background: #f5f5f5;
  color: #666;
}

.btn-secondary:hover {
  background: #e5e5e5;
}

.btn-primary {
  background: #FF6B35;
  color: white;
}

.btn-primary:hover {
  background: #e85a28;
}

@media (max-width: 768px) {
  .calendar-header {
    padding: 1rem;
  }
  
  .header-content {
    flex-direction: row;
    gap: 1rem;
  }
  
  .user-name {
    font-size: 0.875rem;
  }
  
  .user-role {
    font-size: 0.75rem;
  }
  
  .calendar-main {
    padding: 1rem;
  }

  .calendar-header-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .btn-definir-ausencia {
    width: 100%;
  }
  
  .calendar-wrapper {
    padding: 1rem;
  }
  
  .modal-content {
    max-width: 100%;
    margin: 0.5rem;
  }
}
`;

const styleSheet = document.createElement("style");
styleSheet.textContent = styles;
document.head.appendChild(styleSheet);

export default CalendarTeacher;