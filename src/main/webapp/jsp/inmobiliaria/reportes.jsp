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
    com.inmobiliaria.dao.CitaDAO cDao = new com.inmobiliaria.dao.CitaDAO();

    java.util.List<com.inmobiliaria.model.Propiedad> misProps = pDao.listarPorUsuario(u.getId());
    java.util.List<com.inmobiliaria.model.Cita> todasCitas = cDao.listarTodas();

    request.setAttribute("misProps", misProps);
    request.setAttribute("todasCitas", todasCitas);
    pageContext.setAttribute("pageTitle", "Mis Reportes — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <div class="d-flex align-items-center gap-3 mb-4">
        <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/dashboard.jsp"
           class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left"></i>
        </a>
        <h2 class="section-title mb-0">Mis reportes</h2>
    </div>

    <!-- Stats -->
    <div class="row g-3 mb-5">
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-building-fill fs-1 text-primary mb-2"></i>
                <div class="fw-bold fs-2">${misProps.size()}</div>
                <div class="text-muted">Mis propiedades</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-house-check-fill fs-1 text-success mb-2"></i>
                <div class="fw-bold fs-2">
                    <c:set var="disp" value="0"/>
                    <c:forEach var="p" items="${misProps}">
                        <c:if test="${p.disponible}"><c:set var="disp" value="${disp+1}"/></c:if>
                    </c:forEach>
                    ${disp}
                </div>
                <div class="text-muted">Disponibles</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-tag-fill fs-1 text-primary mb-2"></i>
                <div class="fw-bold fs-2">
                    <c:set var="vtas" value="0"/>
                    <c:forEach var="p" items="${misProps}">
                        <c:if test="${p.operacion == 'venta'}"><c:set var="vtas" value="${vtas+1}"/></c:if>
                    </c:forEach>
                    ${vtas}
                </div>
                <div class="text-muted">En venta</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-key-fill fs-1 text-warning mb-2"></i>
                <div class="fw-bold fs-2">
                    <c:set var="arrs" value="0"/>
                    <c:forEach var="p" items="${misProps}">
                        <c:if test="${p.operacion == 'arriendo'}"><c:set var="arrs" value="${arrs+1}"/></c:if>
                    </c:forEach>
                    ${arrs}
                </div>
                <div class="text-muted">En arriendo</div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Tabla propiedades con precio -->
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-list-ul me-2 text-primary"></i>Detalle de mis propiedades
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Título</th>
                                    <th>Tipo</th>
                                    <th>Operación</th>
                                    <th>Precio</th>
                                    <th>Ciudad</th>
                                    <th>Área m²</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${misProps}">
                                    <tr>
                                        <td class="fw-semibold">${p.titulo}</td>
                                        <td><span class="badge bg-light text-dark border text-capitalize">${p.tipo}</span></td>
                                        <td><span class="badge ${p.operacion == 'venta' ? 'bg-primary' : 'bg-warning text-dark'}">${p.operacion}</span></td>
                                        <td><fmt:formatNumber value="${p.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/></td>
                                        <td>${p.ciudad}</td>
                                        <td>${p.areaM2} m²</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.disponible}"><span class="badge bg-success">Disponible</span></c:when>
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

        <!-- Citas recibidas -->
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-calendar3 me-2 text-warning"></i>
                        Solicitudes de visita recibidas (${todasCitas.size()})
                    </h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty todasCitas}">
                            <div class="text-center py-4">
                                <i class="bi bi-calendar display-4 text-muted"></i>
                                <p class="text-muted mt-2">No hay solicitudes de visita aún.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Propiedad</th>
                                            <th>Cliente</th>
                                            <th>Fecha solicitada</th>
                                            <th>Mensaje</th>
                                            <th>Estado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cita" items="${todasCitas}">
                                            <tr>
                                                <td class="text-muted">${cita.id}</td>
                                                <td>Propiedad #${cita.propiedadId}</td>
                                                <td>Cliente #${cita.clienteId}</td>
                                                <td class="small">${cita.fechaCita}</td>
                                                <td class="small">${not empty cita.mensaje ? cita.mensaje : '—'}</td>
                                                <td>
                                                    <span class="badge
                                                        <c:choose>
                                                            <c:when test="${cita.estado == 'pendiente'}">bg-warning text-dark</c:when>
                                                            <c:when test="${cita.estado == 'confirmada'}">bg-success</c:when>
                                                            <c:when test="${cita.estado == 'cancelada'}">bg-danger</c:when>
                                                            <c:otherwise>bg-info</c:otherwise>
                                                        </c:choose>">
                                                        ${cita.estado}
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:if test="${cita.estado == 'pendiente'}">
                                                        <a href="${pageContext.request.contextPath}/CitaServlet?action=confirmar&id=${cita.id}"
                                                           class="btn btn-success btn-sm">
                                                            <i class="bi bi-check"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/CitaServlet?action=cancelar&id=${cita.id}"
                                                           class="btn btn-danger btn-sm">
                                                            <i class="bi bi-x"></i>
                                                        </a>
                                                    </c:if>
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
</div>

<%@ include file="/fragments/footer.jspf" %>
