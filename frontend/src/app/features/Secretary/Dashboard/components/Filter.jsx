const Filter = ({ value, onChange }) => {
  const periods = [
    { value: 7, label: 'Últimos 7 dias' },
    { value: 30, label: 'Últimos 30 dias' },
    { value: 90, label: 'Últimos 90 dias' }
  ];

  return (
    <select 
      value={value} 
      onChange={(e) => onChange(Number(e.target.value))}
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