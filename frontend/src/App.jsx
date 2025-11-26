import { Routes, Route } from 'react-router-dom';

import PrivateRoutes from './app/routes/PrivateRoutes';
import PublicRoutes from './app/routes/PublicRoutes';
import TeacherRoutes from './app/routes/TeacherRoutes';
import SecretaryRoutes from './app/routes/SecretaryRoutes';

import './app/shared/styles/App.scss';

function App() {
  return (
    <Routes>
      {/* Rotas privadas */}
      <Route element={<PrivateRoutes />}>
        <Route path="/professora/*" element={<TeacherRoutes />} />
        <Route path="/secretaria/*" element={<SecretaryRoutes />} />
      </Route>
      
      {/* Rotas públicas */}
      <Route path="/*" element={<PublicRoutes />} />
    </Routes>
  );
}

export default App;
