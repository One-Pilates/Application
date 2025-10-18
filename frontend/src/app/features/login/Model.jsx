// import React from "react";
// import api from "../../provider/api";
// import Swal from "sweetalert2";
// import { validacaoEmail } from "../../shared/utils/funcoesUtils";

// export const useLoginModel = () => {
//   const [email, setEmail] = React.useState("");
//   const [password, setPassword] = React.useState("");

//   const handleLogin = async (navigate) => {
//     if (!validacaoEmail(email)) {
//       Swal.fire({
//         icon: "error",
//         title: "Email inválido",
//         text: "Por favor, insira um email válido.",
//       });
//       return;
//     }

//     if (!password) {
//       Swal.fire({
//         icon: "error",
//         title: "Senha inválida",
//         text: "Por favor, insira uma senha válida.",
//       });
//       return;
//     }

//     try {
//       const response = await api.post("/funcionarios/login", { email, password });

//       Swal.fire({
//         icon: "success",
//         title: "Login bem-sucedido",
//         text: "Você foi logado com sucesso.",
//       });

//       navigate("/dashboardTeacher");
//       console.log("Login bem-sucedido:", response.data);

//     } catch (error) {
//       const status = error.response?.status;
//       const message =
//         status === 401
//           ? "Email ou senha incorretos."
//           : "Ocorreu um erro inesperado. Tente novamente mais tarde.";

//       Swal.fire({
//         icon: "error",
//         title: "Erro ao fazer login",
//         text: message,
//       });

//       console.error("Erro ao fazer login:", error);
//     }
//   };

//   return { email, setEmail, password, setPassword, handleLogin };
// };
