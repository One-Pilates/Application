import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LandingPage from './pages/landing/LandingPage';
import DashboardSecretary from './pages/dashboardSecretary/DashboardSecretary';
import DashboardTeacher from './pages/dashboardTeacher/DashboardTeacher';
import NotFound from './pages/notfound/notfound';
import Login from './pages/login/Login';
import Register from './pages/register/Register';
import './styles/App.scss';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/dashboardTeacher" element={<DashboardTeacher />} />
        <Route path="/dashboardSecretary" element={<DashboardSecretary/>} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}

export default App;