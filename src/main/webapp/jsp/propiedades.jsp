<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String tipo      = request.getParameter("tipo");
    String operacion = request.getParameter("operacion");
    String ciudad    = request.getParameter("ciudad");
    String precioStr = request.getParameter("precioMax");
    Double precioMax = null;
    if (precioStr != null && !precioStr.isEmpty()) {
        try { precioMax = Double.parseDouble(precioStr); } catch (NumberFormatException ignored) {}
    }
    com.inmobiliaria.dao.PropiedadDAO dao = new com.inmobiliaria.dao.PropiedadDAO();
    java.util.List<com.inmobiliaria.model.Propiedad> propiedades;
    try {
        propiedades = dao.listar(tipo, operacion, ciudad, precioMax);
    } catch (Exception e) {
        propiedades = new java.util.ArrayList<>();
    }
    request.setAttribute("propiedades", propiedades);
    pageContext.setAttribute("pageTitle","Propiedades — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <h2 class="section-title mb-1">Propiedades disponibles</h2>
    <div class="section-divider"></div>

    <!-- Filtros -->
    <div class="card border-0 shadow-sm mb-4 p-3">
        <form method="get" class="row g-2 align-items-end">
            <div class="col-md-3">
                <label class="form-label small fw-semibold">Ciudad</label>
                <input type="text" name="ciudad" class="form-control form-control-sm"
                       value="${param.ciudad}" placeholder="Bucaramanga...">
            </div>
            <div class="col-md-2">
                <label class="form-label small fw-semibold">Tipo</label>
                <select name="tipo" class="form-select form-select-sm">
                    <option value="">Todos</option>
                    <option value="casa"        ${param.tipo=='casa'?'selected':''}>Casa</option>
                    <option value="apartamento" ${param.tipo=='apartamento'?'selected':''}>Apartamento</option>
                    <option value="terreno"     ${param.tipo=='terreno'?'selected':''}>Terreno</option>
                    <option value="oficina"     ${param.tipo=='oficina'?'selected':''}>Oficina</option>
                    <option value="local"       ${param.tipo=='local'?'selected':''}>Local</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label small fw-semibold">Operación</label>
                <select name="operacion" class="form-select form-select-sm">
                    <option value="">Todas</option>
                    <option value="venta"    ${param.operacion=='venta'?'selected':''}>Venta</option>
                    <option value="arriendo" ${param.operacion=='arriendo'?'selected':''}>Arriendo</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label small fw-semibold">Precio máximo (COP)</label>
                <input type="number" name="precioMax" class="form-control form-control-sm"
                       value="${param.precioMax}" placeholder="Ej: 500000000">
            </div>
            <div class="col-md-2 d-flex gap-2">
                <button type="submit" class="btn btn-primary btn-sm flex-fill">
                    <i class="bi bi-search"></i> Filtrar
                </button>
                <a href="propiedades.jsp" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-x"></i>
                </a>
            </div>
        </form>
    </div>

    <!-- Resultados -->
    <p class="text-muted small mb-3">
        <strong>${propiedades.size()}</strong> propiedad(es) encontrada(s)
    </p>

    <div class="row g-4">
        <c:choose>
            <c:when test="${empty propiedades}">
                <div class="col-12 text-center py-5">
                    <i class="bi bi-building display-1 text-muted"></i>
                    <p class="mt-3 text-muted">No se encontraron propiedades con esos filtros.</p>
                    <a href="propiedades.jsp" class="btn btn-outline-primary">Ver todas</a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${propiedades}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card prop-card h-100">
                            <div class="position-relative">
                                <div class="prop-card-img-placeholder">
                                    <i class="bi bi-building"></i>
                                </div>
                                <span class="badge-operacion badge-${p.operacion}">${p.operacion}</span>
                            </div>
                            <div class="card-body">
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-geo-alt me-1"></i>${p.ciudad}, ${p.barrio}
                                </p>
                                <h6 class="card-title fw-bold mb-2">${p.titulo}</h6>
                                <div class="prop-precio mb-2">
                                    <fmt:formatNumber value="${p.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/>
                                </div>
                                <div class="prop-features d-flex gap-3 flex-wrap">
                                    <c:if test="${p.habitaciones > 0}">
                                        <span><i class="bi bi-door-open"></i> ${p.habitaciones} hab.</span>
                                    </c:if>
                                    <c:if test="${p.banos > 0}">
                                        <span><i class="bi bi-droplet"></i> ${p.banos} baños</span>
                                    </c:if>
                                    <c:if test="${p.areaM2 > 0}">
                                        <span><i class="bi bi-aspect-ratio"></i> ${p.areaM2} m²</span>
                                    </c:if>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 pb-3">
                                <a href="${pageContext.request.contextPath}/jsp/detalle-propiedad.jsp?id=${p.id}"
                                   class="btn btn-outline-primary btn-sm w-100">
                                    Ver detalles <i class="bi bi-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
