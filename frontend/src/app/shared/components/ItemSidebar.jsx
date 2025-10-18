import React from "react";

export default function ItemSidebar({ Icon, texto, navAberta, ativo, onClick }) {
  return (
    <div
      onClick={onClick}
      className={`flex items-center gap-4 px-4 py-3 cursor-pointer transition rounded-full mx-2 my-2 ${
        ativo ? "bg-white text-orange-500 font-bold" : "hover:bg-orange-600"
      }`}
    >
      <Icon size={22} />
      {navAberta && <span>{texto}</span>}
    </div>
  );
}

