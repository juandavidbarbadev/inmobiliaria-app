<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String idStr = request.getParameter("id");
    com.inmobiliaria.model.Propiedad propiedad = null;
    if (idStr != null) {
        try {
            int id = Integer.parseInt(idStr);
            com.inmobiliaria.dao.PropiedadDAO dao = new com.inmobiliaria.dao.PropiedadDAO();
            propiedad = dao.buscarPorId(id);
        } catch (Exception e) { /* ignorar */ }
    }
    request.setAttribute("propiedad", propiedad);
    pageContext.setAttribute("pageTitle", propiedad != null ? propiedad.getTitulo() + " — InmobiliariaApp" : "Propiedad no encontrada");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <c:choose>
        <c:when test="${propiedad == null}">
            <div class="text-center py-5">
                <i class="bi bi-building-x display-1 text-muted"></i>
                <h3 class="mt-3">Propiedad no encontrada</h3>
                <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp" class="btn btn-primary mt-3">
                    Ver todas las propiedades
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/jsp/propiedades.jsp">Propiedades</a></li>
                    <li class="breadcrumb-item active">${propiedad.titulo}</li>
                </ol>
            </nav>

            <div class="row g-5">
                <!-- Imagen y detalles -->
                <div class="col-lg-8">
                    <div class="prop-card-img-placeholder rounded-3 mb-4" style="height:350px;font-size:5rem;">
                        <i class="bi bi-building"></i>
                    </div>
                    <div class="d-flex gap-2 mb-3 flex-wrap">
                        <span class="badge-operacion badge-${propiedad.operacion} position-static">${propiedad.operacion}</span>
                        <span class="badge bg-light text-dark border text-capitalize">${propiedad.tipo}</span>
                        <c:if test="${propiedad.disponible}">
                            <span class="badge bg-success">Disponible</span>
                        </c:if>
                    </div>
                    <h1 class="section-title mb-2">${propiedad.titulo}</h1>
                    <p class="text-muted mb-4">
                        <i class="bi bi-geo-alt-fill me-1 text-danger"></i>
                        ${propiedad.barrio}, ${propiedad.ciudad}
                        <c:if test="${not empty propiedad.direccion}"> — ${propiedad.direccion}</c:if>
                    </p>

                    <!-- Características -->
                    <div class="row g-3 mb-4">
                        <c:if test="${propiedad.habitaciones > 0}">
                            <div class="col-6 col-md-3">
                                <div class="card border-0 bg-light text-center p-3">
                                    <i class="bi bi-door-open fs-4 text-primary mb-1"></i>
                                    <div class="fw-bold">${propiedad.habitaciones}</div>
                                    <small class="text-muted">Habitaciones</small>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${propiedad.banos > 0}">
                            <div class="col-6 col-md-3">
                                <div class="card border-0 bg-light text-center p-3">
                                    <i class="bi bi-droplet fs-4 text-primary mb-1"></i>
                                    <div class="fw-bold">${propiedad.banos}</div>
                                    <small class="text-muted">Baños</small>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${propiedad.areaM2 > 0}">
                            <div class="col-6 col-md-3">
                                <div class="card border-0 bg-light text-center p-3">
                                    <i class="bi bi-aspect-ratio fs-4 text-primary mb-1"></i>
                                    <div class="fw-bold">${propiedad.areaM2} m²</div>
                                    <small class="text-muted">Área</small>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${propiedad.parqueaderos > 0}">
                            <div class="col-6 col-md-3">
                                <div class="card border-0 bg-light text-center p-3">
                                    <i class="bi bi-p-square fs-4 text-primary mb-1"></i>
                                    <div class="fw-bold">${propiedad.parqueaderos}</div>
                                    <small class="text-muted">Parqueaderos</small>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <h5 class="fw-bold mb-2">Descripción</h5>
                    <p class="text-muted">${not empty propiedad.descripcion ? propiedad.descripcion : 'Sin descripción disponible.'}</p>
                </div>

                <!-- Panel precio y contacto -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm p-4 sticky-top" style="top:90px;">
                        <div class="prop-precio mb-1" style="font-size:1.8rem;">
                            <fmt:formatNumber value="${propiedad.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/>
                        </div>
                        <p class="text-muted small mb-4">
                            ${propiedad.operacion == 'arriendo' ? '/ mes' : 'precio total'}
                        </p>

                        <c:choose>
                            <c:when test="${sessionScope.rolNombre == 'cliente'}">
                                <a href="${pageContext.request.contextPath}/jsp/cliente/solicitar-cita.jsp?propId=${propiedad.id}"
                                   class="btn btn-primary-custom mb-2">
                                    <i class="bi bi-calendar-check me-2"></i>Agendar visita
                                </a>
                                <a href="${pageContext.request.contextPath}/jsp/cliente/solicitar.jsp?propId=${propiedad.id}"
                                   class="btn btn-outline-primary w-100">
                                    <i class="bi bi-file-earmark-text me-2"></i>Enviar solicitud
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.usuario == null}">
                                <p class="text-muted small text-center mb-2">Inicia sesión para contactar</p>
                                <a href="${pageContext.request.contextPath}/jsp/login.jsp"
                                   class="btn btn-primary-custom mb-2">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión
                                </a>
                                <a href="${pageContext.request.contextPath}/jsp/register.jsp"
                                   class="btn btn-outline-primary w-100">
                                    <i class="bi bi-person-plus me-2"></i>Registrarse gratis
                                </a>
                            </c:when>
                        </c:choose>

                        <hr class="my-3">
                        <p class="text-muted small text-center mb-0">
                            <i class="bi bi-shield-check me-1 text-success"></i>
                            Propiedad verificada
                        </p>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/fragments/footer.jspf" %>
