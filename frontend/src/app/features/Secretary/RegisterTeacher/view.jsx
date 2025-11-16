
import { FaArrowLeft } from "react-icons/fa";
import StepIndicator from "./components/StepIndicator";
import Button from "./components/Button";
import DadosPessoaisScreen from "./screens/DadosPessoais";
import EnderecoScreen from "./screens/Endereco";
import InformacoesProfissionaisScreen from "./screens/InformacoesProfissionais";
import ConfirmacaoScreen from "./screens/Confirmacao";
import './style.scss';


const RegisterTeacherView = ({
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
  finalizar,
  concluir,
  voltar,
}) => {
  const renderEtapa = () => {
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
          <EnderecoScreen
            dados={endereco}
            atualizar={atualizarEndereco}
            buscarCep={buscarCep}
          />
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

  return (
    <div className="register-container">
      <div className="register-header">
        <button className="back-button" onClick={voltar}>
          <FaArrowLeft />
          <span>Voltar</span>
        </button>
        <h1 className="main-title">Cadastrar Professor</h1>
      </div>

      <div className="register-content">
        <div className="register-card">
          <StepIndicator
            steps={etapas}
            currentStep={etapaAtual}
          />

          <p className="subtitle">
            Preencha os dados abaixo para cadastrar um novo professor
          </p>

          <form className="register-form" onSubmit={(e) => e.preventDefault()}>
            {renderEtapa()}

            <div className="button-group">
              {etapaAtual > 1 && etapaAtual < 4 && (
                <Button variant="secondary" onClick={etapaAnterior}>
                  Voltar
                </Button>
              )}

              {etapaAtual < 4 && (
                <Button variant="primary" onClick={proximaEtapa}>
                  {etapaAtual === 3 ? "Confirmar" : "Próximo"}
                </Button>
              )}

              {etapaAtual === 4 && (
                <Button variant="primary" onClick={concluir}>
                  Finalizar
                </Button>
              )}
            </div>
          </form>
        </div>
      </div>
    </div>
  );
};

export default RegisterTeacherView;
