import Input from "../components/Input";
import "./informacoesProfissionais.scss";

export default function InformacoesProfissionaisScreen({
  dados,
  atualizar,
}) {
  const especialidades = [
    "Fisioterapia",
    "Pilates",
    "Drenagem",
    "RPG",
    "Massagem",
    "Massoterapia",
    "Osteopatia",
    "Acupuntura",
  ];

  const manipularEspecialidade = (especialidade) => {
    const especialidadesAtuais = dados.especialidades || [];
    const novasEspecialidades = especialidadesAtuais.includes(especialidade)
      ? especialidadesAtuais.filter((e) => e !== especialidade)
      : [...especialidadesAtuais, especialidade];

    atualizar({ especialidades: novasEspecialidades });
  };

  return (
    <div className="informacoes-profissionais-screen">
      <h2 className="screen-title">Informações Profissionais</h2>

      <div className="professional-content">
        <Input
          label="Cargo"
          placeholder="Fisioterapeuta"
          value={dados.cargo}
          onChange={(e) => atualizar({ cargo: e.target.value })}
          required
        />

        <div className="especialidades-section">
          <label className="section-label">Especialidades</label>
          <div className="checkbox-grid">
            {especialidades.map((especialidade) => (
              <label key={especialidade} className="checkbox-label">
                <input
                  type="checkbox"
                  checked={dados.especialidades?.includes(especialidade) || false}
                  onChange={() => manipularEspecialidade(especialidade)}
                  className="checkbox-input"
                />
                <span className="checkbox-text">{especialidade}</span>
              </label>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
