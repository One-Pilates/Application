import { Routes, Route } from 'react-router-dom';
import LandingPage from '../features/Landing/Index';
import Login from '../features/Login/Login';
import NotFound from './NotFound';
import CodigoVerificacao from '../features/login/CodigoVerificacao';
import EsqueciSenha from '../features/login/EsqueciSenha';
import NovaSenha from '../features/login/NovaSenha';

export default function PublicRoutes() {
    return (
        <Routes>
            <Route path='/EsqueciSenha' element={<EsqueciSenha/>}></Route>
            <Route path='/NovaSenha' element={<NovaSenha/>}></Route>
            <Route path='/Codigo' element={<CodigoVerificacao/>}></Route>
            <Route path="/" element={<LandingPage />} />
            <Route path="/login" element={<Login />} />
            <Route path="*" element={<NotFound />} />
        </Routes>
    );
}
