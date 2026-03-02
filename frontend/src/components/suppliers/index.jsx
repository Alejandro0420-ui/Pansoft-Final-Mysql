import { useState, useEffect } from "react";
import { suppliersAPI } from "./api";
import { INITIAL_FORM_DATA } from "./constants";
import { SuppliersHeader } from "./SuppliersHeader";
import { SuppliersStats } from "./SuppliersStats";
import { SuppliersSearchBar } from "./SuppliersSearchBar";
import { SuppliersTable } from "./SuppliersTable";
import { SupplierModal } from "./SupplierModal";

export function Suppliers() {
  const [suppliers, setSuppliers] = useState([]);
  const [searchTerm, setSearchTerm] = useState("");
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [showInactive, setShowInactive] = useState(true);
  const [formData, setFormData] = useState(INITIAL_FORM_DATA);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  useEffect(() => {
    loadSuppliers();
  }, []);

  const loadSuppliers = async () => {
    try {
      setLoading(true);
      const response = await suppliersAPI.getAll();
      setSuppliers(response.data || []);
    } catch (error) {
      console.error("Error cargando proveedores:", error);
      setError("Error al cargar proveedores");
    } finally {
      setLoading(false);
    }
  };

  const openModal = (supplier = null) => {
    if (supplier) {
      setEditingId(supplier.id);
      setFormData(supplier);
    } else {
      setEditingId(null);
      setFormData(INITIAL_FORM_DATA);
    }
    setError("");
    setSuccess("");
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
    setEditingId(null);
    setError("");
    setSuccess("");
  };

  const validateForm = () => {
    if (!formData.company_name.trim()) {
      setError("Nombre de empresa es requerido");
      return false;
    }
    if (!formData.contact_person?.trim()) {
      setError("Persona de contacto es requerida");
      return false;
    }
    if (!formData.email?.trim()) {
      setError("Correo electrónico es requerido");
      return false;
    }
    if (!formData.phone?.trim()) {
      setError("Teléfono es requerido");
      return false;
    }
    return true;
  };

  const handleSaveSupplier = async () => {
    if (!validateForm()) {
      return;
    }

    try {
      if (editingId) {
        await suppliersAPI.update(editingId, formData);
        setSuccess("Proveedor actualizado exitosamente");
      } else {
        await suppliersAPI.create(formData);
        setSuccess("Proveedor agregado exitosamente");
      }
      setTimeout(() => {
        closeModal();
        loadSuppliers();
      }, 1000);
    } catch (error) {
      console.error("Error guardando proveedor:", error);
      setError("Error al guardar proveedor");
    }
  };

  const handleToggleStatus = async (id, supplier) => {
    const action = supplier.is_active ? "deshabilitar" : "habilitar";
    if (
      !window.confirm(
        `¿Estás seguro de que quieres ${action} a ${supplier.company_name}?`,
      )
    ) {
      return;
    }

    try {
      await suppliersAPI.toggleStatus(id);
      const mensaje = supplier.is_active
        ? `${supplier.company_name} fue DESHABILITADO`
        : `${supplier.company_name} fue HABILITADO`;
      alert(mensaje);
      setSuccess(mensaje);
      setTimeout(() => {
        loadSuppliers();
        setSuccess("");
      }, 500);
    } catch (error) {
      console.error("Error:", error);
      const errorMsg =
        error?.error ||
        error?.message ||
        "Error al cambiar estado del proveedor";
      alert(`❌ ${errorMsg}`);
      setError(errorMsg);
    }
  };

  const filteredSuppliers = suppliers.filter((supplier) => {
    const matchesSearch =
      (supplier.company_name || "")
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      (supplier.contact_person || "")
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      (supplier.category || "")
        .toLowerCase()
        .includes(searchTerm.toLowerCase());

    const isActive = supplier.is_active !== 0;
    const matchesStatus = showInactive ? true : isActive;

    return matchesSearch && matchesStatus;
  });

  const totalSuppliers = suppliers.length;
  const totalActive = suppliers.filter(
    (s) => s.is_active === 1 || s.is_active === true,
  ).length;
  const totalInactive = suppliers.filter(
    (s) => s.is_active === 0 || s.is_active === false,
  ).length;

  return (
    <div className="container-fluid py-4">
      {/* Alerts */}
      {error && (
        <div
          className="alert alert-danger alert-dismissible fade show mb-4"
          role="alert"
        >
          {error}
          <button
            type="button"
            className="btn-close"
            onClick={() => setError("")}
          ></button>
        </div>
      )}
      {success && (
        <div
          className="alert alert-success alert-dismissible fade show mb-4"
          role="alert"
        >
          {success}
          <button
            type="button"
            className="btn-close"
            onClick={() => setSuccess("")}
          ></button>
        </div>
      )}

      <SuppliersHeader onOpenModal={() => openModal()} />
      <SuppliersStats
        totalSuppliers={totalSuppliers}
        totalActive={totalActive}
        totalInactive={totalInactive}
      />
      <SuppliersSearchBar
        searchTerm={searchTerm}
        onSearchChange={setSearchTerm}
        showInactive={showInactive}
        onToggleFilter={() => setShowInactive(!showInactive)}
      />
      <SuppliersTable
        suppliers={filteredSuppliers}
        loading={loading}
        onEdit={openModal}
        onToggleStatus={handleToggleStatus}
      />

      <SupplierModal
        isOpen={showModal}
        isEditing={!!editingId}
        formData={formData}
        error={error}
        success={success}
        onFormChange={setFormData}
        onSave={handleSaveSupplier}
        onClose={closeModal}
        onErrorDismiss={() => setError("")}
        onSuccessDismiss={() => setSuccess("")}
      />
    </div>
  );
}
