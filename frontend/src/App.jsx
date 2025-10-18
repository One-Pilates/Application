import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

import PublicRoutes from './app/routes/PublicRoutes';
import TeacherRoutes from './app/routes/TeacherRoutes';
import SecretaryRoutes from './app/routes/SecretaryRoutes';
import NotFound from './app/routes/NotFound';

import './app/shared/styles/App.scss';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/*" element={<PublicRoutes />} />
        <Route path="/professora/*" element={<TeacherRoutes />} />
        <Route path="/secretaria/*" element={<SecretaryRoutes />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}

export default App;
