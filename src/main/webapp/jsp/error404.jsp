<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<% pageContext.setAttribute("pageTitle","Página no encontrada — InmobiliariaApp"); %>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>
<div class="container text-center py-5" style="min-height:60vh;display:flex;align-items:center;justify-content:center;flex-direction:column;">
    <i class="bi bi-map display-1 text-muted"></i>
    <h1 class="section-title mt-3">404 — Página no encontrada</h1>
    <p class="text-muted">La página que buscas no existe o fue movida.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary mt-3">
        <i class="bi bi-house me-2"></i>Volver al inicio
    </a>
</div>
<%@ include file="/fragments/footer.jspf" %>
