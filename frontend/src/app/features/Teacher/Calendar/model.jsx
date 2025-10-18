import { useState, useEffect, useRef } from 'react';

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

export const useCalendarModel = () => {
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
        script.onload = () => setTimeout(initCalendar, 100);
        script.onerror = () => setIsLoading(false);
        document.body.appendChild(script);
      } catch {
        setIsLoading(false);
      }
    };

    const initCalendar = () => {
      if (!calendarRef.current) return;
      if (calendarInstance.current) calendarInstance.current.destroy();

      const calendar = new window.FullCalendar.Calendar(calendarRef.current, {
        initialView: 'timeGridWeek',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        buttonText: { today: 'Hoje', month: 'Mês', week: 'Semana', day: 'Dia' },
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
        eventDidMount: (info) => info.el.style.cursor = 'pointer'
      });

      calendar.render();
      calendarInstance.current = calendar;
      setTimeout(() => setIsLoading(false), 300);
    };

    loadFullCalendar();

    return () => {
      if (calendarInstance.current) {
        calendarInstance.current.destroy();
        calendarInstance.current = null;
      }
    };
  }, []);

  return {
    selectedAula,
    setSelectedAula,
    isAulaModalOpen,
    setIsAulaModalOpen,
    isAusenciaModalOpen,
    setIsAusenciaModalOpen,
    isLoading,
    calendarRef
  };
};
