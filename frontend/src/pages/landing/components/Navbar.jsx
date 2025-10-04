import React, { useState, useEffect } from 'react';
import '../styles/Navbar.scss';
import { Link } from 'react-router-dom';
import Botao from '../../components/Button';

export default function Navbar() {
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const scrollTop = window.scrollY;
      setIsScrolled(scrollTop > 100);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <nav className={`navbar ${isScrolled ? 'navbar-scrolled' : ''}`}>
      <div className="navbar-container">
        <div className="navbar-logo">
          <img  src={isScrolled ? "/logoBranca.png" : "/logoOriginal.png"} alt="One Pilates" />
        </div>
        <ul className="navbar-menu">
          <li><a href="#home">Home</a></li>
          <li><a href="#services">Serviços</a></li>
          <li><a href="#about">Sobre</a></li>
          <li><a href="#equipment">Equipamentos</a></li>
          <li><a href="#testimonials">Depoimentos</a></li>
          <li><a href="#contact">Contato</a></li>
          <Link to="/DashboardTeacher"><Botao texto="Login" cor="bg-main"/></Link>
        </ul>
      </div>
    </nav>
  );
};

