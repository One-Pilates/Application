import React, { useState } from "react";
import { Outlet } from "react-router-dom";
import SidebarTeacher from "../../components/Sidebar";
import Navbar from "../../components/Navbar";

export default function Teacher() {
  const [navAberta, setNavAberta] = useState(true);

  return (
    <div className="flex h-screen bg-gray-100">
      <SidebarTeacher navAberta={navAberta} userType="teacher" />

      <div className="flex flex-col flex-1">
        <Navbar navAberta={navAberta} setNavAberta={setNavAberta} />
        <main className="flex-1 bg-gray-100 p-6 overflow-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
}
