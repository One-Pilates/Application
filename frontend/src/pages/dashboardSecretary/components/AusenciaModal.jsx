import React, { useState } from 'react';
import { IoClose } from 'react-icons/io5';
import "../styles/AusenciaModal.scss";

const AbsenceModal = ({ isOpen, onClose }) => {
  const [formData, setFormData] = useState({
    startDate: '',
    startTime: '',
    endDate: '',
    endTime: '',
    message: ''
  });

  const handleClose = () => {
    onClose();
  };

  const handleSave = () => {
    console.log('Dados salvos:', formData);
    // Aqui você adiciona a lógica de salvar
    handleClose();
  };

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  if (!isOpen) return null;

  return (
    <>
      <div className="fixed inset-0 z-50 flex items-center justify-center">
        {/* Overlay */}
        <div 
          className="absolute inset-0 bg-black bg-opacity-50"
          onClick={handleClose}
        />
        
        {/* Modal */}
        <div className="relative bg-white rounded-xl shadow-2xl w-full max-w-lg mx-4 modal-fade-in">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-5 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-orange-500">Definir Ausência</h2>
          <button
            onClick={handleClose}
            className="text-red-500 hover:text-red-600 transition-colors"
          >
            <IoClose size={24} />
          </button>
        </div>

        {/* Body */}
        <div className="px-6 py-6">
          <div className="grid grid-cols-2 gap-4 mb-4">
            {/* Data de Início */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">
                Data de Início
              </label>
              <input
                type="text"
                name="startDate"
                value={formData.startDate}
                onChange={handleChange}
                placeholder="xx/xx/xxxx"
                className="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-1 focus:ring-orange-400 focus:border-orange-400 outline-none transition-all"
              />
            </div>

            {/* Horário de Início */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">
                Horário de Início
              </label>
              <input
                type="text"
                name="startTime"
                value={formData.startTime}
                onChange={handleChange}
                placeholder="xx/xx/xxxx"
                className="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-1 focus:ring-orange-400 focus:border-orange-400 outline-none transition-all"
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4 mb-4">
            {/* Data Final */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">
                Data Final
              </label>
              <input
                type="text"
                name="endDate"
                value={formData.endDate}
                onChange={handleChange}
                placeholder="xx/xx/xxxx"
                className="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-1 focus:ring-orange-400 focus:border-orange-400 outline-none transition-all"
              />
            </div>

            {/* Horário de Término */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">
                Horário de término
              </label>
              <input
                type="text"
                name="endTime"
                value={formData.endTime}
                onChange={handleChange}
                placeholder="xx/xx/xxxx"
                className="w-full px-3 py-2 text-sm border border-gray-300 rounded-md focus:ring-1 focus:ring-orange-400 focus:border-orange-400 outline-none transition-all"
              />
            </div>
          </div>

          {/* Mensagem */}
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1.5">
              Mensagem <span className="text-orange-500">*</span>
            </label>
            <textarea
              name="message"
              value={formData.message}
              onChange={handleChange}
              rows="3"
              className="w-full px-3 py-2 text-sm border border-orange-300 rounded-md focus:ring-1 focus:ring-orange-400 focus:border-orange-400 outline-none transition-all resize-none"
              placeholder=""
            />
          </div>
        </div>

        {/* Footer */}
        <div className="px-6 pb-6 flex justify-end">
          <button
            onClick={handleSave}
            className="px-8 py-2 bg-blue-600 text-white text-sm font-medium rounded-md hover:bg-blue-700 transition-colors shadow-sm hover:shadow"
          >
            Salvar
          </button>
        </div>
      </div>
      </div>
    </>
  );
};

export default AbsenceModal;