import '../styles/Testimonials.scss';

const Testimonials = () => {
  const testimonials = [
    {
      name: 'Maria Silva',
      text: 'O Pilates mudou minha vida. Sinto-me mais forte e flexível.',
      rating: 5
    },
    {
      name: 'João Santos',
      text: 'Profissionais excelentes e ambiente acolhedor.',
      rating: 5
    },
    {
      name: 'Ana Costa',
      text: 'Recomendo para todos que buscam qualidade de vida.',
      rating: 5
    }
  ];

  return (
    <section id="testimonials" className="testimonials">
      <div className="container">
        <h2>Testemunhos</h2>
        <div className="testimonials-grid">
          {testimonials.map((testimonial, index) => (
            <div key={index} className="testimonial-card">
              <div className="stars">
                {'★'.repeat(testimonial.rating)}
              </div>
              <p>"{testimonial.text}"</p>
              <h4>{testimonial.name}</h4>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Testimonials;
