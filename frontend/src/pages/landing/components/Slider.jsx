import '../styles/Slider.scss';
import React, { useState, useEffect } from 'react';

export default function Slider({ images = [], autoSlide = true, slideInterval = 3000 }) {
  const [currentSlide, setCurrentSlide] = useState(0);

  useEffect(() => {
    if (autoSlide) {
      const interval = setInterval(() => {
        setCurrentSlide((prev) => (prev + 1) % images.length);
      }, slideInterval);

      return () => clearInterval(interval);
    }
  }, [autoSlide, slideInterval, images.length]);

  const nextSlide = () => {
    setCurrentSlide((prev) => (prev + 1) % images.length);
  };

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev - 1 + images.length) % images.length);
  };

  return (
    <div className="slider">
      <div className="slider-container">
        <div 
          className="slider-wrapper"
          style={{ transform: `translateX(-${currentSlide * 100}%)` }}
        >
          {images.map((image, index) => (
            <div key={index} className="slide">
              <img src={image.src} alt={image.alt} />
            </div>
          ))}
        </div>
        <button className="slider-btn prev" onClick={prevSlide}>
          &#8249;
        </button>
        <button className="slider-btn next" onClick={nextSlide}>
          &#8250;
        </button>
        <div className="slider-dots">
          {images.map((_, index) => (
            <button
              key={index}
              className={`dot ${currentSlide === index ? 'active' : ''}`}
              onClick={() => setCurrentSlide(index)}
            />
          ))}
        </div>
      </div>
    </div>
  );
};

