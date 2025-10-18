import React from 'react';
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
  calendarRef
}) => (
  <div className="calendar-container">
    <main className="calendar-main">
      <div className="calendar-header-info">
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
      onClose={() => { setIsAulaModalOpen(false); setSelectedAula(null); }}
    />

    <DefinirAusenciaModal
      isOpen={isAusenciaModalOpen}
      onClose={() => setIsAusenciaModalOpen(false)}
    />
  </div>
);

export default CalendarView;
