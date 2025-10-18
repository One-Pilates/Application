import { AuthContext } from "./AuthContext";
import { useState } from "react";
import api from "../provider/api";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";


export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    const userSaved = localStorage.getItem("user");
    return userSaved ? JSON.parse(userSaved) : null;
  });
    const navigate = useNavigate();

  async function login(email, password) {
    try {
      const response = await api.post("/funcionarios/login", {
        email,
        password,
      });

      const data = response.data;
      localStorage.setItem("token", data.token);
      localStorage.setItem("user", JSON.stringify(data.user));

      setUser(data.user);
      console.log("Login bem-sucedido:", data.user);
      console.log("Token:", data.token);

      Swal.fire({ icon: "success", title: "Login bem-sucedido" });
      navigate("/dashboardTeacher");
      return true;
    } catch (error) {
      const status = error.response?.status;
      const message =
        status === 401
          ? "Email ou senha incorretos."
          : "Ocorreu um erro inesperado. Tente novamente mais tarde.";

      Swal.fire({ icon: "error", title: "Erro ao fazer login", text: message });
      return false;
    }
  }

  function logout() {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    setUser(null);
    navigate("/login");
  }

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

