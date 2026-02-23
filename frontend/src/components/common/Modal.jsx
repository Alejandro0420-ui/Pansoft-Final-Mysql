import React, { useEffect } from "react";

export const Modal = ({
  isOpen,
  onClose,
  title,
  children,
  footer,
  size = "lg",
  centered = true,
  backdrop = true,
}) => {
  useEffect(() => {
    if (isOpen) {
      document.documentElement.style.overflow = "hidden";
      document.documentElement.classList.add("modal-open");
      document.body.style.overflow = "hidden";
      document.body.classList.add("modal-open");
    } else {
      document.documentElement.style.overflow = "auto";
      document.documentElement.classList.remove("modal-open");
      document.body.style.overflow = "auto";
      document.body.classList.remove("modal-open");
    }
    return () => {
      document.documentElement.style.overflow = "auto";
      document.documentElement.classList.remove("modal-open");
      document.body.style.overflow = "auto";
      document.body.classList.remove("modal-open");
    };
  }, [isOpen]);

  if (!isOpen) return null;

  const handleBackdropClick = (e) => {
    if (backdrop && e.target === e.currentTarget) {
      onClose();
    }
  };

  const sizeClasses = {
    sm: "modal-sm",
    lg: "modal-lg",
    xl: "modal-xl",
  };

  return (
    <div
      className="modal fade show"
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        position: "fixed",
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        backgroundColor: "rgba(0,0,0,0.7)",
        zIndex: 1050,
        margin: 0,
        padding: 0,
        overflow: "auto",
      }}
      tabIndex="-1"
      role="dialog"
      aria-labelledby="modalTitle"
      aria-hidden="true"
      onClick={handleBackdropClick}
    >
      <div
        className={`modal-dialog ${sizeClasses[size] || "modal-lg"}`}
        role="document"
        style={{
          position: "relative",
          zIndex: 1051,
          margin: "auto",
        }}
      >
        <div className="modal-content">
          {title && (
            <div className="modal-header">
              <h5 className="modal-title" id="modalTitle">
                {title}
              </h5>
              <button
                type="button"
                className="btn-close"
                onClick={onClose}
                aria-label="Close"
                style={{
                  filter: "brightness(0) invert(1)",
                  opacity: 1,
                }}
              ></button>
            </div>
          )}
          <div className="modal-body">{children}</div>
          {footer && <div className="modal-footer">{footer}</div>}
        </div>
      </div>
    </div>
  );
};

export default Modal;
