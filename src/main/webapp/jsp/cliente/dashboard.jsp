<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("cliente")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
    com.inmobiliaria.dao.CitaDAO cDao = new com.inmobiliaria.dao.CitaDAO();
    java.util.List<com.inmobiliaria.model.Propiedad> propiedades = null;
    java.util.List<com.inmobiliaria.model.Cita> misCitas = null;
    try {
        propiedades = pDao.listar(null, null, null, null);
        misCitas = cDao.listarPorCliente(u.getId());
    } catch (Exception e) {
        propiedades = new java.util.ArrayList<>();
        misCitas = new java.util.ArrayList<>();
    }
    request.setAttribute("propiedades", propiedades);
    request.setAttribute("misCitas", misCitas);
    pageContext.setAttribute("pageTitle", "Dashboard Cliente — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container-fluid py-4" style="background:var(--light-gray); min-height:80vh;">
    <div class="container">

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="section-title mb-0">Mi panel</h2>
                <p class="text-muted small mb-0">Bienvenido, ${sessionScope.usuario.nombre}</p>
            </div>
            <span class="badge bg-success px-3 py-2">ROL: CLIENTE</span>
        </div>

        <c:if test="${not empty param.exito}">
            <div class="alert alert-success alert-auto mb-3">
                <i class="bi bi-check-circle me-2"></i>${param.exito}
            </div>
        </c:if>

        <!-- Stats -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-building-fill fs-2 text-primary mb-2"></i>
                    <div class="fw-bold fs-4">${propiedades.size()}</div>
                    <div class="text-muted small">Propiedades disponibles</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-calendar-check-fill fs-2 text-success mb-2"></i>
                    <div class="fw-bold fs-4">${misCitas.size()}</div>
                    <div class="text-muted small">Mis citas</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-hourglass-split fs-2 text-warning mb-2"></i>
                    <div class="fw-bold fs-4">
                        <c:set var="pendientes" value="0"/>
                        <c:forEach var="c" items="${misCitas}">
                            <c:if test="${c.estado == 'pendiente'}">
                                <c:set var="pendientes" value="${pendientes+1}"/>
                            </c:if>
                        </c:forEach>
                        ${pendientes}
                    </div>
                    <div class="text-muted small">Pendientes</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="card border-0 shadow-sm text-center p-3">
                    <i class="bi bi-person-fill fs-2 text-info mb-2"></i>
                    <div class="fw-bold small mt-1">${sessionScope.usuario.email}</div>
                    <div class="text-muted small">Mi cuenta</div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Buscar propiedades -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-search me-2 text-primary"></i>Buscar propiedades</h5>
                        <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp"
                           class="btn btn-outline-primary btn-sm">Ver todas</a>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/jsp/propiedades.jsp" method="get" class="row g-2">
                            <div class="col-md-5">
                                <input type="text" name="ciudad" class="form-control form-control-sm"
                                       placeholder="Ciudad o barrio...">
                            </div>
                            <div class="col-md-3">
                                <select name="tipo" class="form-select form-select-sm">
                                    <option value="">Tipo</option>
                                    <option value="casa">Casa</option>
                                    <option value="apartamento">Apartamento</option>
                                    <option value="terreno">Terreno</option>
                                    <option value="oficina">Oficina</option>
                                    <option value="local">Local</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select name="operacion" class="form-select form-select-sm">
                                    <option value="">Operación</option>
                                    <option value="venta">Venta</option>
                                    <option value="arriendo">Arriendo</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary btn-sm w-100">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </form>

                        <!-- Propiedades recientes -->
                        <div class="mt-3">
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
                        </div>
                    </div>
                </div>
            </div>

            <!-- Mis citas -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-calendar-check me-2 text-success"></i>Mis citas</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty misCitas}">
                                <div class="text-center py-4">
                                    <i class="bi bi-calendar display-4 text-muted"></i>
                                    <p class="text-muted small mt-2">No tienes citas agendadas.</p>
                                    <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp"
                                       class="btn btn-outline-primary btn-sm">
                                        Buscar propiedad para agendar
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="cita" items="${misCitas}">
                                    <div class="border rounded p-3 mb-2">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <div class="fw-semibold small">Propiedad #${cita.propiedadId}</div>
                                                <div class="text-muted" style="font-size:.75rem;">
                                                    <i class="bi bi-calendar me-1"></i>${cita.fechaCita}
                                                </div>
                                            </div>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test="${cita.estado == 'pendiente'}">bg-warning text-dark</c:when>
                                                    <c:when test="${cita.estado == 'confirmada'}">bg-success</c:when>
                                                    <c:when test="${cita.estado == 'cancelada'}">bg-danger</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>">
                                                ${cita.estado}
                                            </span>
                                        </div>
                                        <c:if test="${not empty cita.mensaje}">
                                            <div class="text-muted mt-1" style="font-size:.75rem;">${cita.mensaje}</div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
