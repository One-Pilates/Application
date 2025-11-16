import { useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";

export const useRegisterTeacherModel = () => {
  const navigate = useNavigate();
  const location = useLocation();

  // Recupera dados se o usuário voltou da tela anterior
  const dadosIniciais = location.state || {};

  const [etapaAtual, setEtapaAtual] = useState(1);

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

  // Etapas do cadastro (4 etapas incluindo CONFIRMAÇÃO)
  const etapas = [
    { label: "Dados Pessoais" },
    { label: "Endereço" },
    { label: "Informações Profissionais" },
    { label: "Confirmação" },
  ];

  // -----------------------------
  // Atualizações dos estados
  // -----------------------------

  const atualizarDadosPessoais = (novos) => {
    setDadosPessoais((prev) => ({ ...prev, ...novos }));
  };

  const atualizarEndereco = (novos) => {
    setEndereco((prev) => ({ ...prev, ...novos }));
  };

  const atualizarInformacoesProfissionais = (novos) => {
    setInformacoesProfissionais((prev) => ({ ...prev, ...novos }));
  };

  // -----------------------------
  // Buscar CEP usando ViaCEP API
  // -----------------------------

  const buscarCep = async (cep) => {
    const cepLimpo = cep.replace(/\D/g, "");

    if (cepLimpo.length === 8) {
      try {
        const res = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
        const data = await res.json();

        if (!data.erro) {
          atualizarEndereco({
            logradouro: data.logradouro || "",
            bairro: data.bairro || "",
            cidade: data.localidade || "",
            estado: data.uf || "",
          });
        }
      } catch (err) {
        console.error("Erro ao buscar CEP:", err);
      }
    }
  };

  // -----------------------------
  // Navegação entre etapas
  // -----------------------------

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

  // Voltar para tela anterior mantendo os dados
  const voltar = () => {
    navigate("/secretary", {
      state: {
        dadosPessoais,
        endereco,
        informacoesProfissionais,
      },
    });
  };

  // Após finalizar as 3 primeiras etapas → vai para CONFIRMAÇÃO
  const finalizar = () => {
    console.log("📋 Dados do professor (pré-visualização):", {
      dadosPessoais,
      endereco,
      informacoesProfissionais,
    });

    setEtapaAtual(4);
  };

  // CONFIRMAR → “salvar” e retornar
  const concluir = () => {
    console.log("✅ Cadastro concluído com sucesso!");
    navigate("/secretary");
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
    finalizar,
    concluir,
    voltar,
  };
};
