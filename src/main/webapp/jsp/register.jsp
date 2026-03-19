<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("pageTitle","Registro — InmobiliariaApp"); %>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<section class="py-5" style="min-height:80vh; background:var(--light-gray);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="auth-card card">
                    <div class="text-center mb-4">
                        <div class="feature-icon mx-auto mb-3" style="background:var(--accent);">
                            <i class="bi bi-person-plus-fill" style="color:var(--primary);font-size:1.8rem;"></i>
                        </div>
                        <h2 class="auth-title">Crear cuenta</h2>
                        <p class="text-muted small">Únete a InmobiliariaApp de forma gratuita</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-auto d-flex align-items-center gap-2">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" novalidate>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="nombre" name="nombre"
                                           placeholder="Nombre" required>
                                    <label for="nombre">Nombre *</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="apellido" name="apellido"
                                           placeholder="Apellido" required>
                                    <label for="apellido">Apellido *</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <input type="email" class="form-control" id="email" name="email"
                                           placeholder="correo@ejemplo.com" required>
                                    <label for="email">Correo electrónico *</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <input type="tel" class="form-control" id="telefono" name="telefono"
                                           placeholder="Teléfono">
                                    <label for="telefono">Teléfono (opcional)</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="password" class="form-control" id="password" name="password"
                                           placeholder="Contraseña" required minlength="6">
                                    <label for="password">Contraseña *</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="password" class="form-control" id="password2" name="password2"
                                           placeholder="Confirmar" required>
                                    <label for="password2">Confirmar contraseña *</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold small text-uppercase" style="color:var(--primary);letter-spacing:.5px;">
                                    ¿Cómo vas a usar la plataforma?
                                </label>
                                <div class="d-flex gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rol"
                                               id="rolUsuario" value="usuario" checked>
                                        <label class="form-check-label" for="rolUsuario">
                                            <i class="bi bi-eye me-1"></i>Solo visitar
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rol"
                                               id="rolCliente" value="cliente">
                                        <label class="form-check-label" for="rolCliente">
                                            <i class="bi bi-house-heart me-1"></i>Buscar propiedad
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 mt-2">
                                <button type="submit" class="btn btn-primary-custom">
                                    <i class="bi bi-person-check me-2"></i>Crear cuenta
                                </button>
                            </div>
                        </div>
                    </form>

                    <hr class="my-4">
                    <p class="text-center text-muted small mb-0">
                        ¿Ya tienes cuenta?
                        <a href="${pageContext.request.contextPath}/jsp/login.jsp"
                           class="text-primary-custom fw-semibold">Iniciar sesión</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="/fragments/footer.jspf" %>
