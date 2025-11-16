import React from "react";
import "./input.scss";

export default function Input({
  label,
  type = "text",
  placeholder = "",
  value = "",
  onChange = () => {},
  required = false,
  disabled = false,
  maxLength,
  ...props
}) {
  return (
    <div className="input-container">
      {label && (
        <label className="input-label">
          {label}
          {required && <span className="input-required">*</span>}
        </label>
      )}
      <input
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={onChange}
        required={required}
        disabled={disabled}
        maxLength={maxLength}
        className="input-field"
        {...props}
      />
    </div>
  );
}
