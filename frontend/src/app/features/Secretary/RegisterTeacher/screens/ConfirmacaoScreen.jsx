import React from "react";
import { FaCheckCircle } from "react-icons/fa";
import '../style.scss';

export default function ConfirmacaoScreen({
  dadosPessoais,
  endereco,
  informacoesProfissionais,
}) {
  const CardInfo = ({ label, valor }) => (
    <div className={styles.cardInfo}>
      <span className={styles.cardLabel}>{label}</span>
      <span className={styles.cardValue}>{valor || "---"}</span>
    </div>
  );

  return (
    <div className={styles.confirmacao}>
      <div className={styles.successIcon}>
        <FaCheckCircle size={48} color="#22C55E" />
      </div>

      <h2 className={styles.confirmTitle}>Cadastro feito com sucesso!</h2>
      <p className={styles.confirmMessage}>
        A senha foi gerada e enviada ao email do usuário
      </p>

      <div className={styles.dataSection}>
        <h3 className={styles.sectionTitle}>Dados Pessoais</h3>
        <div className={styles.cardGrid}>
          <CardInfo label="Nome" valor={dadosPessoais.nomeCompleto} />
          <CardInfo label="Email" valor={dadosPessoais.email} />
          <CardInfo label="CPF" valor={dadosPessoais.cpf} />
          <CardInfo label="Data de Nascimento" valor={dadosPessoais.dataNascimento} />
          <CardInfo label="Telefone" valor={dadosPessoais.telefone} />
        </div>
      </div>

      <div className={styles.dataSection}>
        <h3 className={styles.sectionTitle}>Endereço</h3>
        <div className={styles.cardGrid}>
          <CardInfo label="CEP" valor={endereco.cep} />
          <CardInfo label="Logradouro" valor={endereco.logradouro} />
          <CardInfo label="Número" valor={endereco.numero} />
          <CardInfo label="Bairro" valor={endereco.bairro} />
          <CardInfo label="Cidade" valor={endereco.cidade} />
          <CardInfo label="Estado" valor={endereco.estado} />
        </div>
      </div>

      <div className={styles.dataSection}>
        <h3 className={styles.sectionTitle}>Informações Profissionais</h3>
        <div className={styles.cardGrid}>
          <CardInfo label="Cargo" valor={informacoesProfissionais.cargo} />
          <div className={styles.cardInfo}>
            <span className={styles.cardLabel}>Especialidades</span>
            <div className={styles.tagContainer}>
              {informacoesProfissionais.especialidades?.length > 0 ? (
                informacoesProfissionais.especialidades.map((esp, index) => (
                  <span key={index} className={styles.tag}>
                    {esp}
                  </span>
                ))
              ) : (
                <span className={styles.cardValue}>---</span>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}