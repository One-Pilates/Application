import React from 'react';
import { useNavigate } from 'react-router-dom';
import './NotFound.scss';
import LightRays from './Effect404';

export default function NotFound() {
  const navigate = useNavigate(); 

  const handleGoBack = () => {
    navigate(-1)
  };

  return (
    <div className="notfound-container">
      <div className="background-gradient"></div>
      <div className="content">
        <h1 className="title">404</h1>
        <p className="subtitle">Página não encontrada</p>
        <button className="back-button" onClick={handleGoBack}>
          Voltar para a página anterior
        </button>
      </div>
      <div className="custom-rays">
        <LightRays
          raysOrigin="top-center"
          raysColor="#F77433"
          raysSpeed={1.5}
          lightSpread={0.8}
          rayLength={1.2}
          followMouse={true}
          mouseInfluence={0.1}
          noiseAmount={0.1}
          distortion={0.05}
        />
      </div>
    </div>
  );
}