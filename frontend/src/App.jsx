import Navbar from './pages/landing/components/Navbar';
import Hero from './pages/landing/components/Hero';
import Services from './pages/landing/components/Services';
import About from './pages/landing/components/About';
import Equipment from './pages/landing/components/Equipment';
import Contact from './pages/landing/components/Contact';
import Testimonials from './pages/landing/components/Testimonials';
import FAQ from './pages/landing/components/FAQ';
import Footer from './pages/landing/components/Footer';
import Slider from './pages/landing/components/Slider';
import Info from './pages/landing/components/Info';
import './styles/App.scss';

function App() {
  return (
    <div className="App">
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
    </div>
  );
}

export default App;