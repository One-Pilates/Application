import React from "react";


export default function Button({ 
  children, 
  onClick, 
  type = "button", 
  variant = "primary", 
  disabled = false 
}) {
  const baseStyle = {
    padding: '0.625rem 1.5rem',
    fontSize: '0.875rem',
    fontWeight: '500',
    borderRadius: '0.5rem',
    border: 'none',
    cursor: disabled ? 'not-allowed' : 'pointer',
    transition: 'all 0.2s ease',
    display: 'inline-flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: '0.5rem',
    opacity: disabled ? 0.5 : 1,
  };

  const variants = {
    primary: {
      backgroundColor: '#3b82f6',
      color: 'white',
    },
    secondary: {
      backgroundColor: '#ef4444',
      color: 'white',
    },
  };

  const buttonStyle = { ...baseStyle, ...variants[variant] };

  return (
    <button
      type={type}
      onClick={onClick}
      disabled={disabled}
      style={buttonStyle}
    >
      {children}
    </button>
  );
}