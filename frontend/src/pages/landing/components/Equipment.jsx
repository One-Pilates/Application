import Slider from '../components/Slider';
import '../styles/Equipment.scss';


const Equipment = () => {
  const equipmentImages = [
    { src: '/equipment1.jpg', alt: 'Reformer' },
    { src: '/equipment2.jpg', alt: 'Cadillac' },
    { src: '/equipment3.jpg', alt: 'Chair' },
    { src: '/equipment4.jpg', alt: 'Barrel' }
  ];

  return (
    <section id="equipment" className="equipment">
      <div className="container">
        <h2>Nossos Equipamentos</h2>
        <p>Equipamentos de última geração para sua prática de Pilates</p>
        <div className="equipment-slider">
          <Slider images={equipmentImages} />
        </div>
      </div>
    </section>
  );
};

export default Equipment;