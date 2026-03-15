# PANSOFT — SISTEMA DE GESTIÓN PARA PANADERÍAS
## Documentación Técnica Completa para Defensa de Proyecto de Grado

---

> **Nota para el estudiante:** Este documento está diseñado para que lo leas, lo estudies y lo expliques en tu defensa. Cada sección responde a una pregunta típica de un jurado evaluador. Aprende los conceptos con tus propias palabras; no memorices, entiende.

---

## TABLA DE CONTENIDOS

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Planteamiento del Problema](#2-planteamiento-del-problema)
3. [Justificación](#3-justificación)
4. [Objetivos](#4-objetivos)
5. [Marco Teórico y Tecnológico](#5-marco-teórico-y-tecnológico)
6. [Metodología de Desarrollo](#6-metodología-de-desarrollo)
7. [Arquitectura del Sistema](#7-arquitectura-del-sistema)
8. [Diseño de la Base de Datos](#8-diseño-de-la-base-de-datos)
9. [Módulos y Funcionalidades del Sistema](#9-módulos-y-funcionalidades-del-sistema)
10. [Seguridad del Sistema](#10-seguridad-del-sistema)
11. [Despliegue y Entorno de Producción](#11-despliegue-y-entorno-de-producción)
12. [API REST — Documentación de Endpoints](#12-api-rest--documentación-de-endpoints)
13. [Interfaz de Usuario](#13-interfaz-de-usuario)
14. [Pruebas y Validación](#14-pruebas-y-validación)
15. [Resultados y Conclusiones](#15-resultados-y-conclusiones)
16. [Glosario Técnico](#16-glosario-técnico)
17. [Preguntas Frecuentes del Jurado y Respuestas Sugeridas](#17-preguntas-frecuentes-del-jurado-y-respuestas-sugeridas)

---

## 1. RESUMEN EJECUTIVO

**Pansoft** es un sistema de información web desarrollado para la gestión integral de panaderías y establecimientos de producción artesanal de alimentos. El sistema digitaliza y automatiza los procesos operativos críticos de una panadería: control de inventario de productos terminados e insumos, gestión de pedidos de venta y producción, facturación, administración de clientes, proveedores y empleados, generación de reportes analíticos y un sistema de notificaciones en tiempo real.

El proyecto fue construido utilizando una arquitectura de tres capas (frontend, backend, base de datos), completamente contenerizado con **Docker** para garantizar portabilidad y reproducibilidad del entorno tanto en desarrollo como en producción. El despliegue en producción se realiza en un servidor Ubuntu en la nube (**DigitalOcean**, IP: 165.227.76.44) mediante **Docker Compose**, exponiendo la aplicación al público a través del puerto 80.

**Datos técnicos clave:**
- Lenguaje backend: JavaScript (Node.js con módulos ES)
- Lenguaje frontend: JavaScript (React 18)
- Base de datos: MySQL 8.0
- Contenerización: Docker + Docker Compose
- Autenticación: JSON Web Tokens (JWT)
- Comunicación: API REST con JSON
- Puerto de producción (frontend público): 80
- Puerto de API (backend): 5000
- Módulos del sistema: 14 módulos funcionales

---

## 2. PLANTEAMIENTO DEL PROBLEMA

### 2.1 Contexto

Las panaderías y negocios de producción de panes y pasteles son, en su mayoría, pequeñas y medianas empresas (PyMEs) que operan con procesos altamente manuales. El registro de pedidos en libretas, el control de inventario de memoria o en hojas de cálculo, la comunicación verbal entre el área de producción y ventas, y la ausencia de reportes históricos son comunes en este tipo de negocios.

### 2.2 Problemas Identificados

| # | Problema | Consecuencia |
|---|----------|-------------|
| 1 | Control de inventario manual | Pérdidas por desabastecimiento o sobrestock no detectados |
| 2 | Sin trazabilidad de pedidos | Pedidos perdidos, mal comunicados o entregados tarde |
| 3 | Facturación en papel | Errores de cálculo, facturas perdidas, deudas no cobradas |
| 4 | Sin control de insumos (materias primas) | Producción interrumpida por falta de ingredientes |
| 5 | Ausencia de reportes | Decisiones sin datos: no se sabe qué producto vende más |
| 6 | Sin sistema de alertas | Productos vencidos, stock crítico no detectado a tiempo |
| 7 | Gestión de empleados informal | Sin registro de contraseñas seguras, sin roles diferenciados |

### 2.3 Pregunta Problema

> *¿Cómo puede un sistema de información web centralizado mejorar la gestión operativa, el control de inventario, la trazabilidad de pedidos y la toma de decisiones en una panadería?*

---

## 3. JUSTIFICACIÓN

### 3.1 Justificación Tecnológica

El uso de tecnologías web modernas (React, Node.js, MySQL) permite desarrollar una solución que funciona desde cualquier dispositivo con navegador sin necesidad de instalación. La contenerización con Docker garantiza que el sistema funcione de forma idéntica en cualquier entorno, eliminando el problema clásico de "en mi máquina sí funciona".

### 3.2 Justificación Económica

El sistema permite al negocio reducir pérdidas por:
- Stock no controlado (insumos vencidos o agotados)
- Pedidos mal gestionados (clientes insatisfechos)
- Deudas no cobradas (facturas sin seguimiento)

### 3.3 Justificación Académica

El proyecto integra conocimientos de: diseño de bases de datos relacionales, desarrollo de APIs REST, programación orientada a componentes en React, seguridad informática (autenticación JWT, hashing de contraseñas), DevOps básico (Docker, despliegue en nube) y metodologías ágiles. Representa la síntesis práctica de toda la formación del programa de ingeniería/sistemas.

---

## 4. OBJETIVOS

### 4.1 Objetivo General

Desarrollar e implementar un sistema de información web para la gestión integral de panaderías que centralice los procesos de inventario, producción, ventas, facturación y recursos humanos, mejorando la eficiencia operativa y la toma de decisiones.

### 4.2 Objetivos Específicos

1. **Diseñar** un modelo de base de datos relacional normalizado que soporte todos los procesos del negocio (productos, insumos, pedidos, facturación, empleados, proveedores, clientes).

2. **Desarrollar** una API REST segura con Node.js/Express que exponga 14 módulos funcionales con autenticación JWT y control de acceso basado en roles (RBAC).

3. **Implementar** una interfaz de usuario moderna y responsiva con React 18 que permita la operación intuitiva del sistema desde cualquier dispositivo.

4. **Integrar** un sistema de notificaciones automáticas que alerte sobre stock crítico, insumos próximos a vencer y pedidos pendientes mediante tareas programadas.

5. **Desplegar** el sistema en un entorno de producción en la nube utilizando contenedores Docker para garantizar disponibilidad, portabilidad y escalabilidad.

6. **Implementar** un sistema de seguridad completo que incluya: hashing de contraseñas con bcrypt, autenticación JWT, recuperación de contraseña por correo electrónico y control de permisos por módulo.

---

## 5. MARCO TEÓRICO Y TECNOLÓGICO

> *Esta sección explica CADA tecnología usada. Si el jurado pregunta "¿por qué usaron X?", la respuesta está aquí.*

---

### 5.1 ARQUITECTURA DE APLICACIONES WEB — TRES CAPAS

Una aplicación web moderna se divide en tres capas lógicas:

```
┌─────────────────────────────────────────────────────────┐
│  CAPA DE PRESENTACIÓN (Frontend)                        │
│  React + Vite → Lo que el usuario ve en el navegador    │
├─────────────────────────────────────────────────────────┤
│  CAPA DE LÓGICA DE NEGOCIO (Backend)                    │
│  Node.js + Express → Procesa reglas, valida, responde   │
├─────────────────────────────────────────────────────────┤
│  CAPA DE DATOS (Base de Datos)                          │
│  MySQL 8.0 → Almacena y persiste la información         │
└─────────────────────────────────────────────────────────┘
```

**¿Por qué tres capas?** Separar responsabilidades permite que cada capa evolucione independientemente. Si necesitamos cambiar la base de datos, no tocamos el frontend. Si rediseñamos la UI, no tocamos la lógica de negocio.

---

### 5.2 NODE.JS

**¿Qué es?** Node.js es un entorno de ejecución de JavaScript del lado del servidor, construido sobre el motor V8 de Chrome. Permite usar el mismo lenguaje (JavaScript) tanto en el frontend como en el backend.

**Características clave usadas en Pansoft:**
- **Módulos ES (ESM):** El proyecto usa `"type": "module"` en package.json, lo que permite usar `import/export` nativo en lugar del antiguo `require()`.
- **Asincronismo:** Node.js usa un modelo de I/O sin bloqueo (non-blocking). Todas las consultas a la base de datos usan `async/await` con promesas, permitiendo atender múltiples solicitudes concurrentes sin bloquear el servidor.
- **Event Loop:** Node.js procesa las solicitudes en un solo hilo pero de forma no bloqueante, lo que lo hace eficiente para aplicaciones con muchas operaciones de red/BD.

**Versión usada:** Compatible con Node.js 18+ (requerido por ESM y dependencias modernas).

---

### 5.3 EXPRESS.JS

**¿Qué es?** Express es el framework web más popular para Node.js. Proporciona un sistema de enrutamiento, middleware y utilidades para construir APIs REST.

**Conceptos clave:**
- **Middleware:** Funciones que se ejecutan en cadena antes de llegar al controlador final. En Pansoft se usan para: verificar JWT (`verifyToken`), validar roles (`checkRole`), parsear JSON (`express.json()`), habilitar CORS.
- **Router:** Permite organizar las rutas por módulo en archivos separados (`auth.js`, `products.js`, etc.) y montarlos bajo un prefijo (`/api/auth`, `/api/products`).
- **Patrón Factory:** Las rutas en Pansoft son funciones que reciben el `pool` de conexiones como parámetro (`authRoutes(pool)`), siguiendo el patrón de inyección de dependencias.

---

### 5.4 MYSQL 8.0

**¿Qué es?** MySQL es un sistema de gestión de bases de datos relacionales (RDBMS) de código abierto, el más utilizado en el mundo para aplicaciones web. La versión 8.0 introduce mejoras significativas en: Window Functions, CTEs (Common Table Expressions), mejor soporte UTF8MB4 (emojis y caracteres especiales), y JSON nativo.

**Conceptos clave usados:**
- **Transacciones:** Operaciones críticas (como crear una orden de producción con todos sus insumos) se ejecutan dentro de `BEGIN TRANSACTION ... COMMIT / ROLLBACK`. Si algo falla, todo se deshace. En Pansoft se usa en `sales-orders.js` y `production-orders.js`.
- **Índices:** Las tablas críticas tienen índices en columnas frecuentemente filtradas (`category`, `status`, `expiry_date`) para optimizar las consultas.
- **Soft Delete:** En lugar de eliminar físicamente registros (productos, insumos, proveedores), se cambia `is_active = 0/false`. Esto preserva la integridad referencial y el historial.
- **Pool de conexiones:** En lugar de abrir y cerrar una conexión por cada solicitud, se mantiene un pool de hasta 10 conexiones activas (`connectionLimit: 10`), mejorando el rendimiento.
- **ON DELETE CASCADE:** Las tablas hijas (ej. `order_items`) tienen `ON DELETE CASCADE` referenciando la tabla padre (`orders`), para que al borrar un pedido se borren automáticamente sus ítems.
- **Charset utf8mb4:** Se usa `utf8mb4` (no `utf8`) porque es el único charset de MySQL que soporta completamente Unicode, incluyendo caracteres de 4 bytes.

---

### 5.5 REACT 18

**¿Qué es?** React es una biblioteca JavaScript desarrollada por Meta (Facebook) para construir interfaces de usuario basadas en componentes. La versión 18 introduce: Concurrent Mode, `useTransition`, y mejoras en el renderizado paralelo.

**Paradigma:** React usa un paradigma **declarativo** (describes cómo debe verse la UI dado un estado) en contraposición al imperativo (manipular el DOM directamente).

**Conceptos clave usados en Pansoft:**

| Concepto | Uso en Pansoft |
|----------|---------------|
| **Componentes funcionales** | Todos los componentes son funciones (no clases) |
| **Hooks** | `useState` (estado local), `useEffect` (efectos secundarios/llamadas API), `useCallback`, `useMemo` |
| **Context API** | `PermissionsProvider` comparte los permisos del usuario con todos los componentes sin pasar props manualmente |
| **React Router DOM v7** | Navegación SPA (Single Page Application) entre módulos sin recargar la página |
| **JSX** | Sintaxis que mezcla HTML con JavaScript para describir la UI |

---

### 5.6 VITE

**¿Qué es?** Vite es una herramienta de construcción (build tool) de nueva generación para proyectos web. Es significativamente más rápido que Webpack porque usa ES Modules nativos del navegador durante el desarrollo y Rollup para la compilación de producción.

**Ventajas sobre Create React App (la alternativa clásica):**
- Inicio en caliente (HMR - Hot Module Replacement) casi instantáneo
- Build de producción más pequeño y optimizado
- Configuración más simple

**Configuración clave en Pansoft (`vite.config.js`):**
- `base: './'` → Genera rutas de assets relativas (crítico para producción detrás de Nginx)
- `server.proxy` → En desarrollo, redirige `/api` al backend en `localhost:5000`
- `manualChunks: undefined` → Genera un solo bundle (simplifica el despliegue)

---

### 5.7 DOCKER Y DOCKER COMPOSE

**¿Qué es Docker?** Docker es una plataforma de contenerización. Un **contenedor** es una unidad de software que empaqueta el código y todas sus dependencias (Node.js, librerías, variables de entorno) en un paquete aislado que corre de forma consistente en cualquier máquina.

**¿Diferencia entre contenedor y máquina virtual?**
- La VM virtualiza el hardware completo (incluye SO propio) → Pesada (GB)
- El contenedor comparte el kernel del SO host → Liviano (MB), inicia en segundos

**Docker Compose:** Herramienta para definir y ejecutar aplicaciones multi-contenedor. En Pansoft coordina 4 servicios:

| Servicio | Imagen/Dockerfile | Puerto | Función |
|----------|------------------|--------|---------|
| `db` | `mysql:8.0` | 3306 (interno) | Base de datos MySQL |
| `backend` | `./backend/Dockerfile` | 5000 | API Node.js/Express |
| `frontend` | `./frontend/Dockerfile` | 80 | Nginx sirviendo React |
| `phpmyadmin` | `phpmyadmin/phpmyadmin` | 8082 | Admin visual de BD |

**Healthcheck en producción:** El backend espera a que MySQL esté saludable (`condition: service_healthy`) antes de iniciar. El healthcheck ejecuta `mysqladmin ping` cada 10 segundos con hasta 10 reintentos y 30 segundos de período inicial.

---

### 5.8 NGINX

**¿Qué es?** Nginx es un servidor web y proxy reverso de alto rendimiento. En Pansoft se usa como servidor de archivos estáticos en producción para servir el build de React.

**¿Por qué no servir React directamente desde Node.js?** Nginx es especialista en servir archivos estáticos (HTML, CSS, JS) y es hasta 10x más eficiente que Node.js para esta tarea. Node.js se reserva para la lógica de negocio (API).

**Configuración crítica:** El archivo `nginx.conf` de Pansoft incluye la directiva `try_files $uri /index.html`, fundamental para que el enrutamiento del lado del cliente (React Router) funcione. Sin esto, una recarga en `/productos` daría 404.

---

### 5.9 JWT — JSON Web Tokens

**¿Qué es?** Un JWT es un estándar abierto (RFC 7519) para transmitir información de forma segura entre partes como un objeto JSON compacto y firmado digitalmente.

**Estructura:** Un JWT tiene tres partes separadas por puntos: `header.payload.signature`

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
.eyJ1c2VySWQiOjEsInVzZXJuYW1lIjoiYWRtaW4iLCJyb2xlIjoiQWRtaW5pc3RyYWRvciBHZW5lcmFsIiwiaWF0IjoxNzQxNjM1MjAwLCJleHAiOjE3NDE3MjE2MDB9
.firma_hmac_sha256
```

- **Header:** Algoritmo usado (HS256)
- **Payload:** Datos del usuario (`userId`, `username`, `role`, `iat`, `exp`)
- **Signature:** HMAC-SHA256 del header+payload firmado con `JWT_SECRET`

**Flujo en Pansoft:**
1. Usuario hace login → Backend verifica credenciales → Genera JWT de 24h → Lo envía al frontend
2. Frontend guarda el JWT en localStorage
3. En cada solicitud, el frontend incluye el JWT en el header: `Authorization: Bearer <token>`
4. El middleware `verifyToken` valida la firma → Si válida, `req.user = payload decodificado`

**¿Por qué 24 horas de expiración?** Balance entre seguridad (si el token es robado, expira en 24h) y usabilidad (el usuario no tiene que volver a iniciar sesión cada hora).

---

### 5.10 BCRYPT

**¿Qué es?** Bcrypt es una función de hashing de contraseñas diseñada intencionalmente para ser **lenta**, dificultando ataques de fuerza bruta. A diferencia de MD5 o SHA256 (diseñados para ser rápidos), bcrypt puede configurarse para tomar más tiempo a medida que el hardware mejora.

**Conceptos:**
- **Salt:** Valor aleatorio único añadido antes del hashing. Evita ataques de tablas arcoíris (rainbow tables).
- **Cost factor (salt rounds):** En Pansoft se usan **10 rounds**, lo que hace que cada hash tome ~100ms. Con 10^12 contraseñas posibles, un atacante tardaría décadas.
- **Verificación:** `bcrypt.compare(plaintext, hash)` → Nunca se desencripta el hash; se compara el hash del intento con el hash guardado.

**Uso en Pansoft:** Al registrar/cambiar contraseña → `bcrypt.hash(password, 10)`. Al verificar login → `bcrypt.compare(password, hash_guardado)`.

---

### 5.11 NODEMAILER

**¿Qué es?** Nodemailer es una librería Node.js para enviar correos electrónicos desde el backend. Soporta múltiples transportes: SMTP directo, Gmail, SendGrid, Mailtrap (testing), etc.

**Uso en Pansoft:** Solo para el flujo de recuperación de contraseña:
1. Usuario solicita reset → Backend genera `crypto.randomBytes(32)` (token seguro de 32 bytes)
2. Se guarda el **hash SHA-256** del token en la BD (nunca el token en claro)
3. Se envía el token en claro al email del usuario como parte de un link
4. Usuario hace clic → Backend vuelve a hashear el token del link → Compara con el hash en BD
5. Si coincide y no ha expirado (30 minutos) → Se permite cambiar la contraseña

**¿Por qué guardar el hash y no el token?** Si la BD es comprometida, el atacante solo tiene el hash del token, nunca el token real. El token en el email es el único lugar donde existe en claro.

---

### 5.12 MULTER

**¿Qué es?** Multer es middleware para manejar `multipart/form-data`, el tipo de formulario usado para subir archivos. Pansoft lo usa para subir imágenes de productos e insumos.

**Configuración en Pansoft:** Las imágenes se guardan en `./uploads/images/` con nombres únicos basados en timestamp + número aleatorio. Se sirven estáticamente bajo `/uploads/images/nombrearchivo.jpg` gracias a `express.static('uploads')`.

---

### 5.13 AXIOS

**¿Qué es?** Axios es un cliente HTTP para JavaScript (navegador y Node.js) basado en Promesas. Es la alternativa más popular al `fetch` nativo del navegador, con ventajas como: interceptores, transformación automática de JSON, mejor manejo de errores.

**Uso en Pansoft:** Todos los servicios del frontend (`authAPI`, `productsAPI`, `ordersAPI`, etc.) usan Axios para comunicarse con el backend. Se configura el header `Authorization: Bearer <token>` de forma global para autenticar todas las solicitudes.

---

### 5.14 RECHARTS

**¿Qué es?** Recharts es una librería de gráficas para React, construida sobre D3.js. Provee componentes declarativos para crear gráficas responsivas.

**Uso en Pansoft:**
- Dashboard: Gráfica de área (ventas mensuales de 12 meses) + Gráfica de barras + Gráfica de pastel (categorías de productos)
- Reportes: Gráficas de ventas con filtros de fecha

---

### 5.15 REACT ROUTER DOM v7

**¿Qué es?** React Router es la librería estándar de enrutamiento para React. Permite definir "páginas" (rutas) en una SPA (Single Page Application) sin recargas de página.

**SPA vs MPA:**
- **MPA (Multi-Page Application):** Cada navegación descarga una nueva página HTML del servidor (tradicional)
- **SPA (Single Page Application):** Se carga una sola página HTML; JavaScript intercambia los componentes sin recargar. Más rápido y fluido para el usuario.

**Rutas en Pansoft:**

```
/ → Dashboard (si autenticado) | Login (si no)
/login → Login
/reset-password?token=XXX → Cambiar contraseña vía email
/inventario → Módulo de inventario
/productos → Módulo de productos e insumos
/proveedores → Gestión de proveedores
/ordenes → Pedidos de venta y producción
/facturacion → Punto de venta / facturación
/empleados → Gestión de empleados
/reportes → Reportes analíticos
/notificaciones → Centro de notificaciones
/configuracion → Configuración del sistema
```

---

### 5.16 BOOTSTRAP 5

**¿Qué es?** Bootstrap es el framework CSS más popular del mundo. Provee componentes UI prediseñados (botones, modales, tablas, formularios, grillas) y un sistema de grid responsivo de 12 columnas.

**Uso en Pansoft:** Layouts responsivos, modales, badges de estado (para niveles de stock), formularios, botones, navegación lateral (sidebar).

---

## 6. METODOLOGÍA DE DESARROLLO

### 6.1 Metodología Ágil — Scrum Adaptado

El proyecto se desarrolló utilizando una metodología ágil inspirada en **Scrum**, adaptada al contexto de un equipo pequeño de desarrollo académico.

**Scrum** es un framework ágil que organiza el trabajo en iteraciones cortas llamadas **Sprints** (generalmente de 1-4 semanas), con entregables funcionales al final de cada sprint.

### 6.2 Fases del Proyecto

```
FASE 1: ANÁLISIS Y DISEÑO          (Semanas 1-3)
│ └── Análisis de requisitos
│ └── Casos de uso
│ └── Diseño de base de datos (MER/MR)
│ └── Decisiones tecnológicas

FASE 2: CONFIGURACIÓN DEL ENTORNO  (Semana 4)
│ └── Setup Docker (dev + prod)
│ └── Estructura base del proyecto
│ └── Conexión BD, primer endpoint

FASE 3: DESARROLLO DEL BACKEND     (Semanas 5-9)
│ └── Autenticación (JWT + bcrypt)
│ └── CRUD de entidades base (productos, insumos, proveedores)
│ └── Módulo de pedidos (ventas + producción)
│ └── Facturación
│ └── Empleados + control de acceso RBAC
│ └── Notificaciones + tareas programadas

FASE 4: DESARROLLO DEL FRONTEND    (Semanas 7-13)
│ └── Componentes base (Login, Sidebar, Dashboard)
│ └── Módulos CRUD (paralelo al backend)
│ └── Sistema de permisos en UI
│ └── Gráficas y reportes
│ └── Recuperación de contraseña

FASE 5: INTEGRACIÓN Y PRUEBAS      (Semanas 12-14)
│ └── Integración frontend-backend
│ └── Pruebas funcionales por módulo
│ └── Corrección de bugs

FASE 6: DESPLIEGUE Y DOCUMENTACIÓN (Semanas 14-16)
    └── Docker Compose producción
    └── Despliegue en DigitalOcean
    └── Documentación técnica
```

### 6.3 Herramientas de Desarrollo

| Herramienta | Uso |
|------------|-----|
| **Visual Studio Code** | IDE principal de desarrollo |
| **Git + GitHub** | Control de versiones y colaboración |
| **Docker Desktop** | Ejecución local de contenedores |
| **Postman / Insomnia** | Pruebas de la API REST |
| **MySQL Workbench** | Diseño visual del esquema de BD |
| **phpMyAdmin** | Gestión visual de datos en desarrollo |
| **Chrome DevTools** | Depuración de frontend |

### 6.4 Control de Versiones con Git

El proyecto usa **Git** con un flujo de trabajo basado en ramas:
- `master` → Rama principal, código estable en producción 
- El despliegue se activa con `git push` al servidor de producción

---

## 7. ARQUITECTURA DEL SISTEMA

### 7.1 Arquitectura General

Pansoft implementa una arquitectura **cliente-servidor** con separación clara de responsabilidades:

```
                        INTERNET
                           │
                    ┌──────▼──────┐
                    │  DigitalOcean│
                    │  Ubuntu 22.04│
                    │  165.227.76.44│
                    └──────────────┘
                           │
          ┌────────────────┼────────────────┐
          │         DOCKER COMPOSE          │
          │         pansoft_net             │
          │                                 │
   ┌──────▼──────┐   ┌──────────────┐  ┌──▼──────────┐
   │  Frontend   │   │   Backend    │  │   MySQL 8.0  │
   │  Nginx:80   │──▶│  Express:5000│──▶│  pansoft_db  │
   │  React SPA  │   │  Node.js     │  │  Port 3306   │
   └─────────────┘   └──────────────┘  └─────────────┘
          │                  │
          │           ┌──────▼──────┐
          │           │  phpMyAdmin │
          │           │  Port 8082  │
          │           └─────────────┘
          │
    Usuario Final
    (Navegador web)
```

### 7.2 Flujo de una Solicitud Típica

```
1. Usuario hace clic en "Guardar Producto" en el navegador
   │
2. React llama a productsAPI.create(datos) con Axios
   │
3. Axios envía: POST /api/products
   Headers: { Authorization: "Bearer <JWT>" }
   Body: { name: "Pan Francés", sku: "PAN-001", ... }
   │
4. Request llega al servidor Ubuntu en puerto 80 (Nginx)
   │
5. Nginx hace proxy_pass al backend en puerto 5000
   │
6. Express recibe la solicitud
   │
7. Middleware 1: CORS → Permite el origen
   │
8. Middleware 2: express.json() → Parsea el JSON del body
   │
9. Middleware 3: verifyToken → Valida el JWT
   │          └── Si inválido: responde 401 Unauthorized
   │
10. Middleware 4: checkRole(['Administrador General']) → Verifica rol
    │          └── Si no autorizado: responde 403 Forbidden
    │
11. Controlador: Valida campos, consulta BD para verificar SKU único
    │
12. MySQL: INSERT INTO products VALUES (...)
    │
13. Backend responde: { success: true, product: { id: 15, name: "Pan Francés", ... } }
    │
14. React actualiza el estado → La tabla se re-renderiza con el nuevo producto
    │
15. Sonner muestra: "✓ Producto creado exitosamente"
```

### 7.3 Patrón de Diseño — API REST

Pansoft implementa el estilo arquitectónico **REST (Representational State Transfer)**. Los principios REST que sigue:

| Principio REST | Implementación en Pansoft |
|---------------|--------------------------|
| **Stateless** | El servidor no guarda estado de sesión; todo el estado está en el JWT |
| **Resource-based URLs** | `/api/products/5` identifica el recurso "producto con ID 5" |
| **HTTP Verbs semánticos** | GET=leer, POST=crear, PUT=actualizar completo, PATCH=actualizar parcial, DELETE=eliminar |
| **JSON como formato** | Todas las respuestas/solicitudes son JSON |
| **Códigos HTTP estándar** | 200 OK, 201 Created, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 500 Internal Server Error |

### 7.4 Patrón de Control de Acceso Basado en Roles (RBAC)

Pansoft implementa **RBAC (Role-Based Access Control)**, donde los permisos se asignan a roles, y los usuarios tienen un rol asignado.

```
Usuario "Juan Pérez"
       │
       ▼ tiene rol
  "Panadero" (role_id: 4)
       │
       ▼ tiene permisos
  - production-orders.read: ✅
  - production-orders.write: ✅
  - products.read: ✅
  - inventory.write: ❌ (no puede ajustar inventario)
  - employees.read: ❌ (no ve empleados)
  - billing.read: ❌ (no ve facturación)
```

**Roles del sistema:**

| ID | Rol | Descripción |
|----|-----|------------|
| 1 | Administrador General | Acceso total a todos los módulos |
| 2 | Encargado de Ventas | Pedidos, clientes, facturación, reportes |
| 3 | Supervisor de Stock | Inventario, productos, insumos, proveedores |
| 4 | Panadero | Órdenes de producción, consulta de productos |

### 7.5 Arquitectura del Frontend — Componentes

```
App.jsx (raíz de la aplicación)
├── PermissionsProvider (Context API)
│   ├── Sidebar (navegación lateral)
│   ├── ChangePasswordModal (forzar cambio de contraseña)
│   └── Rutas (React Router)
│       ├── /dashboard    → Dashboard.jsx
│       ├── /inventario   → Inventory.jsx
│       │                    ├── InventoryStats
│       │                    ├── InventoryTable
│       │                    ├── MovementHistory
│       │                    └── MovementModal / EditModal
│       ├── /productos    → Products.jsx
│       │                    ├── ProductsSection.jsx
│       │                    └── SuppliesSection.jsx
│       ├── /proveedores  → Suppliers/index.jsx
│       │                    ├── SuppliersHeader
│       │                    ├── SuppliersStats
│       │                    ├── SuppliersSearchBar
│       │                    ├── SuppliersTable
│       │                    └── SupplierModal
│       ├── /ordenes      → Orders.jsx
│       │                    ├── SalesOrdersTable
│       │                    ├── ProductionOrdersTable
│       │                    ├── OrderFormModal
│       │                    └── OrderDetailsModal
│       ├── /facturacion  → Billing.jsx → SalesPoint.jsx
│       ├── /empleados    → Employees.jsx
│       ├── /reportes     → Reports.jsx (8 secciones)
│       ├── /notificaciones → Notifications.jsx
│       └── /configuracion → Settings.jsx
```

---

## 8. DISEÑO DE LA BASE DE DATOS

### 8.1 Modelo Entidad-Relación (Descripción)

La base de datos `pansoft_db` contiene **19 tablas** organizadas en los siguientes dominios:

```
DOMINIO USUARIOS Y SEGURIDAD:
  users ──────── roles ──────── permissions
                    └──── role_permissions ──┘

DOMINIO PRODUCTOS E INVENTARIO:
  products ──── inventory ──── inventory_movements
  supplies ──────────────────── supplies_movements

DOMINIO CADENA DE SUMINISTRO:
  suppliers ──── supplies (FK supplier_id)

DOMINIO VENTAS:
  customers ──── sales_orders ──── sales_order_items ──── products
                              └─── sales_order_insumos ── supplies
                └── orders ──── order_items ──── products

DOMINIO PRODUCCIÓN:
  products ──── production_orders ──── production_order_insumos ──── supplies
  employees ─────────────────────────┘

DOMINIO FACTURACIÓN:
  customers ──── invoices ──── orders

DOMINIO REPORTES:
  sales_reports (tabla de reporting independiente)

DOMINIO NOTIFICACIONES:
  notifications (alertas internas del sistema)
```

### 8.2 Descripción Detallada de Tablas

#### Tabla: `users` — Usuarios del sistema

| Columna | Tipo | Descripción |
|---------|------|------------|
| `id` | INT PK AUTO_INCREMENT | Identificador único |
| `username` | VARCHAR(50) UNIQUE NOT NULL | Nombre de usuario para login |
| `email` | VARCHAR(100) UNIQUE NOT NULL | Correo electrónico único |
| `password` | VARCHAR(255) NOT NULL | Hash bcrypt de la contraseña |
| `full_name` | VARCHAR(100) | Nombre completo |
| `role` | VARCHAR(20) DEFAULT 'user' | Rol en texto (campo legado) |
| `role_id` | INT FK → roles(id) | Rol estructurado (FK) |
| `must_change_password` | TINYINT(1) DEFAULT 0 | Si es 1, forzar cambio en próximo login |
| `reset_token` | VARCHAR(255) | Hash SHA-256 del token de recuperación |
| `reset_token_expires` | DATETIME | Expiración del token (30 min) |
| `created_at` / `updated_at` | TIMESTAMP | Auditoría de tiempo |

#### Tabla: `products` — Productos terminados

| Columna | Tipo | Descripción |
|---------|------|------------|
| `id` | INT PK AUTO_INCREMENT | Identificador único |
| `name` | VARCHAR(100) NOT NULL | Nombre del producto |
| `sku` | VARCHAR(50) UNIQUE NOT NULL | Código único de producto |
| `description` | LONGTEXT | Descripción detallada |
| `category` | VARCHAR(50) IDX | Categoría: Panadería, Pastelería, Tortas... |
| `price` | DECIMAL(10,2) | Precio de venta |
| `stock_quantity` | INT DEFAULT 0 | Cantidad en stock |
| `min_stock_level` | INT DEFAULT 10 | Umbral mínimo para alerta de stock |
| `image_url` | VARCHAR(255) | Ruta de imagen subida |
| `is_active` | TINYINT(1) DEFAULT 1 | 1=activo, 0=eliminado (soft delete) |
| `expiry_date` | DATE IDX | Fecha de vencimiento (para alertas) |

#### Tabla: `supplies` — Insumos/materias primas

Misma estructura que `products`, con columnas adicionales:
- `unit` → Unidad de medida: `kg`, `L`, `unidad`, `g`
- `supplier_id` → FK a `suppliers(id)` (proveedor del insumo)

#### Tabla: `inventory` — Registro de inventario físico

| Columna | Descripción |
|---------|------------|
| `product_id` FK | Producto al que corresponde |
| `warehouse_location` | Ubicación en bodega |
| `quantity` | Cantidad física registrada |
| `last_updated` | Última actualización automática |

*Nota: Esta tabla es complementaria. `products.stock_quantity` es la fuente principal de verdad.*

#### Tabla: `sales_orders` — Órdenes de venta

| Columna | Descripción |
|---------|------------|
| `order_number` | Formato: `VNT-2025-001` (autoincremental por año) |
| `customer_name` | Nombre denormalizado (para mostrar sin JOIN) |
| `customer_id` | FK opcional a `customers` |
| `status` | `pendiente` → `confirmada` → `en_preparacion` → `lista` → `entregada` / `cancelada` |
| `total_amount` | Total calculado de los ítems |

#### Tabla: `production_orders` — Órdenes de producción

| Columna | Descripción |
|---------|------------|
| `order_number` | Formato: `PROD-001` (secuencial) |
| `product_id` | Qué producto se va a producir |
| `quantity` | Cuántas unidades producir |
| `responsible_employee_id` | FK al empleado responsable |
| `status` | `pendiente`, `en_proceso`, `completada`, `cancelada` |

#### Tabla: `production_order_insumos` — Insumos para producción

Relaciona cada orden de producción con los insumos necesarios:
- `production_order_id` FK
- `insumo_id` FK → `supplies`
- `quantity_required` → Cantidad necesaria
- `quantity_used` → Cantidad real utilizada

#### Tabla: `invoices` — Facturas

| Columna | Descripción |
|---------|------------|
| `invoice_number` | Formato: `FAC-{timestamp}-{aleatorio}` |
| `order_id` | FK a la orden de venta asociada |
| `customer_id` | FK al cliente |
| `issue_date` | Fecha de emisión |
| `due_date` | Fecha de vencimiento de pago |
| `total_amount` | Monto total |
| `paid_amount` | Monto pagado (default 0) |
| `status` | `pending`, `partial`, `paid`, `overdue` |

#### Tabla: `notifications` — Notificaciones internas

| Columna | Descripción |
|---------|------------|
| `type` | `inventory`, `order`, `warning`, `success`, `info` |
| `title` | Título breve de la alerta |
| `message` | Descripción detallada |
| `is_read` | Si fue leída por el usuario |
| `user_id` | Usuario destinatario (opcional) |

*Índices optimizados: `idx_user_id`, `idx_is_read`, `idx_created_at`*

### 8.3 Normalización de la Base de Datos

La base de datos sigue las reglas de normalización hasta la **Tercera Forma Normal (3FN)**:

- **1FN:** Todos los atributos son atómicos; no hay grupos repetitivos. ✅
- **2FN:** Todos los atributos no clave dependen completamente de la clave primaria. ✅
- **3FN:** No hay dependencias transitivas. Los datos del cliente en una factura se referencian vía FK, no se duplican. ✅

**Excepción justificada (desnormalización deliberada):** `sales_orders.customer_name` está desnormalizado (duplicado del nombre del cliente) para facilitar consultas de lectura sin JOIN, una práctica común en sistemas OLTP con alto volumen de lecturas.

### 8.4 Estrategia de Migración de Esquema

El esquema se inicializa automáticamente al arrancar el backend. La función `initializeDatabase()` ejecuta secuencialmente:

1. `init.sql` → Tablas base (users, products, suppliers, customers, employees, invoices)
2. `create_orders_tables.sql` → Tablas de pedidos (orders, order_items, sales_orders, etc.)
3. `create_supplies_tables.sql` → Tablas de insumos y movimientos
4. `seed_test_orders.sql` → Datos de ejemplo opcionales

Las migraciones usan `IF NOT EXISTS` y `IF NOT EXISTS` en `ALTER TABLE ADD COLUMN` para ser idempotentes (pueden ejecutarse múltiples veces sin error).

---

## 9. MÓDULOS Y FUNCIONALIDADES DEL SISTEMA

### 9.1 Módulo de Autenticación y Seguridad

**Funcionalidades:**
- ✅ Login con usuario y contraseña
- ✅ Registro de nuevos usuarios
- ✅ Generación de JWT con expiración de 24 horas
- ✅ Cambio de contraseña (forzado o voluntario)
- ✅ Recuperación de contraseña por email (token seguro de 30 minutos)
- ✅ Migración transparente de contraseñas en texto plano a bcrypt (compatibilidad con datos heredados)
- ✅ Control de permisos granular por módulo y acción (read/write/delete)
- ✅ Bandera `mustChangePassword` para forzar cambio en primer login (empleados nuevos)

**Flujo de recuperación de contraseña:**
```
Usuario → "Olvidé mi contraseña" → Ingresa email
                    │
Backend genera token = crypto.randomBytes(32) → hex string
                    │
BD guarda: reset_token = SHA256(token), reset_token_expires = NOW() + 30min
                    │
Email enviado: https://dominio.com/reset-password?token=<token_claro>
                    │
Usuario hace clic → Frontend envía token al backend
                    │
Backend: SHA256(token_recibido) == reset_token_en_BD y no expirado?
                    │── SÍ: Permite cambio de contraseña, limpia token
                    └── NO: Responde 400 Token inválido o expirado
```

---

### 9.2 Módulo de Dashboard

**Funcionalidades:**
- ✅ KPI 1: Total de ventas del mes actual (suma de `total_amount` de órdenes del mes)
- ✅ KPI 2: Total de productos registrados en el catálogo
- ✅ KPI 3: Producto más vendido (calculado sobre ítems de órdenes de venta y producción)
- ✅ KPI 4: Cantidad de órdenes en estado "pendiente"
- ✅ Gráfica de área: Ventas mensuales de los últimos 12 meses
- ✅ Gráfica de pastel: Distribución de productos por categoría
- ✅ Panel de alertas: Top 5 productos con stock crítico/bajo + pedidos pendientes
- ✅ Feed de actividad reciente: Productos modificados, nuevos pedidos, pedidos completados

---

### 9.3 Módulo de Inventario

**Funcionalidades:**
- ✅ Vista dual: **Pestaña Productos** (productos terminados) y **Pestaña Insumos** (materias primas)
- ✅ Panel de estadísticas: Total en inventario, valor total, items críticos, items activos
- ✅ Filtros: Por categoría, por nivel de stock (crítico/bajo/normal), por búsqueda de texto
- ✅ Ajuste de stock: Modal que registra entrada/salida/ajuste con razón y notas
- ✅ Historial de movimientos: Registro auditado de cada cambio de stock (quién, cuándo, cuánto)
- ✅ Sincronización: Cada ajuste actualiza simultáneamente `inventory.quantity` y `products.stock_quantity`
- ✅ Restricciones de acceso: Solo Administrador General y Supervisor de Stock pueden ajustar inventario

**Niveles de stock:**
- 🔴 **Crítico:** `stock_quantity ≤ min_stock_level` (alerta inmediata)
- 🟡 **Bajo:** `stock_quantity ≤ min_stock_level * 1.5` (precaución)
- 🟢 **Normal:** Stock por encima del umbral

---

### 9.4 Módulo de Productos e Insumos

**Funcionalidades de Productos:**
- ✅ Listado con vista tabla y vista cuadrícula (grid)
- ✅ Crear producto: nombre, SKU único, categoría, precio, stock, stock mínimo, descripción, imagen
- ✅ Editar producto con validación de nombre y SKU únicos (case-insensitive)
- ✅ Soft delete (desactivar) y reactivar con toggle de estado
- ✅ Búsqueda en tiempo real por nombre, SKU, categoría
- ✅ Badge de nivel de stock (Crítico/Bajo/Normal)
- ✅ Subida de imagen con Multer

**Categorías de Productos:** Panadería, Pastelería, Tortas, Donas, Galletas, Muffins, Salados, Panes, Bebidas, Otros

**Funcionalidades de Insumos (Supplies):**
- ✅ Mismas operaciones CRUD
- ✅ Campo adicional: **unidad de medida** (kg, L, g, unidad, etc.)
- ✅ Campo: **proveedor** (FK a la tabla de proveedores)
- ✅ Campo: **fecha de vencimiento** (se usa para alertas de expiración)
- ✅ Registro de movimientos de stock al actualizar cantidad

**Categorías de Insumos:** Harinas, Endulzantes, Levaduras, Lácteos, Saborizantes, Condimentos

---

### 9.5 Módulo de Proveedores

**Funcionalidades:**
- ✅ Listado con estadísticas: total, activos, por categoría
- ✅ CRUD completo con modal de formulario
- ✅ Campos: empresa, contacto, email, teléfono, dirección, ciudad, país, términos de pago, categoría
- ✅ Activar/desactivar proveedor (toggle is_active)
- ✅ Búsqueda por nombre, contacto, email
- ✅ Filtro por activos/inactivos

---

### 9.6 Módulo de Clientes

**Funcionalidades:**
- ✅ CRUD completo de clientes
- ✅ Campos: nombre, email, teléfono, dirección, ciudad, país, tipo de cliente (B2B/B2C), estado
- ✅ Búsqueda por nombre y email
- ✅ Fallback a datos mock si la API falla (para demostración o modo offline)

---

### 9.7 Módulo de Pedidos (Órdenes de Venta y Producción)

**Órdenes de Venta:**
- ✅ Crear orden con: cliente, fecha de entrega, notas, lista de productos con cantidad y precio
- ✅ Añadir insumos requeridos para la preparación del pedido
- ✅ Numeración automática: `VNT-2025-001` (secuencial por año)
- ✅ Flujo de estados: `pendiente` → `confirmada` → `en_preparacion` → `lista` → `entregada` / `cancelada`
- ✅ Ver detalle completo: encabezado + ítemns de productos + ítemns de insumos
- ✅ Notificación automática al crear una nueva orden

**Órdenes de Producción:**
- ✅ Crear orden de producción: producto a fabricar, cantidad, empleado responsable, fecha de entrega
- ✅ Añadir insumos necesarios (lista de materiales)
- ✅ Numeración automática: `PROD-001` (secuencial)
- ✅ Actualizar estado de la orden
- ✅ Ver detalle: insumos requeridos vs. insumos utilizados

---

### 9.8 Módulo de Facturación (Punto de Venta)

**Funcionalidades:**
- ✅ Interfaz de punto de venta (POS): catálogo de productos activos con búsqueda
- ✅ Carrito de compras: agregar productos, modificar cantidades, eliminar ítems
- ✅ Cálculo automático del total con cada cambio
- ✅ Generación de número de factura automático: `FAC-YYYYMMDDHHMI`
- ✅ Función de impresión de factura
- ✅ CRUD de facturas: crear, ver, actualizar estado/monto pagado, eliminar
- ✅ Verificación de facturas vencidas y próximas a vencer (creación de notificaciones)

---

### 9.9 Módulo de Empleados

**Funcionalidades:**
- ✅ CRUD completo de empleados
- ✅ Crear empleado crea simultáneamente un usuario del sistema con contraseña hasheada
- ✅ Usuario generado con `username = prefijo del email`, rol `Panadero`, flag `must_change_password = TRUE`
- ✅ Modal de credenciales mostrado al administrador después de crear (solo una vez)
- ✅ Campos: nombre, apellido, email, teléfono, cargo, departamento, fecha de contratación, salario
- ✅ Cargos: Administrador, Encargado de Ventas, Supervisor de Stock, Panadero
- ✅ Badges de cargo con colores diferenciados
- ✅ Mostrar/ocultar empleados inactivos
- ✅ Búsqueda por nombre, email, cargo

---

### 9.10 Módulo de Reportes

**8 tipos de reporte disponibles:**

| Reporte | Datos mostrados | Filtros |
|---------|----------------|---------|
| Resumen ejecutivo | KPIs globales | - |
| Ventas por período | Ventas agrupadas por día | Rango de fechas |
| Órdenes de venta | Lista con estado y totales | Estado, fechas |
| Órdenes de producción | Lista con producto y empleado | Estado |
| Productos | Catálogo con nivel de stock | - |
| Empleados | Empleados con conteo de órdenes | - |
| Clientes | Clientes con total comprado | - |
| Inventario | Stock actual con valor total | - |

**Clasificación de stock en reporte de productos:**
- `Bajo`: stock_quantity ≤ min_stock_level
- `Medio`: stock_quantity ≤ min_stock_level * 2
- `Suficiente`: stock_quantity > min_stock_level * 2

---

### 9.11 Módulo de Notificaciones

**Funcionalidades:**
- ✅ Centro de notificaciones con lista paginada
- ✅ Polling automático cada 10 segundos para contar notificaciones no leídas
- ✅ Badge con contador en el menú lateral
- ✅ Filtro: todas / solo no leídas
- ✅ Marcar como leída (individual o todas)
- ✅ Eliminar notificación individual o limpiar todas las leídas
- ✅ Íconos y colores por tipo de notificación

**Tipos de notificaciones generadas automáticamente:**

| Tipo | Trigger | Frecuencia |
|------|---------|------------|
| Stock crítico de producto | `stock_quantity ≤ min_stock_level` | Cada 30 min |
| Stock bajo de producto | `stock_quantity ≤ min_stock_level * 1.5` | Cada 30 min |
| Stock bajo de insumo | Misma lógica en `supplies` | Cada 30 min |
| Producto próximo a vencer | Dentro de 30 días | Cada 6 horas |
| Insumo próximo a vencer | Dentro de 30 días | Cada 6 horas |
| Insumo vencido | `expiry_date < HOY` | Cada 6 horas |
| Nueva orden creada | Al crear una orden | Tiempo real |

---

### 9.12 Módulo de Configuración

**Funcionalidades (UI implementada, pendiente persistencia en backend):**
- Datos de la empresa: nombre, email, teléfono, dirección
- Preferencias: zona horaria (America/Bogota), moneda (COP), idioma
- Notificaciones: toggles para email y SMS
- Seguridad: toggle de autenticación de dos factores (2FA)

---

## 10. SEGURIDAD DEL SISTEMA

### 10.1 Autenticación — JWT

- Todos los endpoints de la API (excepto `/api/auth/login`, `/api/auth/forgot-password`, `/api/auth/reset-password` y `/api/health`) requieren un JWT válido.
- El JWT se verifica en el middleware `verifyToken` usando `jwt.verify(token, process.env.JWT_SECRET)`.
- `JWT_SECRET` se almacena en variable de entorno (nunca hardcodeada en el código).
- Tiempo de expiración: 24 horas.
- Si el token es inválido: respuesta `401 Unauthorized`.
- Si el token es válido pero el rol no tiene permiso: `403 Forbidden`.

### 10.2 Almacenamiento de Contraseñas — bcrypt

- **Nunca** se almacenan contraseñas en texto plano.
- Se usa `bcrypt.hash(password, 10)` con 10 salt rounds (~100ms por hash).
- La verificación usa `bcrypt.compare()` (nunca se "desencripta").
- El sistema detecta contraseñas antiguas en texto plano al hacer login y las migra automáticamente a bcrypt.

### 10.3 Recuperación de Contraseña — Tokens Seguros

- Token generado con `crypto.randomBytes(32)` (criptográficamente seguro).
- Se guarda el **hash SHA-256** del token en BD, nunca el token en claro.
- Expiración de 30 minutos.
- Un token solo puede usarse una vez (se elimina tras usarse).

### 10.4 CORS

El middleware `cors()` está configurado para permitir todos los orígenes en desarrollo. **Recomendación para producción:** Restringir a los dominios específicos del frontend.

### 10.5 Variables de Entorno

Todos los secretos y configuraciones sensibles se manejan con variables de entorno:
- `JWT_SECRET` → Secreto de firma JWT
- `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `DB_PORT` → Credenciales de BD
- `EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_USER`, `EMAIL_PASS` → SMTP para emails

Nunca se commitean al repositorio (`.env` está en `.gitignore`).

### 10.6 Prevención de Inyección SQL

El proyecto usa `mysql2` con **consultas parametrizadas** (prepared statements):

```javascript
// ✅ SEGURO — Parámetro como ? en la consulta
await pool.execute('SELECT * FROM users WHERE username = ?', [username]);

// ❌ INSEGURO — No se hace esto
await pool.execute(`SELECT * FROM users WHERE username = '${username}'`);
```

Los `?` en las consultas son reemplazados por `mysql2` de forma segura, escapando cualquier intento de inyección SQL.

### 10.7 Control de Acceso Granular

Ciertos endpoints tienen restricciones adicionales por rol:
- Ajustar inventario: Solo `Administrador General` o `Supervisor de Stock`
- Crear/editar/eliminar productos: Solo `Administrador General`
- Ver inventario: `Administrador General`, `Supervisor de Stock`, `Encargado de Ventas`

### 10.8 Soft Delete en lugar de DELETE físico

Productos, insumos y proveedores se "eliminan" cambiando `is_active = 0`, no con `DELETE`. Esto previene:
- Pérdida de integridad referencial (órdenes que referencian productos "eliminados")
- Pérdida involuntaria de datos

---

## 11. DESPLIEGUE Y ENTORNO DE PRODUCCIÓN

### 11.1 Infraestructura

| Aspecto | Valor |
|---------|-------|
| Proveedor de nube | DigitalOcean |
| Tipo de instancia | Droplet (VPS) |
| Sistema operativo | Ubuntu 22.04 LTS |
| IP pública | 165.227.76.44 |
| Región | Disponible |
| Usuario del servidor | `panasoft` |
| Directorio del proyecto | `/home/panasoft/Pansoft-Final-Mysql` |

### 11.2 Proceso de Despliegue

**Herramientas requeridas en el servidor:**
- Docker Engine
- Docker Compose
- Git

**Pasos de despliegue inicial:**
```bash
# 1. Clonar el repositorio en el servidor
git clone <url_repositorio> /home/panasoft/Pansoft-Final-Mysql

# 2. Ubicarse en el directorio
cd /home/panasoft/Pansoft-Final-Mysql

# 3. Construir y levantar los contenedores en modo producción
sudo docker-compose -f docker-compose.production.yml up -d --build
```

**Proceso de actualización (deploy de nueva versión):**
```bash
# Desde el equipo de desarrollo:
git push origin master

# En el servidor (o automatizado via SSH):
ssh panasoft@165.227.76.44 'cd /home/panasoft/Pansoft-Final-Mysql && git pull && sudo docker-compose -f docker-compose.production.yml up -d --build'
```

### 11.3 Dockerfile del Backend

El backend usa un Dockerfile multi-etapa simplificado:

```dockerfile
FROM node:18-alpine          # Imagen base ligera
WORKDIR /app
COPY package*.json ./
RUN npm install --production # Solo dependencias de producción
COPY . .
EXPOSE 5000
CMD ["node", "server.js"]   # Sin nodemon en producción
```

### 11.4 Dockerfile del Frontend (Producción)

El frontend usa un **build multi-etapa** (multi-stage build):

```dockerfile
# ETAPA 1: Compilar React
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build            # Genera dist/ con archivos estáticos

# ETAPA 2: Servir con Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**¿Por qué multi-stage build?** La imagen final solo contiene Nginx y los archivos compilados. El código fuente de React, Node.js y todas las devDependencies no están en la imagen final. Resultado: imagen ~20MB vs ~500MB si se incluyera Node.js.

### 11.5 Configuración de Nginx (nginx.conf)

```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
        # ↑ Crítico: redirige todas las rutas a index.html
        # para que React Router maneje el enrutamiento del lado del cliente
    }

    location /api {
        proxy_pass http://backend:5000;
        # ↑ Redirige llamadas /api al contenedor backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### 11.6 Red Docker en Producción

Todos los contenedores están en la red `pansoft_net` (tipo bridge). La comunicación interna usa los nombres de servicio como hostname (`backend`, `db`, `frontend`) sin exponer puertos al exterior innecesariamente.

```
Internet → Puerto 80 → pansoft_frontend (Nginx)
                             └── /api → pansoft_backend:5000
                                              └── pansoft_db:3306

phpMyAdmin → Puerto 8082 (solo para administración)
```

### 11.7 Persistencia de Datos

- **Base de datos:** Volumen Docker `db_data` montado en `/var/lib/mysql`. Los datos persisten aunque el contenedor se reinicie o reconstruya.
- **Imágenes subidas:** Volumen bind-mount `./backend/uploads` → `/app/uploads`. Las imágenes subidas por usuarios persisten en el servidor.

### 11.8 Diferencias Desarrollo vs Producción

| Aspecto | Desarrollo | Producción |
|---------|-----------|-----------|
| Frontend | `Vite dev server :3000` | `Nginx :80` |
| Hot Reload | ✅ Sí | ❌ No |
| Volumes de código | ✅ (código editado en vivo) | ❌ (código copiado en build) |
| `NODE_ENV` | `development` | `production` |
| Healthcheck BD | Simple | Completo (10 reintentos) |
| `depends_on` BD | `depends_on: db` | `condition: service_healthy` |

---

## 12. API REST — DOCUMENTACIÓN DE ENDPOINTS

### Convenciones de la API

**URL base:** `http://servidor:5000/api`

**Headers requeridos:**
```
Content-Type: application/json
Authorization: Bearer <jwt_token>  (en todos los endpoints protegidos)
```

**Formato de respuesta exitosa:**
```json
{ "data": [...], "message": "Operación exitosa" }
```

**Formato de respuesta de error:**
```json
{ "error": "Descripción del error", "message": "Mensaje para el usuario" }
```

---

### 12.1 Autenticación `/api/auth`

| Método | Endpoint | Auth | Descripción |
|--------|----------|------|------------|
| `POST` | `/login` | ❌ | Login → retorna JWT + usuario |
| `POST` | `/register` | ❌ | Registrar nuevo usuario |
| `GET` | `/user/permissions` | ✅ JWT | Obtener permisos del usuario actual |
| `POST` | `/change-password` | ✅ JWT | Cambiar contraseña |
| `POST` | `/forgot-password` | ❌ | Solicitar recuperación vía email |
| `POST` | `/reset-password` | ❌ | Establecer nueva contraseña con token |

**Ejemplo — Login:**
```json
// POST /api/auth/login
// Body:
{ "username": "admin", "password": "123456" }

// Respuesta 200:
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": 1,
    "username": "admin",
    "role": "Administrador General",
    "mustChangePassword": false
  }
}
```

---

### 12.2 Productos `/api/products`

| Método | Endpoint | Rol requerido | Descripción |
|--------|----------|--------------|------------|
| `GET` | `/` | Cualquiera | Listar todos los productos |
| `GET` | `/:id` | Cualquiera | Obtener producto por ID |
| `POST` | `/` | Administrador General | Crear nuevo producto |
| `PUT` | `/:id` | Administrador General | Actualizar producto |
| `DELETE` | `/:id` | Administrador General | Soft-delete (is_active=false) |
| `PATCH` | `/:id/toggle-status` | Administrador General | Activar/desactivar |

---

### 12.3 Insumos `/api/supplies`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/` | Listar todos los insumos |
| `GET` | `/:id` | Insumo por ID |
| `POST` | `/` | Crear insumo |
| `PUT` | `/:id` | Actualizar insumo (registra movimiento de stock) |
| `DELETE` | `/:id` | Soft-delete |
| `PATCH` | `/:id/toggle-status` | Activar/desactivar |
| `GET` | `/history/all/movements` | Historial de movimientos paginado |
| `GET` | `/history/:supplyId` | Historial de un insumo específico |

---

### 12.4 Inventario `/api/inventory`

| Método | Endpoint | Rol requerido | Descripción |
|--------|----------|--------------|------------|
| `GET` | `/` | Admin/Supervisor/Ventas | Listar inventario |
| `GET` | `/:productId` | Cualquiera | Inventario de un producto |
| `PUT` | `/:productId` | Admin/Supervisor Stock | Ajustar stock (crea movimiento) |
| `GET` | `/history/all/movements` | Cualquiera | Historial de movimientos |
| `GET` | `/history/:productId` | Cualquiera | Historial por producto |
| `DELETE` | `/history/clear/all` | Admin General | Limpiar historial |

---

### 12.5 Órdenes de Venta `/api/sales-orders`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/` | Listar todas las órdenes |
| `GET` | `/:id` | Detalle completo (encabezado + ítems + insumos) |
| `POST` | `/` | Crear orden con ítems (transacción atómica) |
| `PUT` | `/:id` | Actualizar encabezado de orden |
| `PATCH` | `/:id/status` | Cambiar estado |
| `DELETE` | `/:id` | Eliminar orden y ítems en cascada |

---

### 12.6 Órdenes de Producción `/api/production-orders`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/` | Listar todas con producto y empleado |
| `GET` | `/:id` | Detalle con lista de insumos |
| `POST` | `/` | Crear orden de producción (transacción) |
| `PUT` | `/:id` | Actualizar campos |
| `PATCH` | `/:id/status` | Cambiar solo el estado |
| `DELETE` | `/:id` | Eliminar con cascade en insumos |

---

### 12.7 Dashboard `/api/dashboard`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/stats` | 4 KPIs: ventas, productos, mejor vendido, pedidos |
| `GET` | `/charts` | Datos de 12 meses para gráfica de ventas |
| `GET` | `/alerts` | Top 5 alertas de stock |
| `GET` | `/activity` | Feed de actividad reciente |

---

### 12.8 Notificaciones `/api/notifications`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/` | Listar con paginación (limit, offset, unreadOnly) |
| `GET` | `/unread/count` | Contar no leídas |
| `GET` | `/by-type/:type` | Filtrar por tipo |
| `PATCH` | `/:id/read` | Marcar una como leída |
| `PATCH` | `/read/all` | Marcar todas como leídas |
| `DELETE` | `/:id` | Eliminar una |
| `DELETE` | `/read/all` | Limpiar todas las leídas |

---

### 12.9 Reportes `/api/reports`

| Método | Endpoint | Parámetros Query | Descripción |
|--------|----------|-----------------|------------|
| `GET` | `/sales` | `startDate`, `endDate` | Reporte de ventas |
| `GET` | `/inventory` | - | Valor de inventario |
| `GET` | `/customers` | - | Clientes con totales |
| `GET` | `/production-orders` | - | Órdenes de producción |
| `GET` | `/sales-orders` | `status`, `startDate`, `endDate` | Pedidos de venta |
| `GET` | `/products` | - | Catálogo con nivel de stock |
| `GET` | `/employees` | - | Empleados con conteo de órdenes |

---

### 12.10 Endpoints de Verificación de Expiración `/api/expiry`

| Método | Endpoint | Descripción |
|--------|----------|------------|
| `GET` | `/summary` | Resumen de productos/insumos vencidos o próximos |
| `POST` | `/check` | Disparar verificación manual de vencimientos |

---

## 13. INTERFAZ DE USUARIO

### 13.1 Paleta de Colores y Diseño

- **Color primario:** `#EBB583` (naranja pan/trigo) — usado en hero del login, botones primarios
- **Color secundario:** `#EBCC83` (dorado) — degradado del login
- **Color de acento:** Bootstrap primary blue para botones de acción
- **Tipografía:** Bootstrap default (system fonts)
- **Iconografía:** Lucide React (iconos SVG modernos)

### 13.2 Responsive Design

El sidebar se colapsa automáticamente en pantallas menores a 768px (tablets/móviles). Los componentes usan el sistema de grillas de Bootstrap (`col-md-*`, `col-lg-*`) para adaptarse.

### 13.3 Componentes de UI Reutilizables

| Componente | Función |
|-----------|---------|
| `ChangePasswordModal` | Modal de pantalla completa para cambio obligatorio de contraseña |
| `ForgotPasswordModal` | Modal para recuperación de contraseña por email |
| `CredentialsModal` | Modal de solo lectura para mostrar credenciales de empleado nuevo |
| `SuppliesSection` | Tabla/grid reutilizable para insumos |
| `ProductsSection` | Tabla/grid reutilizable para productos |

### 13.4 Gestión de Estado

- **Estado local:** `useState` para datos de formularios, loading states, modales
- **Efectos:** `useEffect` para cargar datos al montar componentes y para el polling de notificaciones
- **Estado global:** Context API (`PermissionsProvider`) para permisos del usuario
- **Persistencia de sesión:** localStorage (token JWT, datos de usuario)

### 13.5 Manejo de Errores en el Frontend

- Las llamadas a la API muestran toasts de error usando **Sonner** (`toast.error()`)
- Los errores de autenticación (401) en Axios redirigen automáticamente al login (el token expiró)
- Los formularios validan en el frontend antes de enviar (campos requeridos, longitudes)

---

## 14. PRUEBAS Y VALIDACIÓN

### 14.1 Pruebas Funcionales por Módulo

Para cada módulo se verificó:

| Módulo | Pruebas realizadas |
|--------|-------------------|
| Autenticación | Login válido/inválido, cambio de contraseña, reset por email, expiración de JWT |
| Productos | CRUD completo, validación SKU duplicado, toggle status, subida de imagen |
| Inventario | Ajuste de stock, registro en historial de movimientos, alertas de stock mínimo |
| Órdenes de venta | Creación con ítems, cambio de estado, vista detalle, eliminación en cascada |
| Órdenes de producción | Creación con insumos, actualización de estado |
| Notificaciones | Generación automática, marcar leída, contador en sidebar |
| Reportes | Filtros por fecha, todos los endpoints de reporte |
| Docker | Inicio con `docker-compose up`, healthcheck, persistencia de datos |

### 14.2 Validaciones Implementadas en el Backend

| Validación | Endpoint | Código de error |
|-----------|---------|----------------|
| Campos requeridos faltantes | POST a cualquier módulo | 400 |
| SKU duplicado | POST/PUT /products | 400 |
| Email ya registrado | POST /auth/register | 400 |
| Contraseña < 6 caracteres | POST /auth/register | 400 |
| Token JWT inválido/expirado | Todos los protegidos | 401 |
| Rol insuficiente | Endpoints con checkRole | 403 |
| Recurso no encontrado | GET /:id | 404 |
| Error de base de datos | Cualquiera | 500 |
| Token de reset inválido/expirado | POST /reset-password | 400 |

### 14.3 Health Check

El endpoint `GET /api/health` retorna `{ status: "OK" }` y es usado por Docker Compose para verificar que el backend está listo antes de que el frontend empiece a enviar tráfico.

---

## 15. RESULTADOS Y CONCLUSIONES

### 15.1 Logros del Proyecto

1. **Sistema completamente funcional** con 14 módulos integrados, cubriendo el 100% de los procesos operativos identificados en el análisis de requisitos.

2. **Seguridad implementada correctamente:** JWT, bcrypt, tokens seguros para recuperación, consultas parametrizadas (prevención SQL injection), control de acceso RBAC.

3. **Despliegue en producción exitoso** en un servidor en la nube (DigitalOcean) con Docker Compose, accesible públicamente en el puerto 80.

4. **Automatización de alertas:** El sistema detecta y notifica automáticamente situaciones críticas (stock bajo, vencimientos) sin intervención humana.

5. **Arquitectura escalable:** La separación en microservicios (frontend, backend, BD como contenedores independientes) permite escalar cada componente independientemente.

### 15.2 Limitaciones Identificadas

1. **Configuración de CORS permisiva:** En producción se debería restringir los orígenes permitidos.
2. **Módulo de Configuración:** La interfaz de configuración está implementada en el frontend pero no persiste en base de datos.
3. **Facturación:** El punto de venta genera la interfaz y número de factura, pero la integración directa con la persitencia en BD requiere completar el flujo de guardado.
4. **Sin HTTPS:** La aplicación está en HTTP; en producción real se debería agregar certificado SSL (Let's Encrypt con Certbot o Cloudflare).
5. **Render.yaml desactualizado:** El archivo `render.yaml` hace referencia a PostgreSQL en lugar de MySQL, lo que indica que hubo un cambio de BD durante el desarrollo.

### 15.3 Conclusiones

- La combinación **React + Node.js + MySQL + Docker** demostró ser una stack tecnológica robusta, moderna y adecuada para sistemas de gestión empresarial de mediana complejidad.
- El uso de **Docker Compose** redujo significativamente el tiempo de configuración del entorno y eliminó problemas de "funciona en mi máquina".
- La implementación de **RBAC con permisos granulares** garantiza que cada rol solo pueda realizar las acciones que le corresponden, reduciendo el riesgo de errores operacionales.
- El sistema de **notificaciones automáticas** con tareas programadas agrega valor real al negocio al reducir la dependencia del monitoreo manual.

### 15.4 Trabajo Futuro

1. Implementar HTTPS con certificado SSL
2. Completar la persistencia del módulo de Configuración
3. Agregar autenticación de dos factores (2FA)
4. Implementar exportación de reportes a PDF/Excel
5. Agregar pruebas unitarias y de integración automatizadas (Jest, Supertest)
6. Implementar PWA (Progressive Web App) para uso en móviles sin conexión
7. Agregar logs de auditoría completos (quién hizo qué y cuándo)

---

## 16. GLOSARIO TÉCNICO

> *Aprende estas definiciones. El jurado puede preguntar cualquiera de ellas.*

| Término | Definición |
|---------|-----------|
| **API** | Application Programming Interface. Interfaz que permite a dos sistemas comunicarse. En Pansoft, es el conjunto de endpoints HTTP que el frontend usa para comunicarse con el backend. |
| **REST** | Representational State Transfer. Estilo arquitectónico para APIs que usa HTTP, URLs como recursos y verbos HTTP (GET, POST, PUT, DELETE) para operaciones. |
| **JWT** | JSON Web Token. Estándar para transmitir información firmada digitalmente entre sistemas. Se usa para autenticación stateless. |
| **bcrypt** | Algoritmo de hashing de contraseñas diseñado para ser computacionalmente costoso, dificultando ataques de fuerza bruta. |
| **SPA** | Single Page Application. Aplicación web que carga una sola pagina HTML y dinamicamente actualiza contenido sin recargar la pagina. |
| **Middleware** | Función que se ejecuta entre la solicitud HTTP y el controlador final. Permite modularizar lógica transversal (autenticación, logging, validación). |
| **RBAC** | Role-Based Access Control. Modelo de control de acceso donde los permisos se asignan a roles, y los usuarios tienen roles. |
| **Docker** | Plataforma de contenerización que empaqueta aplicaciones con todas sus dependencias en contenedores aislados y portables. |
| **Nginx** | Servidor web y proxy reverso de alto rendimiento. En Pansoft sirve el build estático de React en producción. |
| **ORM** | Object-Relational Mapper. Herramienta que mapea tablas de BD a objetos. En Pansoft se usa SQL directo con mysql2 (sin ORM). |
| **Pool de conexiones** | Conjunto de conexiones de BD mantenidas abiertas y reutilizadas entre solicitudes para evitar el overhead de abrir/cerrar conexiones constantemente. |
| **Soft delete** | Técnica de "eliminación lógica" donde se marca un registro como inactivo (`is_active=0`) en lugar de borrarlo físicamente. Preserva historial e integridad referencial. |
| **Salt** | Valor aleatorio añadido a una contraseña antes de hashear. Evita que dos contraseñas iguales generen el mismo hash y previene ataques rainbow table. |
| **CORS** | Cross-Origin Resource Sharing. Mecanismo de seguridad del navegador que controla qué dominios pueden hacer solicitudes a una API. |
| **Proxy reverso** | Servidor que recibe solicitudes en nombre del cliente y las direcciona al servidor correcto. Nginx actúa como proxy reverso hacia el backend de Node.js. |
| **Contenedor Docker** | Unidad de software que empaqueta código, runtime y dependencias en un entorno aislado. Más liviano que una VM porque comparte el kernel del SO host. |
| **Volumen Docker** | Mecanismo para persistir datos generados por contenedores fuera del ciclo de vida del contenedor. |
| **Normalización** | Proceso de organizar tablas relacionales para reducir redundancia y mejorar integridad. Las tres primeras formas normales (1FN, 2FN, 3FN) son el estándar base. |
| **Transacción** | Secuencia de operaciones de BD que se ejecutan como unidad atómica: o todas tienen éxito (COMMIT) o todas se deshacen (ROLLBACK). |
| **Hook (React)** | Funciones especiales de React (`useState`, `useEffect`, etc.) que permiten añadir estado y efectos secundarios a componentes funcionales. |
| **Vite** | Herramienta de construcción frontend de nueva generación. Usa ES Modules nativos durante desarrollo para HMR instantáneo, y Rollup para builds de producción optimizados. |
| **ESM** | ES Modules. Sistema de módulos estándar de JavaScript (import/export). El backend de Pansoft usa ESM nativo con `"type": "module"` en package.json. |
| **Multi-stage build** | Técnica Docker donde se usan múltiples etapas en un Dockerfile: una para compilar/construir y otra liviana para ejecutar en producción. |
| **Idempotente** | Operación que puede ejecutarse múltiples veces sin producir efectos diferentes. Las migraciones SQL de Pansoft usan `IF NOT EXISTS` para ser idempotentes. |
| **Async/Await** | Sintaxis JavaScript para manejar operaciones asíncronas (como consultas a BD o llamadas HTTP) de forma readable, sin callbacks anidados. |
| **DECIMAL(10,2)** | Tipo de dato MySQL para números de punto fijo con hasta 10 dígitos totales y 2 decimales. Se usa para precios y montos para evitar errores de punto flotante. |

---

## 17. PREGUNTAS FRECUENTES DEL JURADO Y RESPUESTAS SUGERIDAS

> *Estas son las preguntas más comunes en defensa de proyectos. Estudia las respuestas y practica explicarlas con tus propias palabras.*

---

**P: ¿Por qué eligieron React y no otro framework como Angular o Vue?**

R: Elegimos React porque es la biblioteca más demandada en la industria actualmente, tiene una comunidad enorme con mucha documentación y librerías disponibles. React nos permitió construir componentes reutilizables — por ejemplo, el componente `ProductsSection` y `SuppliesSection` tienen la misma estructura y los reutilizamos en el módulo de productos y en el de inventario. Además, su Context API nos facilitó implementar el sistema de permisos de forma global sin pasar props por toda la jerarquía de componentes.

---

**P: ¿Por qué MySQL y no PostgreSQL o MongoDB?**

R: MySQL 8.0 fue elegido por varias razones: la naturaleza del problema (panadería) tiene datos claramente relacionales — un pedido tiene ítems, los ítems tienen productos, los productos tienen proveedores. Una base de datos relacional es la herramienta correcta. MySQL es ampliamente usado en la industria, tiene excelente soporte en Docker y es consistente con los conocimientos del equipo. MongoDB habría sido más apropiado si tuviéramos datos no estructurados o necesitáramos escala horizontal masiva, lo que no es el caso.

---

**P: ¿Qué es JWT y por qué lo usan para autenticación?**

R: JWT (JSON Web Token) es un estándar para transmitir información de identidad de forma segura entre el cliente y el servidor. Lo elegimos sobre el manejo de sesiones en servidor porque es **stateless**: el servidor no necesita guardar el estado de sesión, lo que facilita el escalado horizontal (múltiples instancias del backend). El token contiene el userId, username y rol del usuario, firmado con una clave secreta (JWT_SECRET). Si alguien modifica el token, la firma no coincide y el servidor lo rechaza.

---

**P: ¿Cómo funciona Docker en su proyecto?**

R: Docker nos permite "empaquetar" cada parte del sistema (frontend, backend, base de datos) en contenedores aislados que incluyen todas sus dependencias. Cuando ejecutamos `docker-compose up`, se crean automáticamente 4 contenedores que se comunican entre sí en una red privada virtual. La ventaja es que no hay que instalar Node.js, MySQL, o Nginx en el servidor — Docker lo maneja todo. Además, el entorno de desarrollo y producción son idénticos, eliminando problemas de configuración.

---

**P: ¿Cómo garantizan la seguridad de las contraseñas?**

R: Las contraseñas nunca se almacenan en texto plano. Usamos bcrypt con 10 salt rounds, que agrega un valor aleatorio único a cada contraseña antes de hashear. bcrypt fue diseñado intencionalmente para ser lento (~100ms por hash), lo que hace inviable un ataque de fuerza bruta. Para verificar, usamos `bcrypt.compare()` que nunca "desencripta" — compara el hash del intento con el hash guardado. Adicionalmente, en la recuperación de contraseña, guardamos el hash SHA-256 del token, no el token en claro.

---

**P: ¿Qué es una API REST y cómo la usaron?**

R: REST es un estilo arquitectónico para APIs web que usa el protocolo HTTP de forma semántica: GET para leer, POST para crear, PUT para actualizar, DELETE para eliminar. Cada recurso tiene una URL única (ej: `/api/products/5` es el producto con ID 5). Nuestra API tiene 14 módulos y más de 60 endpoints. El frontend usa Axios para hacer las solicitudes HTTP incluyendo el JWT en el header de Authorization para autenticarse. El backend responde siempre en formato JSON.

---

**P: ¿Cómo funciona el sistema de notificaciones automáticas?**

R: Al iniciar el servidor, creamos tareas programadas con `setInterval`. Cada 30 minutos se ejecutan funciones que consultan la base de datos buscando productos e insumos con stock igual o menor al mínimo definido, y crean registros en la tabla `notifications`. Cada 6 horas se revisan las fechas de vencimiento de productos e insumos. En el frontend, hay un polling (consulta periódica) cada 10 segundos al endpoint `/api/notifications/unread/count` que actualiza el badge del menú con el número de notificaciones sin leer.

---

**P: ¿Qué es el soft delete y por qué lo implementaron?**

R: El soft delete es eliminar lógicamente un registro cambiando un campo `is_active = 0` en lugar de borrar físicamente el registro de la base de datos. Lo usamos en productos, insumos y proveedores porque si una orden de producción referencia un producto, y borramos el producto físicamente, la orden quedaría con una referencia rota (integridad referencial). Con soft delete, el producto "desaparece" de los listados activos pero sigue existiendo en la BD y las órdenes antiguas siguen teniendo sentido. Además preservamos el historial del negocio.

---

**P: ¿Por qué usan Nginx si Node.js puede servir archivos estáticos?**

R: Técnicamente Node.js puede servir archivos estáticos, pero Nginx es un servidor web especializado y es hasta 10 veces más eficiente para esta tarea. Nginx maneja múltiples solicitudes concurrentes con muy poca memoria usando un modelo asíncrono basado en eventos. En producción, usamos un build multi-stage donde primero compilamos React con Vite (generando archivos HTML/CSS/JS optimizados) y luego Nginx los sirve. El Nginx también actúa como proxy reverso para la API.

---

**P: ¿Qué son las transacciones de base de datos y dónde las usan?**

R: Una transacción es un conjunto de operaciones que se ejecutan como una unidad atómica: todas tienen éxito o todas se deshacen. En Pansoft las usamos al crear órdenes de venta y de producción. Por ejemplo, al crear una orden de producción, necesitamos: insertar en `production_orders` y luego insertar múltiples registros en `production_order_insumos`. Si la inserción de insumos falla (por un error de validación), hacemos ROLLBACK y la orden también se deshace. Sin transacciones, podría quedar una orden sin insumos — un estado inconsistente.

---

**P: ¿Qué es la normalización de base de datos y cómo la aplicaron?**

R: La normalización es el proceso de organizar las tablas para reducir redundancia y dependencias anómalas. Aplicamos las tres primeras formas normales. Por ejemplo, en una factura no guardamos el nombre del cliente directamente — guardamos el `customer_id` (FK) y al necesitar el nombre hacemos un JOIN. Esto significa que si el cliente cambia su nombre, solo se actualiza en un lugar. La única excepción deliberada es `sales_orders.customer_name`, donde desnormalizamos para agilizar lecturas frecuentes sin JOIN.

---

**P: ¿Cómo manejan los errores en el backend?**

R: Tenemos dos niveles. Primero, validaciones específicas de negocio: por ejemplo, verificamos que el SKU de un producto sea único antes de insertarlo, y respondemos 400 con un mensaje claro si ya existe. Segundo, un catch general en cada controlador que captura errores inesperados y responde 500 con el mensaje de error (en desarrollo se incluye el stack trace, en producción se suprime). Adicionalmente, las consultas a la BD se ejecutan con manejo de errores para detectar violaciones de constraints, tablas inexistentes, etc.

---

**P: ¿Cómo funciona el control de permisos en el frontend?**

R: Usamos el Context API de React. Al hacer login, el frontend consulta `/api/auth/user/permissions` que retorna todos los permisos estructurados por módulo (inventory.read, inventory.write, billing.read, etc.). Estos permisos se almacenan en el `PermissionsContext`. Los componentes consumen este contexto con `useContext(PermissionsContext)` para mostrar u ocultar botones y opciones según los permisos del usuario. Esto es UI/UX — el control real está en el backend, que también verifica el rol en cada solicitud. La UI solo mejora la experiencia.

---

*Fin del documento — Pansoft, Sistema de Gestión para Panaderías*
*Proyecto de Grado — Ingeniería de Sistemas*
*© 2026*
