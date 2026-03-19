# Sprint 3 — InmobiliariaApp
**Fecha:** 14/03/2026 – 20/03/2026  
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
Completar el sistema con reportes funcionales, pruebas unitarias, base de datos online, documentación técnica completa y preparación para la sustentación final.

### User Stories seleccionadas

| ID | Historia | Prioridad | Estimación | Estado |
|----|----------|-----------|------------|--------|
| US-12 | Como admin/inmobiliaria, quiero ver reportes de propiedades y actividad | Media | 2 días | ✅ Hecho |
| US-13 | Como desarrollador, quiero conectar la BD a un servidor online | Media | 1 día | ✅ Hecho |
| US-14 | Como desarrollador, quiero pruebas unitarias JUnit para los DAOs | Media | 1 día | ✅ Hecho |
| US-15 | Como equipo, queremos documentación técnica completa con diagramas | Media | 2 días | ✅ Hecho |
| US-16 | Como inmobiliaria, quiero subir fotos a las propiedades | Baja | 1 día | ✅ Hecho |

### Criterios de Aceptación (Definition of Done)

**US-12 — Reportes:**
- [x] Reporte de propiedades disponibles filtrable
- [x] Reporte de propiedades por tipo y operación
- [x] Reporte de citas por estado
- [x] Accesible solo para admin e inmobiliaria

**US-13 — BD Online:**
- [x] Base de datos creada en Railway
- [x] DBConnection.java soporta cambio local/online
- [x] Script SQL ejecutado en servidor online
- [x] App funciona con BD online

**US-14 — Testing JUnit:**
- [x] TestUsuarioDAO — prueba registro y login
- [x] TestPropiedadDAO — prueba listar y buscar
- [x] TestCitaDAO — prueba insertar y listar
- [x] Todos los tests pasan (BUILD SUCCESS)

**US-15 — Documentación:**
- [x] Diagrama ER de la base de datos
- [x] Diagrama de clases Java
- [x] SPRINT1.md, SPRINT2.md, SPRINT3.md completos
- [x] README.md actualizado

---

## Sprint Review — Sprint 3

### Funcionalidades demostradas
1. **Reportes** — admin ve estadísticas globales, inmobiliaria ve sus propias métricas
2. **BD Online** — Railway conectado y funcionando
3. **JUnit** — 9 pruebas unitarias pasando correctamente
4. **Documentación** — 3 sprints documentados + diagramas

### Velocidad del Sprint
- User Stories completadas: **5 / 5**
- Puntos de historia completados: **7 / 7**

---

## Sprint Retrospective — Sprint 3

### ¿Qué salió bien?
- JUnit permitió detectar un bug en el UsuarioDAO durante las pruebas
- Railway fue fácil de configurar y gratis para desarrollo
- La documentación Scrum refleja fielmente el proceso iterativo seguido
- El proyecto quedó completamente funcional y desplegable

### ¿Qué mejorar en proyectos futuros?
- Implementar pruebas desde el Sprint 1 para detectar bugs antes
- Usar integración continua (CI/CD) con GitHub Actions
- Agregar más validaciones del lado del cliente con JavaScript
- Implementar un sistema de notificaciones por email

### Lecciones aprendidas
- El patrón MVC (Model-View-Controller) con JSP mantiene el código organizado
- Maven simplifica enormemente la gestión de dependencias
- Scrum permite entregar valor incremental en cada sprint
- El AuthFilter es esencial para la seguridad de aplicaciones web con roles

---

## Resumen del proyecto completo

| Sprint | Fechas | User Stories | Estado |
|--------|--------|-------------|--------|
| Sprint 1 | 27/02 – 06/03 | US-01 a US-05 | ✅ Completo |
| Sprint 2 | 07/03 – 13/03 | US-06 a US-11 | ✅ Completo |
| Sprint 3 | 14/03 – 20/03 | US-12 a US-16 | ✅ Completo |

**Total user stories completadas: 16 / 16**

---

## Stack tecnológico final

| Tecnología | Versión | Uso |
|-----------|---------|-----|
| Java | 17 (Temurin) | Lenguaje principal |
| JSP | 2.3 | Vistas dinámicas |
| Servlet API | 3.1 | Controladores HTTP |
| JSTL | 1.2 | Lógica en JSP |
| JDBC | — | Acceso a BD |
| MySQL | 8.0 | BD local (XAMPP) |
| MySQL Railway | 8.0 | BD online |
| BCrypt | 0.4 | Encriptación contraseñas |
| Bootstrap | 5.3 | Frontend responsivo |
| Maven | 3.9.14 | Gestión dependencias |
| Tomcat | 8.5.96 | Servidor de aplicaciones |
| JUnit | 4.13.2 | Testing unitario |
| Git | — | Control de versiones |
| Trello | — | Tablero Scrum |
