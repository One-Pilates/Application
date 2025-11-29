import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import Swal from "sweetalert2";

const API_URL = "http://localhost:8080/api";

const validarCPF = (cpf) => {
  cpf = cpf.replace(/\D/g, "");
  if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false;
  let soma = 0, resto;
  for (let i = 1; i <= 9; i++) soma += parseInt(cpf.substring(i - 1, i)) * (11 - i);
  resto = (soma * 10) % 11;
  if (resto === 10 || resto === 11) resto = 0;
  if (resto !== parseInt(cpf.substring(9, 10))) return false;
  soma = 0;
  for (let i = 1; i <= 10; i++) soma += parseInt(cpf.substring(i - 1, i)) * (12 - i);
  resto = (soma * 10) % 11;
  if (resto === 10 || resto === 11) resto = 0;
  return resto === parseInt(cpf.substring(10, 11));
};

const validarEmail = (email) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

export const useRegisterTeacherModel = () => {
  const navigate = useNavigate();

  const [etapaAtual, setEtapaAtual] = useState(1);
  const [erros, setErros] = useState({});
  const [especialidades, setEspecialidades] = useState([]);
  const [cadastrando, setCadastrando] = useState(false);

  const [dadosPessoais, setDadosPessoais] = useState({
    fotoPerfil: null,
    nomeCompleto: "",
    email: "",
    cpf: "",
    dataNascimento: "",
    telefone: "",
  });

  const [endereco, setEndereco] = useState({
    cep: "",
    logradouro: "",
    numero: "",
    bairro: "",
    cidade: "",
    estado: "",
    uf: "",
  });

  const [informacoesProfissionais, setInformacoesProfissionais] = useState({
    cargo: "",
    especialidades: [],
    notificacaoAtiva: true,
    observacoes: "",
  });

  const etapas = [
    { label: "Dados Pessoais" },
    { label: "Endereço" },
    { label: "Informações" },
    { label: "Confirmação" },
  ];

  useEffect(() => {
    buscarEspecialidades();
  }, []);

  const buscarEspecialidades = async () => {
    try {
      const token = localStorage.getItem("token");
      const response = await axios.get(`${API_URL}/especialidades`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      console.log("✅ Especialidades carregadas:", response.data);
      setEspecialidades(response.data);
    } catch (error) {
      console.error("❌ Erro ao buscar especialidades:", error);
      Swal.fire({
        icon: "error",
        title: "Erro ao carregar especialidades",
        text: "Não foi possível carregar as especialidades. Tente recarregar a página.",
        confirmButtonColor: "#3b82f6",
      });
    }
  };

  const buscarCep = async (cep) => {
    const cepLimpo = cep.replace(/\D/g, "");
    console.log("🔍 Buscando CEP:", cepLimpo);
    
    if (cepLimpo.length === 8) {
      try {
        const res = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
        const data = await res.json();
        console.log("📍 Resposta ViaCEP:", data);
        
        if (!data.erro) {
          const estadosMap = {
            'AC': 'Acre', 'AL': 'Alagoas', 'AP': 'Amapá', 'AM': 'Amazonas',
            'BA': 'Bahia', 'CE': 'Ceará', 'DF': 'Distrito Federal', 
            'ES': 'Espírito Santo', 'GO': 'Goiás', 'MA': 'Maranhão',
            'MT': 'Mato Grosso', 'MS': 'Mato Grosso do Sul', 
            'MG': 'Minas Gerais', 'PA': 'Pará', 'PB': 'Paraíba',
            'PR': 'Paraná', 'PE': 'Pernambuco', 'PI': 'Piauí',
            'RJ': 'Rio de Janeiro', 'RN': 'Rio Grande do Norte',
            'RS': 'Rio Grande do Sul', 'RO': 'Rondônia', 'RR': 'Roraima',
            'SC': 'Santa Catarina', 'SP': 'São Paulo', 
            'SE': 'Sergipe', 'TO': 'Tocantins'
          };
          
          const novoEndereco = {
            logradouro: data.logradouro || "",
            bairro: data.bairro || "",
            cidade: data.localidade || "",
            uf: data.uf || "",
            estado: estadosMap[data.uf] || data.uf || "",
          };
          
          console.log("✅ Preenchendo endereço automático:", novoEndereco);
          
          setEndereco(prev => ({
            ...prev,
            ...novoEndereco
          }));
        } else {
          console.log("❌ CEP não encontrado");
          Swal.fire({
            icon: "warning",
            title: "CEP não encontrado",
            text: "Verifique o CEP digitado e tente novamente.",
            confirmButtonColor: "#3b82f6",
          });
        }
      } catch (err) {
        console.error("❌ Erro ao buscar CEP:", err);
        Swal.fire({
          icon: "error",
          title: "Erro ao buscar CEP",
          text: "Não foi possível consultar o CEP. Tente novamente.",
          confirmButtonColor: "#3b82f6",
        });
      }
    }
  };

  const validarEtapa = () => {
    const novosErros = {};

    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    console.log("🔍 VALIDANDO ETAPA:", etapaAtual);

    if (etapaAtual === 1) {
      console.log("📋 Dados Pessoais:", dadosPessoais);
      
      if (!dadosPessoais.nomeCompleto.trim()) {
        novosErros.nomeCompleto = "Nome obrigatório";
        console.log("❌ Nome vazio");
      }
      if (!dadosPessoais.email.trim()) {
        novosErros.email = "Email obrigatório";
        console.log("❌ Email vazio");
      } else if (!validarEmail(dadosPessoais.email)) {
        novosErros.email = "Email inválido";
        console.log("❌ Email inválido:", dadosPessoais.email);
      }
      if (!dadosPessoais.cpf.trim()) {
        novosErros.cpf = "CPF obrigatório";
        console.log("❌ CPF vazio");
      } else if (!validarCPF(dadosPessoais.cpf)) {
        novosErros.cpf = "CPF inválido";
        console.log("❌ CPF inválido:", dadosPessoais.cpf);
      }
      if (!dadosPessoais.dataNascimento) {
        novosErros.dataNascimento = "Data obrigatória";
        console.log("❌ Data vazia");
      }
      if (!dadosPessoais.telefone.trim()) {
        novosErros.telefone = "Telefone obrigatório";
        console.log("❌ Telefone vazio");
      }
    }

    if (etapaAtual === 2) {
      console.log("📋 Endereço:", endereco);
      
      if (!endereco.cep.trim()) {
        novosErros.cep = "CEP obrigatório";
        console.log("❌ CEP vazio");
      }
      if (!endereco.logradouro.trim()) {
        novosErros.logradouro = "Logradouro obrigatório";
        console.log("❌ Logradouro vazio");
      }
      // Número é OPCIONAL - pode ser "0", "S/N" ou qualquer valor
      if (!endereco.numero || !endereco.numero.trim()) {
        novosErros.numero = "Número obrigatório (ou marque 'Sem número')";
        console.log("❌ Número vazio");
      }
      if (!endereco.bairro.trim()) {
        novosErros.bairro = "Bairro obrigatório";
        console.log("❌ Bairro vazio");
      }
      if (!endereco.cidade.trim()) {
        novosErros.cidade = "Cidade obrigatória";
        console.log("❌ Cidade vazia");
      }
      if (!endereco.estado.trim()) {
        novosErros.estado = "Estado obrigatório";
        console.log("❌ Estado vazio");
      }
      if (!endereco.uf) {
        novosErros.uf = "UF obrigatória";
        console.log("❌ UF vazia");
      }
    }

    if (etapaAtual === 3) {
      console.log("📋 Informações Profissionais:", informacoesProfissionais);
      
      if (!informacoesProfissionais.cargo.trim()) {
        novosErros.cargo = "Cargo obrigatório";
        console.log("❌ Cargo vazio");
      }
      if (!informacoesProfissionais.especialidades?.length) {
        novosErros.especialidades = "Selecione ao menos uma especialidade";
        console.log("❌ Nenhuma especialidade selecionada");
      }
    }

    console.log("📊 Erros encontrados:", novosErros);
    console.log("✅ Validação passou?", Object.keys(novosErros).length === 0);
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

    setErros(novosErros);
    return Object.keys(novosErros).length === 0;
  };

  const proximaEtapa = () => {
    console.log("➡️ Tentando avançar da etapa", etapaAtual);
    
    if (validarEtapa()) {
      console.log("✅ Validação OK, avançando...");
      if (etapaAtual === 3) {
        console.log("📄 Indo para confirmação (etapa 4)");
        setEtapaAtual(4);
      } else {
        console.log(`➡️ Avançando para etapa ${etapaAtual + 1}`);
        setEtapaAtual(etapaAtual + 1);
      }
    } else {
      console.log("❌ Validação falhou, mostrando erros");
      Swal.fire({
        icon: "warning",
        title: "Campos obrigatórios",
        text: "Por favor, preencha todos os campos obrigatórios corretamente.",
        confirmButtonColor: "#3b82f6",
      });
    }
  };

  const etapaAnterior = () => {
    if (etapaAtual > 1) {
      console.log("⬅️ Voltando para etapa", etapaAtual - 1);
      setEtapaAtual(etapaAtual - 1);
    }
  };

  const irParaEtapa = (numeroEtapa) => {
    if (numeroEtapa <= etapaAtual && numeroEtapa >= 1) {
      console.log("🔄 Indo para etapa", numeroEtapa);
      setEtapaAtual(numeroEtapa);
    }
  };

  const voltarEtapa = () => {
    console.log("⬅️ Voltando etapa (atual:", etapaAtual, ")");
    if (etapaAtual === 4) {
      setEtapaAtual(3);
    } else if (etapaAtual > 1) {
      setEtapaAtual(etapaAtual - 1);
    }
  };

  const cadastrarProfessor = async () => {
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    console.log("🚀 INICIANDO CADASTRO DE PROFESSOR");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    setCadastrando(true);
    
    try {
      const token = localStorage.getItem("token");
      console.log("🔑 Token:", token ? "✅ Presente" : "❌ AUSENTE");
      
      if (!token) {
        throw new Error("Token de autenticação não encontrado. Faça login novamente.");
      }
      
      // Gerar senha aleatória forte
      const senhaGerada = Math.random().toString(36).slice(-8) + Math.random().toString(36).slice(-4) + "A1!";
      console.log("🔐 Senha gerada:", senhaGerada);
      
      const payload = {
        nome: dadosPessoais.nomeCompleto.trim(),
        email: dadosPessoais.email.trim().toLowerCase(),
        cpf: dadosPessoais.cpf.replace(/\D/g, ""),
        idade: dadosPessoais.dataNascimento,
        status: true,
        foto: null,
        observacoes: informacoesProfissionais.observacoes?.trim() || "",
        notificacaoAtiva: informacoesProfissionais.notificacaoAtiva,
        senha: senhaGerada,
        cargo: informacoesProfissionais.cargo.trim(),
        role: "PROFESSOR",
        endereco: {
          rua: endereco.logradouro.trim(),
          numero: endereco.numero === "S/N" ? "0" : endereco.numero.trim(),
          bairro: endereco.bairro.trim(),
          cidade: endereco.cidade.trim(),
          estado: endereco.estado.trim(),
          cep: endereco.cep.replace(/\D/g, ""),
          uf: endereco.uf
        },
        telefone: dadosPessoais.telefone.replace(/\D/g, ""),
        especialidadeIds: informacoesProfissionais.especialidades
      };
      
      console.log("📦 PAYLOAD:", JSON.stringify(payload, null, 2));

      const response = await axios.post(`${API_URL}/professores`, payload, {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("✅ SUCESSO! Professor cadastrado:", response.data);

      // Se tiver foto, fazer upload separado
      if (dadosPessoais.fotoPerfil && response.data.id) {
        console.log("📸 Iniciando upload de foto...");
        try {
          await uploadFoto(response.data.id);
          console.log("✅ Foto enviada com sucesso!");
        } catch (fotoError) {
          console.error("⚠️ Erro ao enviar foto (não crítico):", fotoError);
        }
      }

      await Swal.fire({
        icon: "success",
        title: "Professor cadastrado com sucesso!",
        html: `
          <div style="text-align: left; padding: 1rem;">
            <p><strong>Nome:</strong> ${dadosPessoais.nomeCompleto}</p>
            <p><strong>Email:</strong> ${dadosPessoais.email}</p>
            <p style="margin-top: 1rem; padding: 1rem; background: #fef3c7; border-radius: 8px;">
              <strong>🔐 Senha gerada:</strong><br/>
              <code style="font-size: 1.2rem; color: #92400e;">${senhaGerada}</code><br/>
              <small style="color: #92400e;">Guarde esta senha para o primeiro acesso</small>
            </p>
          </div>
        `,
        confirmButtonText: "OK, entendi!",
        confirmButtonColor: "#22c55e",
        width: "600px",
      });

      navigate("/secretaria/professor");
      
    } catch (error) {
      console.error("❌ ERRO NO CADASTRO:", error);
      
      let mensagemErro = "Erro ao cadastrar professor";
      let detalhes = "";
      
      if (error.response?.status === 409) {
        mensagemErro = "CPF ou Email já cadastrado";
        detalhes = "Este CPF ou email já existe no sistema. Verifique os dados e tente novamente.";
      } else if (error.response?.status === 400) {
        mensagemErro = "Dados inválidos";
        detalhes = error.response?.data || "Verifique todos os campos e tente novamente.";
      } else if (error.response?.status === 401) {
        mensagemErro = "Sessão expirada";
        detalhes = "Sua sessão expirou. Faça login novamente.";
      } else if (error.message) {
        mensagemErro = "Erro ao cadastrar";
        detalhes = error.message;
      }
      
      await Swal.fire({
        icon: "error",
        title: mensagemErro,
        text: detalhes,
        confirmButtonColor: "#ef4444",
      });
    } finally {
      setCadastrando(false);
      console.log("🏁 Processo de cadastro finalizado");
    }
  };

  const uploadFoto = async (professorId) => {
    if (!dadosPessoais.fotoPerfil) {
      console.log("⚠️ Nenhuma foto para enviar");
      return;
    }

    try {
      const token = localStorage.getItem("token");
      console.log("📤 Enviando foto do professor ID:", professorId);
      
      let arquivo;
      if (typeof dadosPessoais.fotoPerfil === 'string' && dadosPessoais.fotoPerfil.startsWith('data:')) {
        console.log("🔄 Convertendo base64 para File...");
        const res = await fetch(dadosPessoais.fotoPerfil);
        const blob = await res.blob();
        arquivo = new File([blob], "foto.jpg", { type: "image/jpeg" });
      } else {
        arquivo = dadosPessoais.fotoPerfil;
      }

      console.log("📄 Arquivo:", arquivo.name, "-", arquivo.size, "bytes");

      const formData = new FormData();
      formData.append("file", arquivo);

      const response = await axios.post(
        `${API_URL}/professores/${professorId}/uploadFoto`, 
        formData, 
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${token}`,
          },
        }
      );

      console.log("✅ Foto enviada com sucesso:", response.data);
      return response.data;
    } catch (error) {
      console.error("❌ Erro ao enviar foto:", error);
      throw error;
    }
  };

  return {
    etapaAtual,
    etapas,
    erros,
    dadosPessoais,
    endereco,
    informacoesProfissionais,
    especialidades,
    cadastrando,
    
    setDadosPessoais,
    setEndereco,
    setInformacoesProfissionais,
    buscarCep,
    proximaEtapa,
    etapaAnterior,
    voltarEtapa,
    irParaEtapa,
    cadastrarProfessor,
  };
};