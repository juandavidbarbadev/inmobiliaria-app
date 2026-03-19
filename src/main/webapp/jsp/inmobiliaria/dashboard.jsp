<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("inmobiliaria")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
    java.util.List<com.inmobiliaria.model.Propiedad> misPropiedades = null;
    try {
        misPropiedades = pDao.listarPorUsuario(u.getId());
    } catch (Exception e) {
        misPropiedades = new java.util.ArrayList<>();
    }
    request.setAttribute("misPropiedades", misPropiedades);
    pageContext.setAttribute("pageTitle", "Dashboard Inmobiliaria — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container-fluid py-4" style="background:var(--light-gray); min-height:80vh;">
    <div class="container">

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="section-title mb-0">Panel Inmobiliaria</h2>
                <p class="text-muted small mb-0">Bienvenido, ${sessionScope.usuario.nombre}</p>
            </div>
            <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/agregar-propiedad.jsp"
               class="btn btn-primary">
                <i class="bi bi-plus-circle me-2"></i>Nueva propiedad
            </a>
        </div>

        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-building-fill fs-2 text-primary mb-2"></i>
                    <div class="fw-bold fs-4">${misPropiedades.size()}</div>
                    <div class="text-muted small">Mis propiedades</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-house-check-fill fs-2 text-success mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="disp" value="0"/>
                        <c:forEach var="p" items="${misPropiedades}">
                            <c:if test="${p.disponible}"><c:set var="disp" value="${disp+1}"/></c:if>
                        </c:forEach>
                        ${disp}
                    </div>
                    <div class="text-muted small">Disponibles</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-tag-fill fs-2 text-warning mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="ventas" value="0"/>
                        <c:forEach var="p" items="${misPropiedades}">
                            <c:if test="${p.operacion == 'venta'}"><c:set var="ventas" value="${ventas+1}"/></c:if>
                        </c:forEach>
                        ${ventas}
                    </div>
                    <div class="text-muted small">En venta</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-key-fill fs-2 text-info mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="arriendos" value="0"/>
                        <c:forEach var="p" items="${misPropiedades}">
                            <c:if test="${p.operacion == 'arriendo'}"><c:set var="arriendos" value="${arriendos+1}"/></c:if>
                        </c:forEach>
                        ${arriendos}
                    </div>
                    <div class="text-muted small">En arriendo</div>
                </div>
            </div>
        </div>

        <!-- Mensajes -->
        <c:if test="${not empty param.exito}">
            <div class="alert alert-success alert-auto mb-3">
                <i class="bi bi-check-circle me-2"></i>${param.exito}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-auto mb-3">
                <i class="bi bi-exclamation-triangle me-2"></i>${param.error}
            </div>
        </c:if>

        <!-- Tabla propiedades -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-building me-2 text-primary"></i>Mis propiedades</h5>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${empty misPropiedades}">
                        <div class="text-center py-5">
                            <i class="bi bi-building display-1 text-muted"></i>
                            <p class="mt-3 text-muted">No tienes propiedades aún.</p>
                            <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/agregar-propiedad.jsp"
                               class="btn btn-primary mt-2">
                                <i class="bi bi-plus-circle me-2"></i>Agregar primera propiedad
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Título</th>
                                        <th>Tipo</th>
                                        <th>Operación</th>
                                        <th>Precio</th>
                                        <th>Ciudad</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${misPropiedades}">
                                        <tr>
                                            <td class="fw-semibold">${p.titulo}</td>
                                            <td><span class="badge bg-light text-dark border text-capitalize">${p.tipo}</span></td>
                                            <td><span class="badge ${p.operacion == 'venta' ? 'bg-primary' : 'bg-warning text-dark'}">${p.operacion}</span></td>
                                            <td class="small">
                                                <fmt:formatNumber value="${p.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/>
                                            </td>
                                            <td class="small">${p.ciudad}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.disponible}"><span class="badge bg-success">Disponible</span></c:when>
                                                    <c:otherwise><span class="badge bg-secondary">No disponible</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/jsp/detalle-propiedad.jsp?id=${p.id}"
                                                   class="btn btn-outline-info btn-sm" title="Ver">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/editar-propiedad.jsp?id=${p.id}"
                                                   class="btn btn-outline-primary btn-sm" title="Editar">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/PropiedadServlet?action=eliminar&id=${p.id}"
                                                   class="btn btn-outline-danger btn-sm" title="Eliminar"
                                                   onclick="return confirm('¿Eliminar esta propiedad?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
