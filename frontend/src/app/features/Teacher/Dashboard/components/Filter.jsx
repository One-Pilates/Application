import { useState } from 'react';

const Filter = ({ onChange }) => {
  const [selectedPeriod, setSelectedPeriod] = useState(30); // valor padrão: 30 dias

  const periods = [
    { value: 7, label: 'Últimos 7 dias' },
    { value: 30, label: 'Últimos 30 dias' },
    { value: 90, label: 'Últimos 90 dias' }
  ];

  const handleChange = (e) => {
    const newValue = Number(e.target.value);
    setSelectedPeriod(newValue);
    
    if (onChange && typeof onChange === 'function') {
      onChange(newValue);
    }
  };

  return (
    <select 
      value={selectedPeriod} 
      onChange={handleChange}
      className="period-filter"
    >
      {periods.map(period => (
        <option key={period.value} value={period.value}>
          {period.label}
        </option>
      ))}
    </select>
  );
};

export default Filter;