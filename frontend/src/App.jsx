import { Routes, Route, useLocation } from 'react-router-dom';
import { useEffect, useState } from 'react';

import PrivateRoutes from './app/routes/PrivateRoutes';
import PublicRoutes from './app/routes/PublicRoutes';
import TeacherRoutes from './app/routes/TeacherRoutes';
import SecretaryRoutes from './app/routes/SecretaryRoutes';

import './app/shared/styles/App.scss';

function App() {
  const location = useLocation();
  const isPublicRoute = location.pathname === '/' || location.pathname.startsWith('/login');
  
  const [isDark, setIsDark] = useState(() => {
    const saved = localStorage.getItem('theme');
    if (saved) return saved === 'dark';
    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  });

  useEffect(() => {
    // Forçar modo claro em rotas públicas (login e landing)
    if (isPublicRoute) {
      document.documentElement.classList.remove('dark');
    } else {
      // Aplicar preferência do usuário apenas em rotas privadas
      if (isDark) {
        document.documentElement.classList.add('dark');
      } else {
        document.documentElement.classList.remove('dark');
      }
    }
  }, [isDark, isPublicRoute]);

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
