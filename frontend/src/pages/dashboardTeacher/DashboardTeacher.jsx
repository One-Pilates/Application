import React, { useState } from "react";
import { FaBars } from "react-icons/fa";
import { Outlet } from "react-router-dom";
import Account from "../components/Account";
import NavbarTeacher from "../components/Navbar";

function DashboardTeacher() {
  const [navAberta, setNavAberta] = useState(true);

  return (
    <div className="flex h-screen bg-gray-100">
      <NavbarTeacher navAberta={navAberta} userType="teacher" />
      <div className="flex flex-col flex-1">
        <div className="flex justify-between items-center bg-white px-6 py-3 border-b shadow-sm">
          <div className="flex items-center gap-4">
            <button
              onClick={() => setNavAberta(!navAberta)}
              className="p-2 rounded hover:bg-gray-100 transition"
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

export default DashboardTeacher;
