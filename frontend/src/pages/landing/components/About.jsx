import Button from '../components/Button';
import '../styles/About.scss';

const About = () => {
  return (
    <section id="about" className="about">
      <div className="container">
        <div className="about-content">
          <div className="about-text slide-in-left">
            <h2>Sobre nossa trajetória...</h2>
            <p>
              Com anos de experiência no método Pilates, nossa equipe é formada por profissionais 
              altamente qualificados que se dedicam a proporcionar a melhor experiência em 
              condicionamento físico e bem-estar.
            </p>
            <p>
              Acreditamos que o Pilates vai além do exercício físico - é um estilo de vida que 
              promove equilíbrio entre corpo e mente.
            </p>
            <Button>Conheça Nossa História</Button>
          </div>
          <div className="about-image slide-in-right">
            <img src="/about-image.jpg" alt="Nossa História" />
          </div>
        </div>
      </div>
    </section>
  );
};

export default About;