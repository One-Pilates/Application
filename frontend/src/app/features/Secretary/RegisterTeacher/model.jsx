import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";

export const useRegisterTeacherModel = () => {
  const navegar = useNavigate();
  const location = useLocation();
  const [etapaAtual, setEtapaAtual] = useState(1);

  // Pega dados do location.state se existir (para manter ao voltar)
  const dadosIniciais = location.state || {};

  const [dadosPessoais, setDadosPessoais] = useState(
    dadosIniciais.dadosPessoais || {
      fotoPerfil: "",
      nomeCompleto: "",
      email: "",
      cpf: "",
      dataNascimento: "",
      telefone: "",
    }
  );

  const [endereco, setEndereco] = useState(
    dadosIniciais.endereco || {
      cep: "",
      logradouro: "",
      numero: "",
      bairro: "",
      cidade: "",
      estado: "",
    }
  );

  const [informacoesProfissionais, setInformacoesProfissionais] = useState(
    dadosIniciais.informacoesProfissionais || {
      cargo: "",
      especialidades: [],
    }
  );

  const etapas = [
    { label: "Dados Pessoais" },
    { label: "Endereço" },
    { label: "Informações Profissionais" },
  ];

  const atualizarDadosPessoais = (novosDados) => {
    setDadosPessoais((prev) => ({ ...prev, ...novosDados }));
  };

  const atualizarEndereco = (novosDados) => {
    setEndereco((prev) => ({ ...prev, ...novosDados }));
  };

  const atualizarInformacoesProfissionais = (novosDados) => {
    setInformacoesProfissionais((prev) => ({ ...prev, ...novosDados }));
  };

  // Buscar CEP na API ViaCEP
  const buscarCep = async (cep) => {
    const cepLimpo = cep.replace(/\D/g, "");
    
    if (cepLimpo.length === 8) {
      try {
        const response = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
        const data = await response.json();

        if (!data.erro) {
          atualizarEndereco({
            logradouro: data.logradouro || "",
            bairro: data.bairro || "",
            cidade: data.localidade || "",
            estado: data.uf || "",
          });
        }
      } catch (erro) {
        console.error("Erro ao buscar CEP:", erro);
      }
    }
  };

  const proximaEtapa = () => {
    if (etapaAtual < 4) {
      setEtapaAtual(etapaAtual + 1);
    }
  };

  const etapaAnterior = () => {
    if (etapaAtual > 1) {
      setEtapaAtual(etapaAtual - 1);
    }
  };

  const voltar = () => {
    // Salva os dados no location.state ao voltar
    navegar("/secretary", {
      state: {
        dadosPessoais,
        endereco,
        informacoesProfissionais,
      },
    });
  };

  const finalizar = () => {
    // MOCKADO - só imprime no console
    const dadosCompletos = {
      dadosPessoais,
      endereco,
      informacoesProfissionais,
    };

    console.log("📋 Dados do professor cadastrado (MOCKADO):", dadosCompletos);
    
    // Vai para a tela de confirmação
    proximaEtapa();
  };

  const concluir = () => {
    // MOCKADO - só mostra mensagem de sucesso
    console.log("✅ Cadastro concluído com sucesso!");
    
    // Volta para a página principal
    navegar("/secretary");
  };

  return {
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
  };
};