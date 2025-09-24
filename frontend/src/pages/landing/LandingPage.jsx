import React from 'react';
import Navbar from './components/Navbar';
import Hero from './/components/Hero';
import Services from './components/Services';
import About from './components/About';
import Equipment from './components/Equipment';
import Contact from './components/Contact';
import Testimonials from './components/Testimonials';
import FAQ from './components/FAQ';
import Footer from './components/Footer';
import Slider from './components/Slider';
import Info from './components/Info';

export default function LandingPage() {
  return (
    <>
      <Navbar />
      <Hero />
      <Slider /> 
      <Services />
      <About />
      <Equipment />
      <Info />
      <Testimonials />
      <FAQ />
      <Contact />
      <Footer />
    </>
  );
}

