import React, { useState, useEffect, useRef } from 'react';
import { FiX, FiUser, FiLoader } from 'react-icons/fi';
import './styles/CalendarTeacher.scss';

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
      { nome: 'Ana Costa', status: 'confirmado' },
      { nome: 'Carlos Mendes', status: 'confirmado' }
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
      { nome: 'Fernanda Lima', status: 'confirmado' },
      { nome: 'Roberto Alves', status: 'confirmado' },
      { nome: 'Juliana Rocha', status: 'confirmado' },
      { nome: 'Paulo Dias', status: 'pendente' },
      { nome: 'Mariana Castro', status: 'confirmado' }
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
      { nome: 'Lucas Ferreira', status: 'confirmado' },
      { nome: 'Beatriz Moura', status: 'confirmado' },
      { nome: 'Rafael Gomes', status: 'confirmado' }
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
      { nome: 'Camila Rodrigues', status: 'confirmado' },
      { nome: 'Diego Martins', status: 'confirmado' },
      { nome: 'Letícia Cardoso', status: 'confirmado' },
      { nome: 'Bruno Tavares', status: 'pendente' }
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

const Button = ({ children, onClick, variant = 'primary', disabled, type = 'button', className = '' }) => {
  const baseClass = 'btn';
  const variantClass = variant === 'primary' ? 'btn-primary' : 'btn-secondary';
  
  return (
    <button
      type={type}
      className={`${baseClass} ${variantClass} ${className}`}
      onClick={onClick}
      disabled={disabled}
    >
      {children}
    </button>
  );
};

const LoadingSpinner = () => (
  <div className="loading-container">
    <div className="loading-spinner">
      <FiLoader size={48} />
    </div>
    <p className="loading-text">Carregando calendário...</p>
  </div>
);

const DefinirAusenciaModal = ({ isOpen, onClose }) => {
  const [dataInicio, setDataInicio] = useState('');
  const [dataFim, setDataFim] = useState('');
  const [motivo, setMotivo] = useState('');

  if (!isOpen) return null;

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Ausência definida:', { dataInicio, dataFim, motivo });
    onClose();
    setDataInicio('');
    setDataFim('');
    setMotivo('');
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-content ausencia-modal" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>Definir Ausência</h2>
          <button className="modal-close" onClick={onClose}>
            <FiX size={24} />
          </button>
        </div>
        
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
            <Button variant="secondary" onClick={onClose}>
              Cancelar
            </Button>
            <Button variant="primary" type="submit">
              Confirmar Ausência
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
};

const AulaModal = ({ isOpen, aula, onClose }) => {
  const [activeTab, setActiveTab] = useState('informacoes');

  if (!isOpen || !aula) return null;

  const formatTime = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleTimeString('pt-BR', {
      hour: '2-digit',
      minute: '2-digit'
    });
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
          <button className="modal-close" onClick={handleClose}>
            <FiX size={24} />
          </button>
        </div>

        <div className="modal-tabs">
          <button 
            className={`modal-tab ${activeTab === 'informacoes' ? 'active' : ''}`}
            onClick={() => setActiveTab('informacoes')}
          >
            Informações
          </button>
          <button 
            className={`modal-tab ${activeTab === 'alunos' ? 'active' : ''}`}
            onClick={() => setActiveTab('alunos')}
          >
            Alunos ({aula.alunos.length})
          </button>
        </div>

        <div className="modal-body">
          {activeTab === 'informacoes' && (
            <div className="info-section">
              <div className="info-group">
                <div className="info-item">
                  <span className="info-label">Tipo:</span>
                  <span className="info-value">{aula.tipo}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Serviço:</span>
                  <span className="info-value">{aula.servico}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Professor:</span>
                  <span className="info-value">{aula.professor}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Horário:</span>
                  <span className="info-value">
                    {formatTime(aula.start)} - {formatTime(aula.end)}
                  </span>
                </div>
                <div className="info-item">
                  <span className="info-label">Andar:</span>
                  <span className="info-value">{aula.andar}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Sala:</span>
                  <span className="info-value">{aula.sala}</span>
                </div>
                <div className="info-item">
                  <span className="info-label">Total de Alunos:</span>
                  <span className="info-value">{aula.alunos.length}</span>
                </div>
                {aula.observacoes && (
                  <div className="info-item">
                    <span className="info-label">Observações:</span>
                    <span className="info-value">{aula.observacoes}</span>
                  </div>
                )}
              </div>
            </div>
          )}

          {activeTab === 'alunos' && (
            <div className="alunos-section">
              <div className="alunos-list">
                {aula.alunos.map((aluno, index) => (
                  <div key={index} className="aluno-item">
                    <div className="aluno-avatar">
                      <FiUser size={20} color="#FF6B35" />
                    </div>
                    <div className="aluno-info">
                      <span className="aluno-nome">{aluno.nome}</span>
                      <span className={`aluno-status status-${aluno.status}`}>
                        {aluno.status === 'confirmado' ? 'Confirmado' : 
                         aluno.status === 'pendente' ? 'Pendente' : 'Cancelado'}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

const CalendarTeacher = () => {
  const [selectedAula, setSelectedAula] = useState(null);
  const [isAulaModalOpen, setIsAulaModalOpen] = useState(false);
  const [isAusenciaModalOpen, setIsAusenciaModalOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const calendarRef = useRef(null);
  const calendarInstance = useRef(null);

  useEffect(() => {
    const loadFullCalendar = async () => {
      try {
        if (window.FullCalendar) {
          initCalendar();
          return;
        }

        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = 'https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css';
        document.head.appendChild(link);

        const script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js';
        
        script.onload = () => {
          setTimeout(() => {
            initCalendar();
          }, 100);
        };
        
        script.onerror = () => {
          console.error('Erro ao carregar FullCalendar');
          setIsLoading(false);
        };
        
        document.body.appendChild(script);
      } catch (error) {
        console.error('Erro ao inicializar calendário:', error);
        setIsLoading(false);
      }
    };

    const initCalendar = () => {
      if (!calendarRef.current) return;
      
      if (calendarInstance.current) {
        calendarInstance.current.destroy();
      }

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
      
      setTimeout(() => {
        setIsLoading(false);
      }, 300);
    };

    loadFullCalendar();

    return () => {
      if (calendarInstance.current) {
        calendarInstance.current.destroy();
        calendarInstance.current = null;
      }
    };
  }, []);

  return (
    <div className="calendar-container">
      <main className="calendar-main">
        <div className="calendar-header-info">
          <Button 
            onClick={() => setIsAusenciaModalOpen(true)}
            disabled={isLoading}
          >
            Definir Ausência
          </Button>
        </div>
        
        <div className="calendar-wrapper">
          {isLoading && <LoadingSpinner />}
          <div 
            ref={calendarRef} 
            className="fullcalendar"
            style={{ opacity: isLoading ? 0 : 1, transition: 'opacity 0.3s' }}
          ></div>
        </div>
      </main>

      <AulaModal 
        isOpen={isAulaModalOpen}
        aula={selectedAula}
        onClose={() => {
          setIsAulaModalOpen(false);
          setSelectedAula(null);
        }}
      />

      <DefinirAusenciaModal 
        isOpen={isAusenciaModalOpen}
        onClose={() => setIsAusenciaModalOpen(false)}
      />
    </div>
  );
};


export default CalendarTeacher;