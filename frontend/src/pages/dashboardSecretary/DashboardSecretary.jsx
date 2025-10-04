import React, { useState } from "react";
import { FaBars } from "react-icons/fa";
import { Outlet } from "react-router-dom";
import Account from "../components/Account";
import { NavbarSecretary } from "../components/Navbar";

function DashboardSecretary() {
  const [navAberta, setNavAberta] = useState(true);

  return (
    <div className="flex h-screen bg-gray-100">
      <NavbarSecretary navAberta={navAberta} />
      <div className="flex flex-col flex-1">
        <div className="flex justify-between items-center bg-gray-200 px-6 py-3 border-b">
          <div className="flex items-center gap-4">
            <button
              onClick={() => setNavAberta(!navAberta)}
              className="p-2 rounded hover:bg-gray-300 transition"
            >
              <FaBars size={20} />
            </button>
          </div>
          <Account />
        </div>
        <div className="flex-1 bg-gray-100 p-6 overflow-auto">
          <Outlet />
        </div>
      </div>
    </div>
  );
}

export default DashboardSecretary;
