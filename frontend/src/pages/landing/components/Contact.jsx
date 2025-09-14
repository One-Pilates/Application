import '../styles/Contact.scss';
import Button from './Button';

export default function Contact() {
  return (
    <section id="contact" className="contact">
      <div className="container">
        <div className="contact-content">

          {/* Coluna Esquerda: Mapa */}
          <div className="contact-map">
            <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d58527.1334970865!2d-46.676152560448834!3d-23.53445017723577!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x94ce59971fafccd9%3A0xb26de13ea6e41891!2sOne%20Pilates-%20Studio%20de%20Pilates!5e0!3m2!1spt-BR!2sbr!4v1757821649258!5m2!1spt-BR!2sbr"
              allowFullScreen=""
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
            ></iframe>
          </div>


          {/* Coluna Direita: Formulário */}
          <div className="contact-form">
            <h2>Contate-nos</h2>
            <p>R. Abílio Soares, 233 - Paraíso, São Paulo - SP, 04005-001</p>

            <form>
              <div className="form-group">
                <input type="text" placeholder="Nome *" required />
              </div>
              <div className="form-group">
                <input type="email" placeholder="Email" />
              </div>
              <div className="form-group">
                <textarea placeholder="Mensagem *" required></textarea>
              </div>
              <Button text="Enviar Mensagem" className='btn-submit' />
            </form>
          </div>

        </div>
      </div>
    </section>
  );
};

