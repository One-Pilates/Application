import { Routes, Route } from 'react-router-dom';
import LandingPage from '../features/Landing/Index';
import Login from '../features/Login/Login';
import NotFound from './NotFound';
import CodigoVerificacao from '../features/Login/CodigoVerificacao';
import EsqueciSenha from '../features/Login/EsqueciSenha';
import NovaSenha from '../features/Login/NovaSenha';

export default function PublicRoutes() {
  return (
    <Routes>
      <Route path="/" element={<LandingPage />} />

      <Route path="/login" element={<Login />} />
      <Route path="/login/esqueci-senha" element={<EsqueciSenha />} />
      <Route path="/login/codigo-verificacao" element={<CodigoVerificacao />} />
      <Route path="/login/nova-senha" element={<NovaSenha />} />

      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}
