import React, { useState, useEffect } from 'react';
import Button from './Components/Button';
import LoadingSpinner from './Components/LoadingSpinner';
import AulaModal from './Components/AulaModal';
import DefinirAusenciaModal from './Components/DefinirAusenciaModal';
import './Styles/calendar.scss';

const CalendarView = ({
  selectedAula,
  setSelectedAula,
  isAulaModalOpen,
  setIsAulaModalOpen,
  isAusenciaModalOpen,
  setIsAusenciaModalOpen,
  isLoading,
  calendarRef,
  calendarInstance
}) => {
  const [activeView, setActiveView] = useState('timeGridWeek'); // 👈 estado da view atual

  const handleChangeView = (viewName) => {
    const calendar = calendarInstance.current;
    if (calendar) {
      calendar.changeView(viewName);
      setActiveView(viewName); // 👈 atualiza botão ativo
    }
  };

  useEffect(() => {
    // quando o calendário carregar, define a view inicial
    if (calendarInstance.current) {
      setActiveView(calendarInstance.current.view?.type || 'timeGridWeek');
    }
  }, [calendarInstance]);

  return (
    <div className="calendar-container">
      <main className="calendar-main">
        <div className="calendar-header-info">
          {/* Botões de view à esquerda */}
          <div className="calendar-view-buttons">
            <button
              className={`filter-button ${activeView === 'dayGridMonth' ? 'active' : ''}`}
              onClick={() => handleChangeView('dayGridMonth')}
            >
              Mês
            </button>
            <button
              className={`filter-button ${activeView === 'timeGridWeek' ? 'active' : ''}`}
              onClick={() => handleChangeView('timeGridWeek')}
            >
              Semana
            </button>
            <button
              className={`filter-button ${activeView === 'timeGridDay' ? 'active' : ''}`}
              onClick={() => handleChangeView('timeGridDay')}
            >
              Dia
            </button>
          </div>

          {/* Botão Definir Ausência à direita */}
          <Button onClick={() => setIsAusenciaModalOpen(true)} disabled={isLoading}>
            Definir Ausência
          </Button>
        </div>

        <div className="calendar-wrapper">
          {isLoading && <LoadingSpinner />}
          <div
            ref={calendarRef}
            className="fullcalendar"
            style={{ opacity: isLoading ? 0 : 1, transition: 'opacity 0.3s' }}
          />
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

export default CalendarView;
