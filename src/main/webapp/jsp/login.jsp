<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("pageTitle","Iniciar sesión — InmobiliariaApp"); %>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<section class="py-5" style="min-height:80vh; background:var(--light-gray);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="auth-card card">
                    <div class="text-center mb-4">
                        <div class="feature-icon mx-auto mb-3" style="background:var(--accent);">
                            <i class="bi bi-building-fill" style="color:var(--primary);font-size:1.8rem;"></i>
                        </div>
                        <h2 class="auth-title">Bienvenido</h2>
                        <p class="text-muted small">Ingresa a tu cuenta para continuar</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-auto d-flex align-items-center gap-2" role="alert">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty exito}">
                        <div class="alert alert-success alert-auto d-flex align-items-center gap-2" role="alert">
                            <i class="bi bi-check-circle-fill"></i> ${exito}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" novalidate>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="correo@ejemplo.com" required>
                            <label for="email"><i class="bi bi-envelope me-2"></i>Correo electrónico</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Contraseña" required>
                            <label for="password"><i class="bi bi-lock me-2"></i>Contraseña</label>
                        </div>
                        <button type="submit" class="btn btn-primary-custom">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Iniciar sesión
                        </button>
                    </form>

                    <hr class="my-4">
                    <p class="text-center text-muted small mb-0">
                        ¿No tienes cuenta?
                        <a href="${pageContext.request.contextPath}/jsp/register.jsp"
                           class="text-primary-custom fw-semibold">Regístrate gratis</a>
                    </p>
                    <p class="text-center mt-2">
                        <a href="${pageContext.request.contextPath}/index.jsp"
                           class="text-muted small"><i class="bi bi-arrow-left me-1"></i>Volver al inicio</a>
                    </p>
                </div>
                <p class="text-center text-muted small mt-3">
                    <i class="bi bi-info-circle me-1"></i>
                    Admin: admin@inmobiliaria.com / Admin123!
                </p>
            </div>
        </div>
    </div>
</section>

<%@ include file="/fragments/footer.jspf" %>
