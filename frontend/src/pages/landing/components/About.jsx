import "../styles/About.scss";
import { FaPlus, FaTimes, FaCalendarPlus, FaAddressBook } from "react-icons/fa";
import Botao from "../../components/Button";

export default function About() {
  return (
    <section className="about">
      <div className="about__container">
        
        <div className="about__content">
          <p className="about__subtitle">+20 ANOS DE HISTORIA</p>
          <h2 className="about__title">Sobre nossa trajetória...</h2>
          <p className="about__text">
            Somos um Studio de Pilates localizado em São Paulo com excelentes profissionais e
            equipamentos de última geração, estamos localizados bem próximos à Av. Paulista e ao Metrô Paraíso.
          </p>
          <Botao cor="bg-main" icone={FaPlus} texto="Mais Detalhes"/>
        </div>

        <div className="about__image">
          <img
            src="/about.png" 
            alt="Studio de Pilates"
          />
        </div>
      </div>
    </section>
  );
}