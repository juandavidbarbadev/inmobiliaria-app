<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("cliente")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    String propIdStr = request.getParameter("propId");
    com.inmobiliaria.model.Propiedad prop = null;
    if (propIdStr != null) {
        try {
            com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
            prop = pDao.buscarPorId(Integer.parseInt(propIdStr));
        } catch (Exception e) { /* ignorar */ }
    }
    request.setAttribute("prop", prop);
    pageContext.setAttribute("pageTitle", "Solicitar cita — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">

            <div class="d-flex align-items-center gap-3 mb-4">
                <a href="${pageContext.request.contextPath}/jsp/cliente/dashboard.jsp"
                   class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i>
                </a>
                <h2 class="section-title mb-0">Solicitar visita</h2>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i>${error}</div>
            </c:if>

            <c:if test="${prop != null}">
                <div class="card border-0 bg-light p-3 mb-4">
                    <div class="d-flex gap-3 align-items-center">
                        <div class="prop-card-img-placeholder rounded" style="width:70px;height:70px;font-size:2rem;flex-shrink:0;">
                            <i class="bi bi-building"></i>
                        </div>
                        <div>
                            <div class="fw-bold">${prop.titulo}</div>
                            <div class="text-muted small">${prop.ciudad}, ${prop.barrio}</div>
                            <div class="text-primary fw-bold">
                                <fmt:formatNumber value="${prop.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm p-4">
                <form action="${pageContext.request.contextPath}/CitaServlet" method="post">
                    <input type="hidden" name="propiedadId" value="${prop != null ? prop.id : ''}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Fecha y hora de visita *</label>
                        <input type="datetime-local" name="fechaCita" class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mensaje (opcional)</label>
                        <textarea name="mensaje" class="form-control" rows="3"
                                  placeholder="Cuéntanos algo sobre lo que buscas..."></textarea>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-calendar-check me-2"></i>Solicitar visita
                        </button>
                        <a href="${pageContext.request.contextPath}/jsp/cliente/dashboard.jsp"
                           class="btn btn-outline-secondary px-4">Cancelar</a>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
