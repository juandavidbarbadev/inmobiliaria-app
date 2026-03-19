<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("inmobiliaria")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    String idStr = request.getParameter("id");
    com.inmobiliaria.model.Propiedad prop = null;
    if (idStr != null) {
        try {
            com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
            prop = pDao.buscarPorId(Integer.parseInt(idStr));
        } catch (Exception e) { /* ignorar */ }
    }
    if (prop == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/inmobiliaria/dashboard.jsp");
        return;
    }
    request.setAttribute("prop", prop);
    pageContext.setAttribute("pageTitle", "Editar Propiedad — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="d-flex align-items-center gap-3 mb-4">
                <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/dashboard.jsp"
                   class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-arrow-left"></i>
                </a>
                <h2 class="section-title mb-0">Editar propiedad</h2>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i>${error}</div>
            </c:if>

            <div class="card border-0 shadow-sm p-4">
                <form action="${pageContext.request.contextPath}/PropiedadServlet" method="post">
                    <input type="hidden" name="action" value="editar">
                    <input type="hidden" name="id" value="${prop.id}">

                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-semibold">Título *</label>
                            <input type="text" name="titulo" class="form-control"
                                   value="${prop.titulo}" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Tipo *</label>
                            <select name="tipo" class="form-select" required>
                                <option value="casa"        ${prop.tipo=='casa'?'selected':''}>Casa</option>
                                <option value="apartamento" ${prop.tipo=='apartamento'?'selected':''}>Apartamento</option>
                                <option value="terreno"     ${prop.tipo=='terreno'?'selected':''}>Terreno</option>
                                <option value="oficina"     ${prop.tipo=='oficina'?'selected':''}>Oficina</option>
                                <option value="local"       ${prop.tipo=='local'?'selected':''}>Local</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Operación *</label>
                            <select name="operacion" class="form-select" required>
                                <option value="venta"    ${prop.operacion=='venta'?'selected':''}>Venta</option>
                                <option value="arriendo" ${prop.operacion=='arriendo'?'selected':''}>Arriendo</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Precio (COP) *</label>
                            <input type="number" name="precio" class="form-control"
                                   value="${prop.precio}" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Área (m²)</label>
                            <input type="number" name="areaM2" class="form-control"
                                   value="${prop.areaM2}" min="0" step="0.01">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Habitaciones</label>
                            <input type="number" name="habitaciones" class="form-control"
                                   value="${prop.habitaciones}" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Baños</label>
                            <input type="number" name="banos" class="form-control"
                                   value="${prop.banos}" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Parqueaderos</label>
                            <input type="number" name="parqueaderos" class="form-control"
                                   value="${prop.parqueaderos}" min="0">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Ciudad *</label>
                            <input type="text" name="ciudad" class="form-control"
                                   value="${prop.ciudad}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Barrio</label>
                            <input type="text" name="barrio" class="form-control"
                                   value="${prop.barrio}">
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Dirección</label>
                            <input type="text" name="direccion" class="form-control"
                                   value="${prop.direccion}">
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold">Descripción</label>
                            <textarea name="descripcion" class="form-control" rows="4">${prop.descripcion}</textarea>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold">Estado</label>
                            <select name="disponible" class="form-select">
                                <option value="true"  ${prop.disponible?'selected':''}>Disponible</option>
                                <option value="false" ${!prop.disponible?'selected':''}>No disponible</option>
                            </select>
                        </div>

                        <div class="col-12 d-flex gap-2 mt-2">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-save me-2"></i>Guardar cambios
                            </button>
                            <a href="${pageContext.request.contextPath}/jsp/inmobiliaria/dashboard.jsp"
                               class="btn btn-outline-secondary px-4">Cancelar</a>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
