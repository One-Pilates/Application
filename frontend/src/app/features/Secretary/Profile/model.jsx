import {useEffect, useState } from "react";
import { useParams, useLocation } from "react-router-dom";
import api from "../../../../provider/api";

export const useViewProfileModel = () => {
  const { id } = useParams();
  const location = useLocation();
  const [dadosUser, setDadosUser] = useState(null);
  const [loading, setLoading] = useState(true);

  const tipo = location.pathname.includes('/professor') ? 'professor' : 'aluno';

  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        
        const endpoint = tipo === 'professor' 
          ? `api/professores/${id}` 
          : `api/alunos/${id}`;
        
        const response = await api.get(endpoint);
        const data = response.data;
        console.log(`Dados do ${tipo} recebidos:`, data);
        setDadosUser(data);
        
      } catch (error) {
        console.error(`Erro ao buscar ${tipo}:`, error);
      } finally {
        setLoading(false);
      }
    };
    
    if (id) fetchUser();
  }, [id, tipo]);

  return { 
    dadosUser, 
    tipo, 
    loading 
  };
};
