import Input from "../components/Input";
import "./endereco.scss";

export default function EnderecoScreen({
  dados,
  atualizar,
  buscarCep,
  erros = {},
}) {
  const manipularCep = (valor) => {
    atualizar({ cep: valor });

    // Busca o CEP quando tiver 8 dígitos
    if (valor.replace(/\D/g, "").length === 8) {
      buscarCep(valor);
    }
  };

  return (
    <div className="endereco-screen">
      <div className="address-grid">
        <Input
          label="CEP"
          placeholder="00000-000"
          value={dados.cep}
          onChange={(e) => manipularCep(e.target.value)}
          maxLength={9}
          mask="cep"
          required
          erro={erros.cep}
        />

        <Input
          label="Logradouro"
          placeholder="Avenida Paulista"
          value={dados.logradouro}
          onChange={(e) => atualizar({ logradouro: e.target.value })}
          required
          erro={erros.logradouro}
        />

        <Input
          label="Número"
          placeholder="539"
          value={dados.numero}
          onChange={(e) => atualizar({ numero: e.target.value })}
          required
          erro={erros.numero}
        />

        <Input
          label="Bairro"
          placeholder="São Paulo"
          value={dados.bairro}
          onChange={(e) => atualizar({ bairro: e.target.value })}
          required
          erro={erros.bairro}
        />

        <Input
          label="Cidade"
          placeholder="São Paulo"
          value={dados.cidade}
          onChange={(e) => atualizar({ cidade: e.target.value })}
          required
          erro={erros.cidade}
        />

        <div className="select-wrapper">
          <label className="select-label">
            Estado<span className="select-required">*</span>
          </label>
          <select
            className={`select-field ${erros.estado ? "select-error" : ""}`}
            value={dados.estado}
            onChange={(e) => atualizar({ estado: e.target.value })}
            required
          >
            <option value="">Selecione</option>
            <option value="AC">AC</option>
            <option value="AL">AL</option>
            <option value="AP">AP</option>
            <option value="AM">AM</option>
            <option value="BA">BA</option>
            <option value="CE">CE</option>
            <option value="DF">DF</option>
            <option value="ES">ES</option>
            <option value="GO">GO</option>
            <option value="MA">MA</option>
            <option value="MT">MT</option>
            <option value="MS">MS</option>
            <option value="MG">MG</option>
            <option value="PA">PA</option>
            <option value="PB">PB</option>
            <option value="PR">PR</option>
            <option value="PE">PE</option>
            <option value="PI">PI</option>
            <option value="RJ">RJ</option>
            <option value="RN">RN</option>
            <option value="RS">RS</option>
            <option value="RO">RO</option>
            <option value="RR">RR</option>
            <option value="SC">SC</option>
            <option value="SP">SP</option>
            <option value="SE">SE</option>
            <option value="TO">TO</option>
          </select>
          {erros.estado && <span className="select-error-message">{erros.estado}</span>}
        </div>
      </div>
    </div>
  );
}