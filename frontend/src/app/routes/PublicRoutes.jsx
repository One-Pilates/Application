import { Routes, Route } from 'react-router-dom';
import LandingPage from '../features/Landing/Index';
import Login from '../features/login/Login';
import NotFound from './NotFound';

export default function PublicRoutes() {
    return (
        <Routes>
            <Route path="/" element={<LandingPage />} />
            <Route path="/login" element={<Login />} />
            <Route path="*" element={<NotFound />} />
        </Routes>
    );
}
