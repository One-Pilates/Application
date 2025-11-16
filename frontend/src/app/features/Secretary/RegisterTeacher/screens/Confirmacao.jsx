import { FaCheckCircle } from "react-icons/fa";
import "./confirmacao.scss";

const CardInfo = ({ label, valor }) => (
  <div className="card-info">
    <span className="card-label">{label}</span>
    <span className="card-value">{valor || "---"}</span>
  </div>
);

export default function ConfirmacaoScreen({
  dadosPessoais,
  endereco,
  informacoesProfissionais,
}) {
  return (
    <div className="confirmacao-screen">
      <div className="success-icon">
        <FaCheckCircle size={48} color="#22C55E" />
      </div>

      <h2 className="confirm-title">Cadastro feito com sucesso!</h2>
      <p className="confirm-message">
        A senha foi gerada e enviada ao email do usuário
      </p>

      <div className="data-section">
        <h3 className="section-title">Dados Pessoais</h3>
        <div className="card-grid">
          <CardInfo label="Nome" valor={dadosPessoais.nomeCompleto} />
          <CardInfo label="Email" valor={dadosPessoais.email} />
          <CardInfo label="CPF" valor={dadosPessoais.cpf} />
          <CardInfo label="Data de Nascimento" valor={dadosPessoais.dataNascimento} />
          <CardInfo label="Telefone" valor={dadosPessoais.telefone} />
        </div>
      </div>

      <div className="data-section">
        <h3 className="section-title">Endereço</h3>
        <div className="card-grid">
          <CardInfo label="CEP" valor={endereco.cep} />
          <CardInfo label="Logradouro" valor={endereco.logradouro} />
          <CardInfo label="Número" valor={endereco.numero} />
          <CardInfo label="Bairro" valor={endereco.bairro} />
          <CardInfo label="Cidade" valor={endereco.cidade} />
          <CardInfo label="Estado" valor={endereco.estado} />
        </div>
      </div>

      <div className="data-section">
        <h3 className="section-title">Informações Profissionais</h3>
        <div className="card-grid">
          <CardInfo label="Cargo" valor={informacoesProfissionais.cargo} />
          <div className="card-info">
            <span className="card-label">Especialidades</span>
            <div className="tag-container">
              {informacoesProfissionais.especialidades?.length > 0 ? (
                informacoesProfissionais.especialidades.map((esp, index) => (
                  <span key={index} className="tag">
                    {esp}
                  </span>
                ))
              ) : (
                <span className="card-value">---</span>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}