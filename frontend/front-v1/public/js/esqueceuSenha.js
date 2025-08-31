let url = "http://localhost:8080/users";

function atualizarSenha() {
  const idMock = "c2f2"
  const senha = document.getElementById("senha").value;
  const confirmarSenha = document.getElementById("confirmarSenha").value

  if (senha !== confirmarSenha) {
   swal("Senhas não compativeis", "error");
  }

  fetch(`${url}/${idMock}`, { 
    method: "PATCH",
    headers: {
      "Content-type": "application/json",
    },
    body: JSON.stringify({
      senha: senha,
    }),
  })
    .then((response) => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Erro ao atualizar senha");
      }
    })
    .then((data) => {
      console.log("Senha atualizada:", data);
      swal("Sucesso!", "Senha atualizada com sucesso!", "success");
    })
    .catch((error) => {
      console.error("Erro:", error);
    });
}
