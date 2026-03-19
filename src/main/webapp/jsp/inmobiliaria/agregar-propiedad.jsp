<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("inmobiliaria")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    pageContext.setAttribute("pageTitle", "Agregar Propiedad — InmobiliariaApp");
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
                <h2 class="section-title mb-0">Agregar propiedad</h2>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger"><i class="bi bi-exclamation-triangle me-2"></i>${error}</div>
            </c:if>

            <div class="card border-0 shadow-sm p-4">
                <form action="${pageContext.request.contextPath}/PropiedadServlet" method="post">
                    <input type="hidden" name="action" value="agregar">

                    <div class="row g-3">
                        <!-- Título -->
                        <div class="col-12">
                            <label class="form-label fw-semibold">Título *</label>
                            <input type="text" name="titulo" class="form-control"
                                   placeholder="Ej: Apartamento moderno en Cabecera" required>
                        </div>

                        <!-- Tipo y Operación -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Tipo *</label>
                            <select name="tipo" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <option value="casa">Casa</option>
                                <option value="apartamento">Apartamento</option>
                                <option value="terreno">Terreno</option>
                                <option value="oficina">Oficina</option>
                                <option value="local">Local</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Operación *</label>
                            <select name="operacion" class="form-select" required>
                                <option value="">Seleccionar...</option>
                                <option value="venta">Venta</option>
                                <option value="arriendo">Arriendo</option>
                            </select>
                        </div>

                        <!-- Precio y Área -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Precio (COP) *</label>
                            <input type="number" name="precio" class="form-control"
                                   placeholder="Ej: 450000000" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Área (m²)</label>
                            <input type="number" name="areaM2" class="form-control"
                                   placeholder="Ej: 75" min="0" step="0.01">
                        </div>

                        <!-- Habitaciones, Baños, Parqueaderos -->
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Habitaciones</label>
                            <input type="number" name="habitaciones" class="form-control"
                                   value="0" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Baños</label>
                            <input type="number" name="banos" class="form-control"
                                   value="0" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Parqueaderos</label>
                            <input type="number" name="parqueaderos" class="form-control"
                                   value="0" min="0">
                        </div>

                        <!-- Ubicación -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Ciudad *</label>
                            <input type="text" name="ciudad" class="form-control"
                                   placeholder="Ej: Bucaramanga" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Barrio</label>
                            <input type="text" name="barrio" class="form-control"
                                   placeholder="Ej: Cabecera">
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Dirección</label>
                            <input type="text" name="direccion" class="form-control"
                                   placeholder="Ej: Calle 45 # 30-20">
                        </div>

                        <!-- Descripción -->
                        <div class="col-12">
                            <label class="form-label fw-semibold">Descripción</label>
                            <textarea name="descripcion" class="form-control" rows="4"
                                      placeholder="Describe la propiedad..."></textarea>
                        </div>

                        <!-- Botones -->
                        <div class="col-12 d-flex gap-2 mt-2">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-plus-circle me-2"></i>Agregar propiedad
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
