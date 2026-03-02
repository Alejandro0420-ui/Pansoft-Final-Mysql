const API_URL = "http://localhost:5000/api";

export const suppliersAPI = {
  getAll: () =>
    fetch(`${API_URL}/suppliers`, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    })
      .then((r) => r.json())
      .then((data) => ({ data: Array.isArray(data) ? data : [] }))
      .catch((err) => {
        console.error("Error cargando proveedores:", err);
        return { data: [] };
      }),

  create: (data) =>
    fetch(`${API_URL}/suppliers`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    }).then((r) => r.json()),

  update: (id, data) =>
    fetch(`${API_URL}/suppliers/${id}`, {
      method: "PUT",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
        ...(!(data instanceof FormData) && {
          "Content-Type": "application/json",
        }),
      },
      body: data instanceof FormData ? data : JSON.stringify(data),
    }).then((r) => r.json()),

  toggleStatus: (id) =>
    fetch(`${API_URL}/suppliers/${id}/toggle-status`, {
      method: "PATCH",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
        "Content-Type": "application/json",
      },
    }).then((r) => r.json()),

  delete: (id) =>
    fetch(`${API_URL}/suppliers/${id}`, {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    }).then((r) => r.json()),
};
