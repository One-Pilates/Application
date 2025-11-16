import Input from "../components/Input";
import "./endereco.scss";

export default function EnderecoScreen({
  dados,
  atualizar,
  buscarCep,
}) {
  const manipularCep = (valor) => {
    // Formata o CEP: 00000-000
    let cepFormatado = valor.replace(/\D/g, "");
    if (cepFormatado.length > 5) {
      cepFormatado = cepFormatado.slice(0, 5) + "-" + cepFormatado.slice(5, 8);
    }

    atualizar({ cep: cepFormatado });

    // Busca o CEP quando tiver 8 dígitos
    if (cepFormatado.replace(/\D/g, "").length === 8) {
      buscarCep(cepFormatado);
    }
  };

  return (
    <div className="endereco-screen">
      <h2 className="screen-title">Endereço</h2>

      <div className="address-grid">
        <Input
          label="CEP"
          placeholder="00000-000"
          value={dados.cep}
          onChange={(e) => manipularCep(e.target.value)}
          maxLength={9}
          required
        />

        <Input
          label="Logradouro"
          placeholder="Rua Antônio Candido de Alvarenga"
          value={dados.logradouro}
          onChange={(e) => atualizar({ logradouro: e.target.value })}
          required
        />

        <Input
          label="Número"
          placeholder="539"
          value={dados.numero}
          onChange={(e) => atualizar({ numero: e.target.value })}
          required
        />

        <Input
          label="Bairro"
          placeholder="Perus"
          value={dados.bairro}
          onChange={(e) => atualizar({ bairro: e.target.value })}
          required
        />

        <Input
          label="Cidade"
          placeholder="São Paulo"
          value={dados.cidade}
          onChange={(e) => atualizar({ cidade: e.target.value })}
          required
        />

        <div className="select-wrapper">
          <label className="select-label">
            Estado<span className="select-required">*</span>
          </label>
          <select
            className="select-field"
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
        </div>
      </div>
    </div>
  );
}
