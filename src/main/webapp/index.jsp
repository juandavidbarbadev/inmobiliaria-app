<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.dao.PropiedadDAO dao = new com.inmobiliaria.dao.PropiedadDAO();
    java.util.List<com.inmobiliaria.model.Propiedad> propiedades = null;
    String dbError = null;
    try {
        propiedades = dao.listar(null, null, null, null);
    } catch (Exception e) {
        propiedades = new java.util.ArrayList<>();
        dbError = e.getClass().getName() + ": " + e.getMessage();
        if (e.getCause() != null) dbError += " | Causa: " + e.getCause().getMessage();
    }
    request.setAttribute("propiedades", propiedades);
    request.setAttribute("dbError", dbError);
    pageContext.setAttribute("pageTitle", "InmobiliariaApp — Tu hogar ideal en Colombia");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<!-- ============ HERO ============ -->
<section class="hero-section">
    <div class="container position-relative">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <p class="text-warning fw-semibold mb-2 text-uppercase" style="letter-spacing:2px; font-size:.85rem;">
                    <i class="bi bi-geo-alt-fill me-1"></i> Bucaramanga & Colombia
                </p>
                <h1 class="hero-title mb-3">
                    Encuentra tu <span>propiedad</span><br>ideal hoy
                </h1>
                <p class="hero-subtitle mb-4">
                    Miles de casas, apartamentos y terrenos disponibles.<br>
                    Compra, vende o arrienda con total confianza.
                </p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="#propiedades" class="btn btn-warning fw-bold px-4 py-2">
                        <i class="bi bi-search me-2"></i>Ver propiedades
                    </a>
                    <a href="${pageContext.request.contextPath}/jsp/register.jsp" class="btn btn-outline-light px-4 py-2">
                        <i class="bi bi-person-plus me-2"></i>Registrarse gratis
                    </a>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="search-box">
                    <h5 class="fw-bold mb-4" style="color:var(--primary);">
                        <i class="bi bi-search me-2"></i>Buscar propiedad
                    </h5>
                    <form action="${pageContext.request.contextPath}/jsp/propiedades.jsp" method="get">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label">Ciudad o barrio</label>
                                <input type="text" name="ciudad" class="form-control"
                                       placeholder="Ej: Bucaramanga, Cabecera...">
                            </div>
                            <div class="col-6">
                                <label class="form-label">Tipo</label>
                                <select name="tipo" class="form-select">
                                    <option value="">Todos</option>
                                    <option value="casa">Casa</option>
                                    <option value="apartamento">Apartamento</option>
                                    <option value="terreno">Terreno</option>
                                    <option value="oficina">Oficina</option>
                                    <option value="local">Local</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Operación</label>
                                <select name="operacion" class="form-select">
                                    <option value="">Todas</option>
                                    <option value="venta">Venta</option>
                                    <option value="arriendo">Arriendo</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-search w-100">
                                    <i class="bi bi-search me-2"></i>Buscar ahora
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ STATS ============ -->
<section class="stats-bar">
    <div class="container">
        <div class="row g-0">
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">${propiedades.size()}+</div>
                    <div class="stat-label">Propiedades</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Ciudades</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">Confiable</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Disponible</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============ PROPIEDADES DESTACADAS ============ -->
<section class="py-6 bg-light" id="propiedades" style="padding: 5rem 0;">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Propiedades destacadas</h2>
            <div class="section-divider mx-auto"></div>
            <p class="text-muted">Encuentra las mejores opciones disponibles ahora mismo</p>
        </div>

        <%-- Mostrar error de BD si existe --%>
        <c:if test="${not empty dbError}">
            <div class="alert alert-danger mb-4">
                <strong><i class="bi bi-exclamation-triangle me-2"></i>Error de conexión a la base de datos:</strong><br>
                ${dbError}
            </div>
        </c:if>

        <div class="row g-4">
            <c:choose>
                <c:when test="${empty propiedades}">
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-building display-1 text-muted"></i>
                        <p class="mt-3 text-muted">No hay propiedades disponibles por el momento.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${propiedades}" begin="0" end="5">
                        <div class="col-md-6 col-lg-4">
                            <div class="card prop-card h-100">
                                <div class="position-relative">
                                    <div class="prop-card-img-placeholder">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <span class="badge-operacion badge-${p.operacion}">
                                        ${p.operacion}
                                    </span>
                                </div>
                                <div class="card-body">
                                    <p class="text-muted small mb-1">
                                        <i class="bi bi-geo-alt me-1"></i>${p.ciudad}, ${p.barrio}
                                    </p>
                                    <h6 class="card-title fw-bold mb-2">${p.titulo}</h6>
                                    <div class="prop-precio mb-3">
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
        <c:if test="${propiedades.size() > 6}">
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/jsp/propiedades.jsp"
                   class="btn btn-primary-custom px-5 py-2">
                    Ver todas las propiedades <i class="bi bi-arrow-right ms-2"></i>
                </a>
            </div>
        </c:if>
    </div>
</section>

<!-- ============ FEATURES ============ -->
<section style="padding: 5rem 0;">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">¿Por qué elegirnos?</h2>
            <div class="section-divider mx-auto"></div>
        </div>
        <div class="row g-4">
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon"><i class="bi bi-shield-check"></i></div>
                <h5 class="fw-bold">100% Seguro</h5>
                <p class="text-muted small">Todas las propiedades son verificadas y los trámites están respaldados legalmente.</p>
            </div>
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon"><i class="bi bi-lightning-charge"></i></div>
                <h5 class="fw-bold">Proceso ágil</h5>
                <p class="text-muted small">Agenda citas, envía documentos y cierra negocios de forma rápida desde la plataforma.</p>
            </div>
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon"><i class="bi bi-headset"></i></div>
                <h5 class="fw-bold">Soporte 24/7</h5>
                <p class="text-muted small">Nuestro equipo está disponible para ayudarte en cada paso del proceso.</p>
            </div>
        </div>
    </div>
</section>

<!-- ============ CTA ============ -->
<section class="cta-section py-5 text-center">
    <div class="container py-3">
        <h2 class="section-title text-white mb-3">¿Listo para encontrar tu propiedad?</h2>
        <p class="text-white-50 mb-4">Crea tu cuenta gratis y accede a todas las funcionalidades.</p>
        <a href="${pageContext.request.contextPath}/jsp/register.jsp"
           class="btn btn-warning btn-lg fw-bold px-5">
            <i class="bi bi-rocket-takeoff me-2"></i>Comenzar ahora
        </a>
    </div>
</section>

<%@ include file="/fragments/footer.jspf" %>
