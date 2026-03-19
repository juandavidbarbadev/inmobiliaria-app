# Sprint 1 — InmobiliariaApp
**Fecha:** 27/02/2026 – 06/03/2026  
**Duración:** 7 días  
**Proyecto:** Sistema de administración inmobiliaria — UTS  
**Asignatura:** Programación Java  
**Docente:** Julian Barney Jaimes Rincón  

---

## Roles Scrum simulados

| Rol | Responsable |
|-----|-------------|
| Product Owner | [Tu nombre] |
| Scrum Master  | [Tu nombre] |
| Dev Team      | [Tu nombre] |

---

## Sprint Planning

### Objetivo del Sprint
Establecer la base funcional del proyecto: estructura Maven, base de datos, sistema de autenticación con roles y landing page profesional.

### User Stories seleccionadas para este Sprint

| ID | Historia | Prioridad | Estimación | Estado |
|----|----------|-----------|------------|--------|
| US-01 | Como visitante, quiero una landing page atractiva con búsqueda rápida de propiedades | Alta | 3 días | ✅ Hecho |
| US-02 | Como usuario, quiero registrarme con nombre, email y contraseña para acceder a la plataforma | Alta | 1 día | ✅ Hecho |
| US-03 | Como usuario registrado, quiero iniciar sesión y ser redirigido según mi rol | Alta | 1 día | ✅ Hecho |
| US-04 | Como desarrollador, necesito la base de datos con las tablas principales (usuarios, propiedades, citas, solicitudes) | Alta | 1 día | ✅ Hecho |
| US-05 | Como visitante, quiero ver el listado de propiedades con filtros básicos | Alta | 1 día | ✅ Hecho |

### Criterios de Aceptación (Definition of Done)

**US-01 — Landing Page:**
- [x] Página principal visible en `http://localhost:8080/inmobiliaria/`
- [x] Sección hero con título y subtítulo
- [x] Buscador de propiedades funcional (ciudad, tipo, operación)
- [x] Sección de propiedades destacadas cargadas desde BD
- [x] Sección de features y CTA
- [x] Navbar con links a login/registro
- [x] Footer con información de contacto
- [x] Diseño responsivo con Bootstrap 5

**US-02 — Registro:**
- [x] Formulario con nombre, apellido, email, teléfono, contraseña
- [x] Validación de campos obligatorios
- [x] Verificación de contraseñas coincidan
- [x] Email único (no duplicados)
- [x] Contraseña encriptada con BCrypt
- [x] Selección de rol: usuario o cliente
- [x] Mensaje de éxito al registrar

**US-03 — Login:**
- [x] Formulario email + contraseña
- [x] Verificación BCrypt contra BD
- [x] Creación de sesión con datos del usuario
- [x] Redirección al dashboard según rol
- [x] Mensaje de error en credenciales incorrectas
- [x] Logout que invalida la sesión

**US-04 — Base de datos:**
- [x] Script SQL ejecutable en MySQL
- [x] Tablas: roles, usuarios, propiedades, citas, solicitudes
- [x] Datos de prueba insertados (admin + inmobiliaria + 4 propiedades)
- [x] Clase DBConnection.java con soporte local y online
- [x] Driver MySQL cargado vía Maven (JDBC)

**US-05 — Listado de propiedades:**
- [x] Página propiedades.jsp con listado desde BD
- [x] Filtros por ciudad, tipo, operación y precio máximo
- [x] Cards con imagen placeholder, precio, características
- [x] Página de detalle individual de propiedad
- [x] Mensaje cuando no hay resultados

---

## Product Backlog completo

| ID | Historia | Prioridad | Sprint |
|----|----------|-----------|--------|
| US-01 | Landing page con búsqueda | Alta | Sprint 1 ✅ |
| US-02 | Registro de usuarios | Alta | Sprint 1 ✅ |
| US-03 | Login con roles | Alta | Sprint 1 ✅ |
| US-04 | Base de datos | Alta | Sprint 1 ✅ |
| US-05 | Listado propiedades con filtros | Alta | Sprint 1 ✅ |
| US-06 | Dashboard admin (gestión usuarios) | Media | Sprint 2 |
| US-07 | Dashboard inmobiliaria (CRUD propiedades) | Alta | Sprint 2 |
| US-08 | Dashboard cliente (buscar, perfil) | Media | Sprint 2 |
| US-09 | Dashboard usuario básico | Media | Sprint 2 |
| US-10 | Solicitar cita para visitar propiedad | Baja | Sprint 2 |
| US-11 | Formulario agregar/editar propiedad | Alta | Sprint 2 |
| US-12 | Envío de solicitud de compra/arriendo | Media | Sprint 2 |
| US-13 | Reportes básicos (propiedades disponibles) | Media | Sprint 3 |
| US-14 | Integración base de datos online (Railway) | Media | Sprint 3 |
| US-15 | Testing unitario con JUnit | Media | Sprint 3 |
| US-16 | Documentación técnica y diagramas | Media | Sprint 3 |
| US-17 | Deploy online (plus) | Baja | Sprint 3 |

---

## Sprint Review — Sprint 1

### Funcionalidades demostradas
1. **Landing page** — Visible en `http://localhost:8080/inmobiliaria/`
2. **Registro** — Nuevo usuario creado y almacenado con contraseña BCrypt
3. **Login** — Autenticación exitosa y redirección por rol
4. **BD local** — Tablas creadas, datos de prueba visibles en Workbench
5. **Listado propiedades** — Filtros funcionando, cards con datos de BD
6. **Fragmentos JSPF** — header, navbar y footer reutilizables en todas las páginas

### Velocidad del Sprint
- User Stories completadas: **5 / 5**
- Puntos de historia completados: **7 / 7**

---

## Sprint Retrospective — Sprint 1

### ¿Qué salió bien?
- La estructura Maven facilita agregar dependencias sin copiar JARs manualmente
- El patrón DAO separa limpiamente la lógica de negocio del acceso a datos
- Bootstrap 5 + Google Fonts dan un diseño profesional con poco esfuerzo
- Los fragmentos JSPF eliminan duplicación de navbar y footer

### ¿Qué mejorar?
- Agregar validaciones del lado del cliente (JavaScript) en los formularios
- Implementar mensajes de validación más detallados campo por campo
- Preparar subida de imágenes reales para las propiedades en Sprint 2

### Acciones para Sprint 2
- [ ] Completar dashboards para los 4 roles
- [ ] Implementar CRUD completo de propiedades
- [ ] Agregar gestión de citas
- [ ] Mejorar validaciones frontend

---

## Herramientas utilizadas
- **Versionado:** Git + GitHub
- **Tablero:** Trello (columnas: Backlog / En progreso / En revisión / Hecho)
- **IDE:** VS Code con Extension Pack for Java
- **Build:** Maven 3.9.14
- **Servidor:** Apache Tomcat 8.5.96 (XAMPP)
- **BD:** MySQL 8 (XAMPP) + Workbench

