<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<% pageContext.setAttribute("pageTitle","Acceso denegado — InmobiliariaApp"); %>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>
<div class="container text-center py-5" style="min-height:60vh;display:flex;align-items:center;justify-content:center;flex-direction:column;">
    <i class="bi bi-lock display-1 text-danger"></i>
    <h1 class="section-title mt-3">403 — Acceso denegado</h1>
    <p class="text-muted">No tienes permisos para ver esta página.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary mt-3">
        <i class="bi bi-house me-2"></i>Volver al inicio
    </a>
</div>
<%@ include file="/fragments/footer.jspf" %>
