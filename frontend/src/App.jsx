import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';

import LandingPage from './pages/landing/LandingPage';
import Login from './pages/login/Login';
import Register from './pages/register/Register';

import DashboardTeacher from './pages/dashboardTeacher/DashboardTeacher';
import ProfileTeacher from './pages/dashboardTeacher/ProfileTeacher';
import AgendaTeacher from './pages/dashboardTeacher/CalendarTeacher';

import DashboardSecretary from './pages/dashboardSecretary/DashboardSecretary';
import ProfileSecretary from './pages/dashboardSecretary/ProfileSecretary';
import CalendarSecretary from './pages/dashboardSecretary/CalendarSecretary';
import RegisterTeacher from './pages/dashboardSecretary/RegisterTeacher';
import RegisterStudent from './pages/dashboardSecretary/RegisterStudent';

import NotFound from './pages/notfound/notfound';

import Teacher from './pages/dashboardTeacher/layout/Teacher';
import Secretary from './pages/dashboardSecretary/Layout/Secretary';

import './styles/App.scss';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />

  
        <Route path="/professora" element={<Teacher />}>
          <Route index element={<Navigate to="dashboard" replace />} />
          <Route path="dashboard" element={<DashboardTeacher />} />
          <Route path="perfil" element={<ProfileTeacher />} />
          <Route path="agenda" element={<AgendaTeacher />} />
        </Route>
    

       <Route path="/secretaria" element={<Secretary />}>
          <Route index element={<Navigate to="dashboard" replace />} />
          <Route path="dashboard" element={<DashboardSecretary />} />
          <Route path="perfil" element={<ProfileSecretary />} />
          <Route path="agenda" element={<CalendarSecretary />} />
          <Route path="professor" element={<RegisterTeacher />} />
          <Route path="alunos" element={<RegisterStudent />} />
        </Route>

        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}

export default App;
