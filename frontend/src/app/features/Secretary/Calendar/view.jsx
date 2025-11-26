import { useState, useEffect } from 'react';
import Button from './Components/Button';
import LoadingSpinner from '../../../shared/components/LoadingSpinner';
import AgendamentoModal from './Components/AulaModal';
import './styles/Calendar.scss';
import './styles/Filtros.scss';

const SecretariaCalendarView = ({
  salas,
  professores,
  idSala,
  setIdSala,
  idProfessor,
  setIdProfessor,
  fetchAgendamentosFiltro,
  limparFiltros,
  isLoading,
  calendarRef,
  calendarInstance,
  errorMessage,
  agendamentos,
  jaBuscou,
  modalOpen,
  setModalOpen,
  agendamentoSelecionado,
}) => {
  const [activeView, setActiveView] = useState('timeGridWeek');
  const [showLoading, setShowLoading] = useState(false);

  const handleChangeView = (viewName) => {
    if (calendarInstance.current) {
      calendarInstance.current.changeView(viewName);
      setActiveView(viewName);
    }
  };

  useEffect(() => {
    if (calendarInstance.current) {
      setActiveView(calendarInstance.current.view?.type || 'timeGridWeek');
    }
  }, [calendarInstance]);

  useEffect(() => {
    const timeout = isLoading
      ? null
      : setTimeout(() => setShowLoading(false), 400);
    if (isLoading) setShowLoading(true);
    return () => clearTimeout(timeout);
  }, [isLoading]);

  const isFiltroValido = idSala || idProfessor;
  const hasAgendamentos = agendamentos.length > 0;

  return (
    <div className="calendar-container">
      <h1>Agenda</h1>

      <main className="calendar-main">
        <div className="calendar-header-info">
          <div className="calendar-view-buttons">
            <button className={`filter-button ${activeView === 'dayGridMonth' ? 'active' : ''}`}
                    onClick={() => handleChangeView('dayGridMonth')}>Mês</button>
            <button className={`filter-button ${activeView === 'timeGridWeek' ? 'active' : ''}`}
                    onClick={() => handleChangeView('timeGridWeek')}>Semana</button>
            <button className={`filter-button ${activeView === 'timeGridDay' ? 'active' : ''}`}
                    onClick={() => handleChangeView('timeGridDay')}>Dia</button>
          </div>

          <div className="filtros-inline">
            <div className="filtro-item">
              <label htmlFor="filtro-sala">Sala:</label>
              <select id="filtro-sala" value={idSala} onChange={(e) => setIdSala(e.target.value)}
                      className="filtro-select-inline" disabled={isLoading}>
                <option value="">Todas</option>
                {salas.map((sala) => (
                  <option key={sala.id} value={sala.id}>{sala.nome}</option>
                ))}
              </select>
            </div>

            <div className="filtro-item">
              <label htmlFor="filtro-professor">Professor:</label>
              <select id="filtro-professor" value={idProfessor} onChange={(e) => setIdProfessor(e.target.value)}
                      className="filtro-select-inline" disabled={isLoading}>
                <option value="0">Todos</option>
                {professores.map((prof) => (
                  <option key={prof.id} value={prof.id}>{prof.nome}</option>
                ))}
              </select>
            </div>

            <Button onClick={fetchAgendamentosFiltro} disabled={!isFiltroValido || isLoading} className="btn-aplicar">
              {isLoading ? 'Carregando...' : 'Aplicar'}
            </Button>

            {(hasAgendamentos || errorMessage || jaBuscou) && (
              <Button onClick={limparFiltros} disabled={isLoading} className="btn-limpar">
                Limpar
              </Button>
            )}
          </div>
        </div>

        {!isFiltroValido && !jaBuscou && (
          <div className="aviso-info">
            <span>Selecione pelo menos uma sala ou um professor</span>
          </div>
        )}

        {errorMessage && (
          <div className="aviso-erro">
            <span>{errorMessage}</span>
          </div>
        )}

        {jaBuscou && !hasAgendamentos && !isLoading && !errorMessage && (
          <div className="aviso-vazio">
            <p>Nenhum agendamento encontrado para os filtros selecionados.</p>
          </div>
        )}

        {hasAgendamentos && (
          <div className="calendar-wrapper">
            <div className={`loading-container ${showLoading ? 'show' : ''}`}>
              <LoadingSpinner message={'Carregando calendário...'} />
            </div>
            <div ref={calendarRef} className="fullcalendar" style={{ opacity: showLoading ? 0 : 1, transition: 'opacity 0.4s ease' }} />
          </div>
        )}

        <AgendamentoModal
          isOpen={modalOpen}
          agendamento={agendamentoSelecionado}
          onClose={() => setModalOpen(false)}
        />
      </main>
    </div>
  );
};

export default SecretariaCalendarView;