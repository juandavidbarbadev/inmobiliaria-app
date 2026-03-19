<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    com.inmobiliaria.dao.UsuarioDAO uDao = new com.inmobiliaria.dao.UsuarioDAO();
    com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
    java.util.List<com.inmobiliaria.model.Usuario> usuarios = null;
    java.util.List<com.inmobiliaria.model.Propiedad> propiedades = null;
    try {
        usuarios = uDao.listarTodos();
        propiedades = pDao.listar(null, null, null, null);
    } catch (Exception e) {
        usuarios = new java.util.ArrayList<>();
        propiedades = new java.util.ArrayList<>();
    }
    request.setAttribute("usuarios", usuarios);
    request.setAttribute("propiedades", propiedades);
    pageContext.setAttribute("pageTitle", "Dashboard Admin — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container-fluid py-4" style="background:var(--light-gray); min-height:80vh;">
    <div class="container">

        <!-- Header -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="section-title mb-0">Panel Administrador</h2>
                <p class="text-muted small mb-0">Bienvenido, ${sessionScope.usuario.nombre}</p>
            </div>
            <span class="badge bg-danger px-3 py-2">ROL: ADMIN</span>
        </div>

        <!-- Stats cards -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-people-fill fs-2 text-primary mb-2"></i>
                    <div class="fw-bold fs-4">${usuarios.size()}</div>
                    <div class="text-muted small">Usuarios totales</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-building-fill fs-2 text-success mb-2"></i>
                    <div class="fw-bold fs-4">${propiedades.size()}</div>
                    <div class="text-muted small">Propiedades</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-person-check-fill fs-2 text-warning mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="activos" value="0"/>
                        <c:forEach var="usr" items="${usuarios}">
                            <c:if test="${usr.activo}"><c:set var="activos" value="${activos + 1}"/></c:if>
                        </c:forEach>
                        ${activos}
                    </div>
                    <div class="text-muted small">Usuarios activos</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-house-check-fill fs-2 text-info mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="disponibles" value="0"/>
                        <c:forEach var="prop" items="${propiedades}">
                            <c:if test="${prop.disponible}"><c:set var="disponibles" value="${disponibles + 1}"/></c:if>
                        </c:forEach>
                        ${disponibles}
                    </div>
                    <div class="text-muted small">Disponibles</div>
                </div>
            </div>
        </div>

        <!-- Tabla de usuarios -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-people me-2 text-primary"></i>Gestión de usuarios</h5>
                <a href="${pageContext.request.contextPath}/jsp/admin/nuevo-usuario.jsp"
                   class="btn btn-primary btn-sm">
                    <i class="bi bi-person-plus me-1"></i>Nuevo usuario
                </a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Rol</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usr" items="${usuarios}">
                                <tr>
                                    <td class="text-muted small">${usr.id}</td>
                                    <td>
                                        <div class="fw-semibold">${usr.nombre} ${usr.apellido}</div>
                                        <div class="text-muted small">${usr.telefono}</div>
                                    </td>
                                    <td class="small">${usr.email}</td>
                                    <td>
                                        <span class="badge
                                            <c:choose>
                                                <c:when test="${usr.rolNombre == 'admin'}">bg-danger</c:when>
                                                <c:when test="${usr.rolNombre == 'inmobiliaria'}">bg-primary</c:when>
                                                <c:when test="${usr.rolNombre == 'cliente'}">bg-success</c:when>
                                                <c:otherwise>bg-secondary</c:otherwise>
                                            </c:choose>">
                                            ${usr.rolNombre}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${usr.activo}">
                                                <span class="badge bg-success">Activo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Inactivo</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/jsp/admin/editar-usuario.jsp?id=${usr.id}"
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/AdminUsuarioServlet?action=toggle&id=${usr.id}"
                                           class="btn btn-outline-warning btn-sm"
                                           onclick="return confirm('¿Cambiar estado del usuario?')">
                                            <i class="bi bi-toggle-on"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tabla propiedades resumen -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-building me-2 text-success"></i>Propiedades del sistema</h5>
                <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp" class="btn btn-outline-success btn-sm">
                    <i class="bi bi-eye me-1"></i>Ver todas
                </a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Título</th>
                                <th>Tipo</th>
                                <th>Operación</th>
                                <th>Ciudad</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prop" items="${propiedades}">
                                <tr>
                                    <td class="fw-semibold small">${prop.titulo}</td>
                                    <td><span class="badge bg-light text-dark border text-capitalize">${prop.tipo}</span></td>
                                    <td><span class="badge ${prop.operacion == 'venta' ? 'bg-primary' : 'bg-warning text-dark'}">${prop.operacion}</span></td>
                                    <td class="small">${prop.ciudad}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prop.disponible}"><span class="badge bg-success">Disponible</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">No disponible</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
