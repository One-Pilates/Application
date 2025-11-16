import React, { useRef } from "react";
import { FaCamera } from "react-icons/fa";
import Input from "../components/Input";
import '../style.scss';
export default function DadosPessoaisScreen({ dados, atualizar }) {
  const fileInputRef = useRef(null);

  const manipularArquivo = (e) => {
    const arquivo = e.target.files[0];
    if (arquivo) {
      const leitor = new FileReader();
      leitor.onloadend = () => {
        atualizar({ fotoPerfil: leitor.result });
      };
      leitor.readAsDataURL(arquivo);
    }
  };

  return (
    <div className={styles.screen}>
      <h2 className={styles.screenTitle}>Dados Pessoais</h2>

      <div className={styles.photoSection}>
        <div className={styles.photoContainer}>
          {dados.fotoPerfil ? (
            <img src={dados.fotoPerfil} alt="Foto de perfil" className={styles.photo} />
          ) : (
            <div className={styles.photoPlaceholder}>
              <FaCamera size={32} color="#9CA3AF" />
            </div>
          )}
        </div>
        <button
          type="button"
          className={styles.uploadButton}
          onClick={() => fileInputRef.current.click()}
        >
          Selecione a foto de perfil
        </button>
        <input
          ref={fileInputRef}
          type="file"
          accept="image/*"
          onChange={manipularArquivo}
          style={{ display: "none" }}
        />
      </div>

      <div className={styles.formGrid}>
        <div className={styles.fullWidth}>
          <Input
            label="Nome completo"
            placeholder="Digite o nome completo"
            value={dados.nomeCompleto}
            onChange={(e) => atualizar({ nomeCompleto: e.target.value })}
            required
          />
        </div>

        <Input
          label="Email"
          type="email"
          placeholder="Digite o e-mail"
          value={dados.email}
          onChange={(e) => atualizar({ email: e.target.value })}
          required
        />

        <Input
          label="CPF"
          placeholder="535.929.0910.02-1"
          value={dados.cpf}
          onChange={(e) => atualizar({ cpf: e.target.value })}
          maxLength={14}
          required
        />

        <Input
          label="Data de nascimento"
          type="date"
          value={dados.dataNascimento}
          onChange={(e) => atualizar({ dataNascimento: e.target.value })}
          required
        />

        <Input
          label="Telefone"
          type="tel"
          placeholder="(11) 93457-5552"
          value={dados.telefone}
          onChange={(e) => atualizar({ telefone: e.target.value })}
          maxLength={15}
          required
        />
      </div>
    </div>
  );
}