import '../styles/Footer.scss';
import { FaFacebookF, FaInstagram } from 'react-icons/fa';

export default function Footer() {
  return (
    <footer className="footer">
      <div className="container">
        <div className="footer-content">

          <div className="footer-logo">
            <img src="/logoOriginal.png" alt="One Pilates" />
            <h3>One Pilates</h3>
            <span>Porque seu Corpo é Único</span>
          </div>

          <div className="footer-about">
            <p>
              Somos um Studio de Pilates localizado em São Paulo com excelentes profissionais
              e equipamentos de última geração.
            </p>
          </div>

          <div className="footer-links">
            <h4>Navegação</h4>
              <a href="#home">Home</a>
              <a href="#services">Serviços</a>
              <a href="#about">Sobre</a>
              <a href="#equipment">Equipamentos</a>
              <a href="#testimonials">Depoimentos</a>
              <a href="#contact">Contato</a>

            <div className="footer-social">
              <a 
                href="https://www.facebook.com/onepilates31" 
                target="_blank" 
                rel="noopener noreferrer" 
                aria-label="Facebook"
              >
                <FaFacebookF />
              </a>
              <a 
                href="https://www.instagram.com/one_pilates/" 
                target="_blank" 
                rel="noopener noreferrer" 
                aria-label="Instagram"
              >
                <FaInstagram />
              </a>
            </div>
          </div>

        </div>

        <div className="footer-bottom">
          <p>&copy; 2025 One Pilates – Todos os direitos reservados.</p>
        </div>
      </div>
    </footer>
  );
};
