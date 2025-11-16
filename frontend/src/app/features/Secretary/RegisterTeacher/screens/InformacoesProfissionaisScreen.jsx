import React from "react";
import Input from "../components/Input";
import '../style.scss';

export default function InformacoesProfissionaisScreen({ dados, atualizar }) {
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
    <div className={styles.screen}>
      <h2 className={styles.screenTitle}>Informações Profissionais</h2>

      <div className={styles.professionalContent}>
        <Input
          label="Cargo"
          placeholder="Fisioterapeuta"
          value={dados.cargo}
          onChange={(e) => atualizar({ cargo: e.target.value })}
          required
        />

        <div className={styles.especialidadesSection}>
          <label className={styles.sectionLabel}>Especialidades</label>
          <div className={styles.checkboxGrid}>
            {especialidades.map((especialidade) => (
              <label key={especialidade} className={styles.checkboxLabel}>
                <input
                  type="checkbox"
                  checked={dados.especialidades?.includes(especialidade) || false}
                  onChange={() => manipularEspecialidade(especialidade)}
                  className={styles.checkbox}
                />
                <span className={styles.checkboxText}>{especialidade}</span>
              </label>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}