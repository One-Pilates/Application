import Button from '../components/Button';
import '../styles/Hero.scss';

export default function Hero() {
  return (
    <section id="home" className="hero">
      <div className="hero-overlay" />

      <div className="hero-container">
        <div className="hero-content">
          <h1>Transforme seu corpo, descubra sua melhor versão.</h1>
          <p>"Porque seu corpo é único e merece cuidado exclusivo."</p>

          <div className="hero-buttons">
            <img src="/whatsapp-logo.png" alt="WhatsApp" className="whatsapp-icon" />
            <Button variant="primary" className="cta-btn" text="Chamar no WhatsApp"
              onClick={() =>
                window.open('https://api.whatsapp.com/send/?phone=551130514139&text=Ol%C3%A1%2C+consegui+o+contato+atrav%C3%A9s+do+site+e+gostaria+de+mais+informa%C3%A7%C3%B5es+sobre+o+studio.&type=phone_number&app_absent=0', '_blank')}>
            </Button>

            <div className="whatsapp-info">
              <div className="whatsapp-texts">
                <span className="whatsapp-text">+20 anos cuidando de você</span>
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
