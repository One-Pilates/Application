import React, { useEffect } from 'react';

export default function VLibras() {
  useEffect(() => {
    if (!window.vlibrasInitialized) {
      const script = document.createElement('script');
      script.src = 'https://vlibras.gov.br/app/vlibras-plugin.js';
      script.async = true;
      document.body.appendChild(script);

      script.onload = () => {
        new window.VLibras.Widget('https://vlibras.gov.br/app');
        window.vlibrasInitialized = true; 
      };
    }
  }, []);

  return (
    <div vw="true" className="enabled">
      <div vw-access-button="true" className="active"></div>
      <div vw-plugin-wrapper="true">
        <div className="vw-plugin-top-wrapper"></div>
      </div>
    </div>
  );
}
