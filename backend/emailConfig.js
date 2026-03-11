import nodemailer from "nodemailer";

// Configuración de Mailtrap para pruebas
// Consigue tus credenciales en: https://mailtrap.io/
// Settings -> SMTP Settings

export const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST || "smtp.mailtrap.io",
  port: process.env.EMAIL_PORT || 587,
  secure: false, // true for 465, false for other ports
  auth: {
    user: process.env.EMAIL_USER || "tu_usuario_mailtrap",
    pass: process.env.EMAIL_PASS || "tu_password_mailtrap",
  },
});

// Verificar conexión
transporter
  .verify()
  .then(() => console.log("✓ Conexión de email configurada correctamente"))
  .catch((err) =>
    console.log("⚠ Error en configuración de email:", err.message),
  );

// Template de email para recuperación de contraseña
export function getPasswordResetEmailTemplate(resetLink, username) {
  return `
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <style>
            body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
            .container { max-width: 600px; margin: 20px auto; background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            .header { text-align: center; margin-bottom: 20px; border-bottom: 2px solid #EBB583; padding-bottom: 10px; }
            .logo { font-size: 24px; font-weight: bold; color: #EBB583; }
            .content { margin: 20px 0; }
            .button { display: inline-block; background-color: #EBB583; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; margin: 20px 0; }
            .footer { text-align: center; color: #999; font-size: 12px; margin-top: 20px; }
            .warning { background-color: #fff3cd; padding: 10px; border-left: 4px solid #ffc107; margin: 15px 0; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <div class="logo">Pansoft</div>
                <p>Sistema de Gestión para Panaderías</p>
            </div>
            
            <div class="content">
                <h2>Solicitud de Recuperación de Contraseña</h2>
                <p>Hola <strong>${username}</strong>,</p>
                <p>Recibimos una solicitud para recuperar tu contraseña. Si no fuiste tú, por favor ignora este email.</p>
                
                <p>Haz clic en el botón de abajo para establecer una nueva contraseña. Este enlace vencerá en <strong>30 minutos</strong>:</p>
                
                <center>
                    <a href="${resetLink}" class="button">Resetear Contraseña</a>
                </center>
                
                <p>O copia y pega este enlace en tu navegador:</p>
                <p style="word-break: break-all; background-color: #f0f0f0; padding: 10px; border-radius: 4px;">
                    ${resetLink}
                </p>
                
                <div class="warning">
                    <strong>⚠ Seguridad:</strong> Nunca compartas este enlace con nadie. Pansoft nunca te pedirá tu contraseña por email.
                </div>
            </div>
            
            <div class="footer">
                <p>© 2026 Pansoft. Todos los derechos reservados.</p>
                <p>Este email fue enviado porque se realizó una solicitud de recuperación de contraseña.</p>
            </div>
        </div>
    </body>
    </html>
  `;
}
