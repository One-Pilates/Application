import { AuthContext } from "./AuthContext";
import { useState, useEffect } from "react";
import api from "../provider/api";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const savedUser = localStorage.getItem("user");
    if (savedUser) {
      setUser(JSON.parse(savedUser));
    }
  }, []);

  async function login(email, senha) {
    setIsLoading(true);
    try {
      const response = await api.post("/auth/login", { email, senha });
      const data = response.data;

      localStorage.setItem("token", data.token);
      localStorage.setItem("user", JSON.stringify(data.funcionario));

      setUser(data.funcionario);
      console.log("data:", data);
      console.log("Funcionario:", data.funcionario);
      console.log("Token:", data.token);

      let urlNavigation = "";
      let mensagem = "";
      if (data.funcionario.role === "PROFESSOR") {
        urlNavigation = "/professora/agenda";
        mensagem = `Bem-vindo a sua agenda, ${user.nome}!`;
      } else if (data.funcionario.role === "SECRETARIA") {
        urlNavigation = "/secretaria/dashboard";
        mensagem = `Bem-vindo ao painel da One Pilates, ${user.nome}!`;
      } else {
        urlNavigation = "/";
      }

      Swal.fire({ icon: "success", 
        title: "Login bem-sucedido", 
        showConfirmButton: false,
        text: mensagem,
        timer: 3000
      });

      setTimeout(() => {
        navigate(urlNavigation);
      }, 3000);
      return true;
    } catch (error) {
      const status = error.response?.status;
      const message =
        status === 401
          ? "Email ou senha incorretos."
          : "Ocorreu um erro inesperado. Tente novamente mais tarde.";

      Swal.fire({ icon: "error", title: "Erro ao fazer login", text: message });
      return false;
    } finally {
      setIsLoading(false);
    }
  }

  function logout() {
    Swal.fire({
      title: 'Tem certeza que deseja sair?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sim, sair',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        localStorage.removeItem("token");
        localStorage.removeItem("user");
        setUser(null);
        navigate("/login");
      }
    });
  }

  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}
