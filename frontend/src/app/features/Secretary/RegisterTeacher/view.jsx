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
  erros,
  atualizarDadosPessoais,
  atualizarEndereco,
  atualizarInformacoesProfissionais,
  buscarCep,
  proximaEtapa,
  etapaAnterior,
  irParaEtapa, // RECEBE A NOVA FUNÇÃO
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
            erros={erros}
          />
        );
      case 2:
        return (
          <EnderecoScreen
            dados={endereco}
            atualizar={atualizarEndereco}
            buscarCep={buscarCep}
            erros={erros}
          />
        );
      case 3:
        return (
          <InformacoesProfissionaisScreen
            dados={informacoesProfissionais}
            atualizar={atualizarInformacoesProfissionais}
            erros={erros}
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
        <h1 className="main-title"> Preencha os dados para criar a conta</h1>
        
      </div>

      <div className="register-content">
        <div className="register-card">
        
          <StepIndicator
            steps={etapas}
            currentStep={etapaAtual}
            onStepClick={irParaEtapa} // PASSA A FUNÇÃO AQUI
          />

          <form className="register-form" onSubmit={(e) => e.preventDefault()}>
            {renderEtapa()}

            {etapaAtual < 4 && (
              <div className="button-group">
                {etapaAtual > 1 && (
                  <Button variant="secondary" onClick={etapaAnterior}>
                    Cancelar
                  </Button>
                )}

                <Button variant="primary" onClick={proximaEtapa}>
                  {etapaAtual === 3 ? "Cadastrar" : "Continuar"}
                </Button>
              </div>
            )}

            {etapaAtual === 4 && (
              <div className="button-group">
                <Button variant="primary" onClick={concluir}>
                  Voltar
                </Button>
              </div>
            )}
          </form>
        </div>
      </div>
    </div>
  );
};

export default RegisterTeacherView;