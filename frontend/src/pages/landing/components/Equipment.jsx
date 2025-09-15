import "../styles/About.scss";

export default function Equipment() {
  return (
    <section className="about">
      <div className="about__container">
        
        <div className="about__image">
          <img src="/1.jpg" alt="Studio de Pilates" />
        </div>

        <div className="about__content">
          <h2 className="about__title">Nossos Equipamentos</h2>
          <p className="about__text">
            Aqui na OnePilates sua saúde e segurança estão em primeiro lugar,
            todos os nossos equipamentos são Physio Pilates, marca conceituada
            por sua qualidade e pioneirismo.
          </p>
          <button className="about__button">Mais Detalhes</button>
        </div>

      </div>
    </section>
  );
}
