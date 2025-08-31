let currentStep = 1;
let userData = {};
let url = "http://localhost:8080/users";

function updateStepIndicator() {
  document.getElementById("step-1").className = "step inactive";
  document.getElementById("step-2").className = "step inactive";
  document.getElementById("line-1").className = "step-line";

  if (currentStep === 1) {
    document.getElementById("step-1").className = "step active";
  } else if (currentStep === 2) {
    document.getElementById("step-1").className = "step completed";
    document.getElementById("step-2").className = "step active";
    document.getElementById("line-1").className = "step-line completed";
  }
}

function showStep(step) {
  document.getElementById("content-1").classList.remove("active");
  document.getElementById("content-2").classList.remove("active");

  document.getElementById("content-" + step).classList.add("active");

  updateStepIndicator();
}

function validateStep1() {
  const nome = document.getElementById("nome").value.trim();
  const dataNasc = document.getElementById("dataNasc").value.trim();
  const email = document.getElementById("email").value.trim();

  if (!nome || !dataNasc || !email) {
    swal("Erro!", "Preencha todos os campos", "error");
    return false;
  }

  return true;
}

function validateStep2() {
  const senha = document.getElementById("senha").value;
  const confirmarSenha = document.getElementById("confirmarSenha").value;

  if (!senha || !confirmarSenha) {
    swal("Erro!", "Preencha todos os campos", "error");
    return false;
  }

  return true;
}

function nextStep() {
  if (validateStep1()) {
    userData.nome = document.getElementById("nome").value.trim();
    userData.dataNasc = document.getElementById("dataNasc").value;
    userData.email = document.getElementById("email").value.trim();

    currentStep = 2;
    showStep(currentStep);
  }
}

function prevStep() {
  currentStep = 1;
  showStep(currentStep);
}

function completeSignup() {
  if (validateStep2()) {
    userData.senha = document.getElementById("senha").value;

    console.log("User data:", userData);

    fetch(url, {
      method: "POST",
      headers: {
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        email: userData.email,
        senha: userData.senha,
        nome: userData.nome,
        dataNasc: userData.dataNasc,
      }),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("Erro ao cadastrar usuário");
        }
      })
      .then((data) => {
        console.log(data);
        swal("Sucesso!", "Conta criada com sucesso!", "success").then(() => {});
      })
      .catch((error) => {
        console.error(error);
      });
    resetForm();
  }
}

function resetForm() {
  currentStep = 1;
  userData = {};
  document.getElementById("form-step-1").reset();
  document.getElementById("form-step-2").reset();
  showStep(currentStep);
}


// Initialize
document.addEventListener("DOMContentLoaded", function () {
  showStep(currentStep);
});
