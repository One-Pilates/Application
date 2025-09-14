import '../styles/Button.scss';

export default function Button({ text, variant = 'primary', onClick, className = '' }) {
  return (
    <button 
      className={`btn btn-${variant} ${className}`}
      onClick={onClick}
    >
      {text}
    </button>
  );
};
