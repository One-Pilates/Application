import Input from "../components/Input";
import "./informacoesProfissionais.scss";

export default function InformacoesProfissionaisScreen({
  dados,
  atualizar,
  erros = {},
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
      <div className="professional-content">
        <Input
          label="Cargo"
          placeholder="Fisioterapeuta"
          value={dados.cargo}
          onChange={(e) => atualizar({ cargo: e.target.value })}
          required
          erro={erros.cargo}
        />

        <div className="especialidades-section">
          <label className="section-label">
            Especialidades
            <span className="section-required">*</span>
          </label>
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
          {erros.especialidades && (
            <span className="error-message">{erros.especialidades}</span>
          )}
        </div>
      </div>
    </div>
  );
}