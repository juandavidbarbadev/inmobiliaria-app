# InmobiliariaApp

Aplicación web para gestión inmobiliaria — Proyecto académico UTS  
**Asignatura:** Programación Java | **Docente:** Julian Barney Jaimes Rincón  
**Estado:** Sprint 3 completado ✅

---

## Stack tecnológico

| Tecnología | Versión |
|-----------|---------|
| Java | 17 (Temurin) |
| JSP + Servlets | Java EE |
| MySQL | 8.0 (XAMPP local) |
| Bootstrap | 5.3 |
| Maven | 3.9.14 |
| Tomcat | 8.5.96 |
| JUnit | 4.13.2 |

---

## Instalación y ejecución

### 1. Requisitos previos
- Java 17
- XAMPP (MySQL + Tomcat)
- Maven 3.9+
- MySQL Workbench

### 2. Base de datos
Abre MySQL Workbench y ejecuta:
```
sql/inmobiliaria_db.sql
```

### 3. Compilar
```bash
mvn clean package
```

### 4. Desplegar en Tomcat
```bash
copy target\inmobiliaria.war C:\xampp\tomcat\webapps\
```

### 5. Abrir
```
http://localhost:8080/inmobiliaria/
```

---

## Credenciales de prueba

| Usuario | Email | Contraseña | Rol |
|---------|-------|-----------|-----|
| Admin Sistema | admin@inmobiliaria.com | Admin123! | admin |
| Carlos Ramirez | inmo@inmobiliaria.com | Admin123! | inmobiliaria |

---

## Ejecutar tests JUnit

```bash
mvn test
```

---

## Estructura del proyecto

```
inmobiliaria/
├── pom.xml
├── README.md
├── SPRINT1.md
├── SPRINT2.md
├── SPRINT3.md
├── sql/
│   └── inmobiliaria_db.sql
└── src/
    ├── main/
    │   ├── java/com/inmobiliaria/
    │   │   ├── dao/          ← PropiedadDAO, UsuarioDAO, CitaDAO
    │   │   ├── model/        ← Propiedad, Usuario, Cita
    │   │   ├── servlet/      ← Login, Register, Logout, Propiedad, Cita, AdminUsuario
    │   │   └── util/         ← DBConnection, AuthFilter, EncodingFilter
    │   └── webapp/
    │       ├── index.jsp
    │       ├── css/style.css
    │       ├── js/main.js
    │       ├── fragments/    ← header, navbar, footer
    │       └── jsp/
    │           ├── admin/    ← dashboard, reportes
    │           ├── inmobiliaria/ ← dashboard, agregar, editar, reportes
    │           ├── cliente/  ← dashboard, solicitar-cita
    │           └── usuario/  ← dashboard
    └── test/
        └── java/com/inmobiliaria/
            └── InmobiliariaTest.java
```

---

## Páginas del sistema

| URL | Descripción | Rol requerido |
|-----|-------------|---------------|
| `/inmobiliaria/` | Landing page | Público |
| `/inmobiliaria/jsp/login.jsp` | Login | Público |
| `/inmobiliaria/jsp/register.jsp` | Registro | Público |
| `/inmobiliaria/jsp/propiedades.jsp` | Listado con filtros | Público |
| `/inmobiliaria/jsp/admin/dashboard.jsp` | Panel admin | Admin |
| `/inmobiliaria/jsp/admin/reportes.jsp` | Reportes globales | Admin |
| `/inmobiliaria/jsp/inmobiliaria/dashboard.jsp` | Panel inmobiliaria | Inmobiliaria |
| `/inmobiliaria/jsp/inmobiliaria/agregar-propiedad.jsp` | Nueva propiedad | Inmobiliaria |
| `/inmobiliaria/jsp/inmobiliaria/reportes.jsp` | Mis reportes | Inmobiliaria |
| `/inmobiliaria/jsp/cliente/dashboard.jsp` | Panel cliente | Cliente |
| `/inmobiliaria/jsp/cliente/solicitar-cita.jsp` | Agendar visita | Cliente |
| `/inmobiliaria/jsp/usuario/dashboard.jsp` | Panel usuario | Usuario |
