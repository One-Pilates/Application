import React, { useState } from "react";
import { Outlet } from "react-router-dom";
import { SidebarSecretary } from "../../components/Sidebar";
import Navbar from "../../components/Navbar";

export default function Secretary() {
  const [navAberta, setNavAberta] = useState(true);

  return (
    <div className="flex h-screen bg-gray-100">
      <SidebarSecretary navAberta={navAberta} userType="secretary" />

      <div className="flex flex-col flex-1">
        <Navbar navAberta={navAberta} setNavAberta={setNavAberta} />
        <main className="flex-1 bg-gray-100 p-6 overflow-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
