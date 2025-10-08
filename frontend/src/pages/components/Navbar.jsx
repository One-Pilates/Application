import React from "react";
import { FaBars } from "react-icons/fa";
import Account from "./Account";

export default function Navbar({ navAberta, setNavAberta }) {
  return (
    <div className="flex justify-between items-center bg-white px-6 border-b shadow-sm">
      <button
        onClick={() => setNavAberta(!navAberta)}
        className="p-2 rounded hover:bg-gray-100 transition"
      >
        <FaBars size={20} />
      </button>
      <Account />
    </div>
  );
}
