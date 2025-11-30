import { FaBars } from "react-icons/fa";
import Account from "./Account";

export default function Navbar({ navAberta, setNavAberta }) {
  return (
    <div 
      className="flex justify-between items-center px-6 py-3 shadow-sm"
      style={{
        backgroundColor: 'var(--bg-claro)'
      }}
    >
      <button 
        onClick={() => setNavAberta(!navAberta)} 
        className="p-2 rounded-lg transition-colors"
        style={{ color: 'var(--text-escuro)' }}
      >
        <FaBars size={30} />
      </button>
      <Account />
    </div>
  );
}


