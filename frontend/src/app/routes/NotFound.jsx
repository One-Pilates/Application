import '../shared/styles/NotFound.scss';
import { Link } from 'react-router-dom';
import { RiEmotionSadLine } from 'react-icons/ri';
import { FiHome } from 'react-icons/fi';


export default function NotFound() {
  return (
    <div className="not-found-container">
      <div className="not-found-content">
        <RiEmotionSadLine size={80} color="#FF6B35" />
        <h1 className="not-found-title">404 - Página Não Encontrada</h1>
        <p className="not-found-message">Desculpe, a página que você está procurando não existe.</p>
        <div className="not-found-actions">
          <Link to="/"><FiHome size={24} /></Link>
        </div>
      </div>
    </div>
  );
}