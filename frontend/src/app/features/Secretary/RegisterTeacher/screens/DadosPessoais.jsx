import { useRef } from "react";
import { FaCamera } from "react-icons/fa";
import Input from "../components/Input";
import "./dadosPessoais.scss";

export default function DadosPessoaisScreen({
  dados,
  atualizar,
}) {
  const fileInputRef = useRef(null);

  const manipularArquivo = (e) => {
    const arquivo = e.target.files?.[0];
    if (arquivo) {
      const leitor = new FileReader();
      leitor.onloadend = () => {
        atualizar({ fotoPerfil: leitor.result });
      };
      leitor.readAsDataURL(arquivo);
    }
  };

  return (
    <div className="dados-pessoais-screen">
      <h2 className="screen-title">Dados Pessoais</h2>

      <div className="photo-section">
        <div className="photo-container">
          {dados.fotoPerfil ? (
            <img src={dados.fotoPerfil} alt="Foto de perfil" className="photo" />
          ) : (
            <div className="photo-placeholder">
              <FaCamera size={32} color="#9CA3AF" />
            </div>
          )}
        </div>
        <button
          type="button"
          className="upload-button"
          onClick={() => fileInputRef.current?.click()}
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

      <div className="form-grid">
        <div className="full-width">
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
          placeholder="535.929.091-02"
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
