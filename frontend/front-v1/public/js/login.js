const url = "http://localhost:8080/users";

function entrar() {
  const email = document.getElementById("email_input").value;
  const senha = document.getElementById("senha_input").value;

  fetch(`${url}?email=${email}&senha=${senha}`)
    .then((res) => res.json())
    .then((user) => {
      if (user) {
        swal("Sucesso!", "Logado com sucesso!", "success");
        console.log("Login OK", user);
      } else {
        swal("Erro!", "Usuário ou senha inválidos!", "error");
        console.log("Usuário ou senha inválidos");
      }
    })
    .catch(error => {
      console.error(error);
      swal("Erro!", "Ocorreu um problema na requisição", "error");
    });
}

//   fetch(url, {
//   method: "POST",
//   headers: { "Content-Type": "application/json" },
//   body: JSON.stringify({ email, password })
// })
//   .then(res => res.json())
//   .then(user => {
//     console.log("Simulando login OK:", user);
//   })
//   .catch(err => console.error(err));

