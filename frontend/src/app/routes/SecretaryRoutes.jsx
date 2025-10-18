import { Navigate, Routes, Route } from 'react-router-dom';
import Secretary from '../features/Secretary/Layout/Secretary';
import DashboardSecretary from '../features/Secretary/CalendarSecretary';
import ProfileSecretary from '../features/Secretary/ProfileSecretary';
import CalendarSecretary from '../features/Secretary/CalendarSecretary';
import RegisterTeacher from '../features/Secretary/RegisterTeacher';
import RegisterStudent from '../features/Secretary/RegisterStudent';
import NotFound from './NotFound';

export default function SecretaryRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Secretary />}>
        <Route index element={<Navigate to="dashboard" replace />} />
        <Route path="dashboard" element={<DashboardSecretary />} />
        <Route path="perfil" element={<ProfileSecretary />} />
        <Route path="agenda" element={<CalendarSecretary />} />
        <Route path="professor" element={<RegisterTeacher />} />
        <Route path="alunos" element={<RegisterStudent />} />
      </Route>

      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}
