<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
    java.util.List<com.inmobiliaria.model.Propiedad> propiedades = null;
    try {
        propiedades = pDao.listar(null, null, null, null);
    } catch (Exception e) {
        propiedades = new java.util.ArrayList<>();
    }
    request.setAttribute("propiedades", propiedades);
    pageContext.setAttribute("pageTitle", "Dashboard — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container-fluid py-4" style="background:var(--light-gray); min-height:80vh;">
    <div class="container">

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="section-title mb-0">Bienvenido</h2>
                <p class="text-muted small mb-0">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</p>
            </div>
            <span class="badge bg-secondary px-3 py-2">ROL: USUARIO</span>
        </div>

        <!-- Info cuenta -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm p-4">
                    <h5 class="fw-bold mb-3"><i class="bi bi-person-circle me-2 text-primary"></i>Mi cuenta</h5>
                    <div class="mb-2">
                        <span class="text-muted small">Nombre:</span>
                        <div class="fw-semibold">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</div>
                    </div>
                    <div class="mb-2">
                        <span class="text-muted small">Email:</span>
                        <div class="fw-semibold">${sessionScope.usuario.email}</div>
                    </div>
                    <div class="mb-3">
                        <span class="text-muted small">Rol:</span>
                        <div><span class="badge bg-secondary">${sessionScope.usuario.rolNombre}</span></div>
                    </div>
                    <div class="alert alert-info small p-2 mb-0">
                        <i class="bi bi-info-circle me-1"></i>
                        ¿Quieres buscar propiedades y agendar citas?
                        Contacta al administrador para cambiar tu rol a <strong>Cliente</strong>.
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card border-0 shadow-sm p-4">
                    <h5 class="fw-bold mb-3"><i class="bi bi-building me-2 text-success"></i>Propiedades destacadas</h5>
                    <c:forEach var="p" items="${propiedades}" begin="0" end="2">
                        <div class="d-flex align-items-center gap-3 p-2 border rounded mb-2">
                            <div class="prop-card-img-placeholder rounded" style="width:60px;height:60px;font-size:1.5rem;flex-shrink:0;">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-semibold small">${p.titulo}</div>
                                <div class="text-muted" style="font-size:.75rem;">${p.ciudad} — ${p.tipo}</div>
                                <div class="text-primary fw-bold" style="font-size:.85rem;">
                                    <fmt:formatNumber value="${p.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/jsp/detalle-propiedad.jsp?id=${p.id}"
                               class="btn btn-outline-primary btn-sm">Ver</a>
                        </div>
                    </c:forEach>
                    <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp"
                       class="btn btn-outline-primary btn-sm mt-2">
                        Ver todas las propiedades <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
