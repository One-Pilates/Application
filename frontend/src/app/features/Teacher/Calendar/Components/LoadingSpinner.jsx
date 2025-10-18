import React from 'react';
import { FiLoader } from 'react-icons/fi';
import '../Styles/Loading.scss';


const LoadingSpinner = () => (
  <div className="loading-container">
    <div className="loading-spinner"><FiLoader size={48} /></div>
    <p className="loading-text">Carregando calendário...</p>
  </div>
);

export default LoadingSpinner;
