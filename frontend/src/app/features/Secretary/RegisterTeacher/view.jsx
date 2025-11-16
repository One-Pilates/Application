import React from "react";
import { IoChevronBack } from "react-icons/io5";
import StepIndicator from "./components/StepIndicator";
import DadosPessoaisScreen from "./screens/DadosPessoaisScreen";
import EnderecoScreen from "./screens/EnderecoScreen";
import InformacoesProfissionaisScreen from "./screens/InformacoesProfissionaisScreen";
import ConfirmacaoScreen from "./screens/ConfirmacaoScreen";
import Button from "./components/Button";


export default function RegisterTeacherView({
  etapaAtual,
  etapas,
  dadosPessoais,
  endereco,
  informacoesProfissionais,
  atualizarDadosPessoais,
  atualizarEndereco,
  atualizarInformacoesProfissionais,
  buscarCep,
  proximaEtapa,
  etapaAnterior,
  voltar,
  finalizar,
  concluir,
}) {
  const renderizarTela = () => {
    switch (etapaAtual) {
      case 1:
        return (
          <DadosPessoaisScreen
            dados={dadosPessoais}
            atualizar={atualizarDadosPessoais}
          />
        );
      case 2:
        return (
          <EnderecoScreen dados={endereco} atualizar={atualizarEndereco} />
        );
      case 3:
        return (
          <InformacoesProfissionaisScreen
            dados={informacoesProfissionais}
            atualizar={atualizarInformacoesProfissionais}
          />
        );
      case 4:
        return (
          <ConfirmacaoScreen
            dadosPessoais={dadosPessoais}
            endereco={endereco}
            informacoesProfissionais={informacoesProfissionais}
          />
        );
      default:
        return null;
    }
  };

  const manipularSubmit = (e) => {
    e.preventDefault();

    if (etapaAtual < 3) {
      proximaEtapa();
    } else if (etapaAtual === 3) {
      finalizar();
    } else {
      concluir();
    }
  };

  const obterTextoBotao = () => {
    if (etapaAtual === 3) return "Cadastrar";
    if (etapaAtual === 4) return "Concluir";
    return "Continuar";
  };

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <button onClick={voltar} className={styles.backButton}>
          <IoChevronBack size={20} />
          Voltar
        </button>
        <h1 className={styles.mainTitle}>Cadastro Professor</h1>
      </div>

      <div className={styles.content}>
        <div className={styles.card}>
          {etapaAtual < 4 && (
            <>
              <p className={styles.subtitle}>
                Preencha os dados para criar a conta
              </p>
              <StepIndicator steps={etapas} currentStep={etapaAtual} />
            </>
          )}

          <form onSubmit={manipularSubmit} className={styles.form}>
            {renderizarTela()}

            <div className={styles.buttonGroup}>
              {etapaAtual > 1 && etapaAtual < 4 && (
                <Button
                  type="button"
                  variant="secondary"
                  onClick={etapaAnterior}
                >
                  Voltar
                </Button>
              )}
              <Button type="submit" variant="primary">
                {obterTextoBotao()}
              </Button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}