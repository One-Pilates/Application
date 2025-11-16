import { FaBars } from "react-icons/fa";
import Account from "./Account";

export default function Navbar({ navAberta, setNavAberta }) {
  return (
    <div className="flex justify-between items-center px-6 py-3 shadow-sm">
      <button onClick={() => setNavAberta(!navAberta)} className="p-2 rounded-lg hover:bg-gray-100 active:bg-gray-200 transition-colors">
        <FaBars size={20} className="text-gray-700" />
      </button>
      <Account />
    </div>
  );
}
