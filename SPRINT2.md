# Sprint 2 — InmobiliariaApp
**Fecha:** 07/03/2026 – 13/03/2026  
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
Implementar los dashboards completos para los 4 roles del sistema y el CRUD completo de propiedades, permitiendo a la inmobiliaria gestionar su catálogo y al cliente buscar y agendar visitas.

### User Stories seleccionadas

| ID | Historia | Prioridad | Estimación | Estado |
|----|----------|-----------|------------|--------|
| US-06 | Como administrador, quiero ver y gestionar todos los usuarios del sistema | Media | 1 día | ✅ Hecho |
| US-07 | Como inmobiliaria, quiero agregar, editar y eliminar propiedades | Alta | 2 días | ✅ Hecho |
| US-08 | Como cliente, quiero ver mis citas y buscar propiedades desde mi dashboard | Media | 1 día | ✅ Hecho |
| US-09 | Como usuario básico, quiero ver propiedades destacadas desde mi panel | Media | 0.5 días | ✅ Hecho |
| US-10 | Como cliente, quiero solicitar una cita para visitar una propiedad | Baja | 1 día | ✅ Hecho |
| US-11 | Como administrador, quiero activar/desactivar usuarios del sistema | Media | 0.5 días | ✅ Hecho |

### Criterios de Aceptación (Definition of Done)

**US-06 — Dashboard Admin:**
- [x] Tabla con todos los usuarios del sistema
- [x] Muestra nombre, email, rol y estado
- [x] Botón para activar/desactivar usuarios
- [x] Cards con estadísticas (total usuarios, propiedades, activos, disponibles)
- [x] Vista resumen de todas las propiedades

**US-07 — CRUD Propiedades:**
- [x] Formulario agregar propiedad con todos los campos
- [x] Validación de campos obligatorios
- [x] Formulario editar propiedad con datos precargados
- [x] Botón eliminar con confirmación
- [x] Redirección con mensajes de éxito/error
- [x] Solo el rol inmobiliaria puede acceder

**US-08 — Dashboard Cliente:**
- [x] Buscador de propiedades con filtros integrado
- [x] Lista de propiedades recientes
- [x] Sección "Mis citas" con estado de cada una
- [x] Cards con estadísticas propias
- [x] Botón para buscar propiedad y agendar

**US-10 — Solicitar cita:**
- [x] Formulario con fecha/hora y mensaje
- [x] Muestra info de la propiedad seleccionada
- [x] Guarda cita en BD con estado "pendiente"
- [x] Mensaje de confirmación al cliente

---

## Product Backlog actualizado

| ID | Historia | Prioridad | Sprint |
|----|----------|-----------|--------|
| US-01 | Landing page con búsqueda | Alta | Sprint 1 ✅ |
| US-02 | Registro de usuarios | Alta | Sprint 1 ✅ |
| US-03 | Login con roles | Alta | Sprint 1 ✅ |
| US-04 | Base de datos | Alta | Sprint 1 ✅ |
| US-05 | Listado propiedades con filtros | Alta | Sprint 1 ✅ |
| US-06 | Dashboard admin | Media | Sprint 2 ✅ |
| US-07 | CRUD propiedades | Alta | Sprint 2 ✅ |
| US-08 | Dashboard cliente | Media | Sprint 2 ✅ |
| US-09 | Dashboard usuario | Media | Sprint 2 ✅ |
| US-10 | Solicitar cita | Baja | Sprint 2 ✅ |
| US-11 | Toggle activo usuarios | Media | Sprint 2 ✅ |
| US-12 | Reportes admin e inmobiliaria | Media | Sprint 3 |
| US-13 | Base de datos online | Media | Sprint 3 |
| US-14 | Testing unitario JUnit | Media | Sprint 3 |
| US-15 | Documentación y diagramas | Media | Sprint 3 |
| US-16 | Subida de imágenes | Baja | Sprint 3 |

---

## Sprint Review — Sprint 2

### Funcionalidades demostradas
1. **Dashboard Admin** — tabla de usuarios con toggle activo/inactivo, resumen de propiedades
2. **Dashboard Inmobiliaria** — CRUD completo: agregar, editar, eliminar propiedades con confirmación
3. **Dashboard Cliente** — buscador integrado, lista de propiedades, mis citas
4. **Dashboard Usuario** — panel básico con propiedades destacadas
5. **Solicitar cita** — formulario con fecha/hora, confirmación y visualización en dashboard

### Velocidad del Sprint
- User Stories completadas: **6 / 6**
- Puntos de historia completados: **6 / 6**

---

## Sprint Retrospective — Sprint 2

### ¿Qué salió bien?
- El patrón DAO + Servlet + JSP funcionó perfectamente para el CRUD
- Bootstrap 5 permitió construir tablas y formularios responsivos rápidamente
- La separación por roles en carpetas facilita el mantenimiento y seguridad
- El AuthFilter protege automáticamente todas las rutas por rol

### ¿Qué mejorar?
- Agregar validaciones más robustas en el frontend con JavaScript
- Implementar paginación para las tablas con muchos registros
- Mejorar los mensajes de error con más detalle

### Acciones para Sprint 3
- [ ] Implementar reportes con gráficas
- [ ] Conectar BD online en Railway
- [ ] Escribir pruebas unitarias JUnit
- [ ] Crear documentación técnica y diagramas

---

## Herramientas utilizadas
- **Versionado:** Git + GitHub
- **Tablero:** Trello
- **IDE:** VS Code con Extension Pack for Java
- **Build:** Maven 3.9.14
- **Servidor:** Apache Tomcat 8.5.96 (XAMPP)
- **BD:** MySQL 8 (XAMPP) + Workbench
