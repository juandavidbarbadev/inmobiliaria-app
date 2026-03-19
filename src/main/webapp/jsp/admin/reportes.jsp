<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    com.inmobiliaria.model.Usuario u = (com.inmobiliaria.model.Usuario) session.getAttribute("usuario");
    if (u == null || !u.getRolNombre().equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    com.inmobiliaria.dao.PropiedadDAO pDao = new com.inmobiliaria.dao.PropiedadDAO();
    com.inmobiliaria.dao.UsuarioDAO uDao  = new com.inmobiliaria.dao.UsuarioDAO();
    com.inmobiliaria.dao.CitaDAO cDao     = new com.inmobiliaria.dao.CitaDAO();

    java.util.List<com.inmobiliaria.model.Propiedad> todas = pDao.listar(null, null, null, null);
    java.util.List<com.inmobiliaria.model.Propiedad> casas = pDao.listar("casa", null, null, null);
    java.util.List<com.inmobiliaria.model.Propiedad> aptos = pDao.listar("apartamento", null, null, null);
    java.util.List<com.inmobiliaria.model.Propiedad> terr  = pDao.listar("terreno", null, null, null);
    java.util.List<com.inmobiliaria.model.Propiedad> ventas    = pDao.listar(null, "venta", null, null);
    java.util.List<com.inmobiliaria.model.Propiedad> arriendos = pDao.listar(null, "arriendo", null, null);
    java.util.List<com.inmobiliaria.model.Usuario> usuarios = uDao.listarTodos();
    java.util.List<com.inmobiliaria.model.Cita> citas = cDao.listarTodas();

    request.setAttribute("todas", todas);
    request.setAttribute("casas", casas);
    request.setAttribute("aptos", aptos);
    request.setAttribute("terr", terr);
    request.setAttribute("ventas", ventas);
    request.setAttribute("arriendos", arriendos);
    request.setAttribute("usuarios", usuarios);
    request.setAttribute("citas", citas);
    pageContext.setAttribute("pageTitle", "Reportes Admin — InmobiliariaApp");
%>
<%@ include file="/fragments/header.jspf" %>
<%@ include file="/fragments/navbar.jspf" %>

<div class="container py-5">
    <div class="d-flex align-items-center gap-3 mb-4">
        <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp"
           class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left"></i>
        </a>
        <h2 class="section-title mb-0">Reportes del sistema</h2>
    </div>

    <!-- Resumen general -->
    <div class="row g-3 mb-5">
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-building-fill fs-1 text-primary mb-2"></i>
                <div class="fw-bold fs-2">${todas.size()}</div>
                <div class="text-muted">Total propiedades</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-people-fill fs-1 text-success mb-2"></i>
                <div class="fw-bold fs-2">${usuarios.size()}</div>
                <div class="text-muted">Total usuarios</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-calendar-check-fill fs-1 text-warning mb-2"></i>
                <div class="fw-bold fs-2">${citas.size()}</div>
                <div class="text-muted">Total citas</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm text-center p-4">
                <i class="bi bi-tag-fill fs-1 text-danger mb-2"></i>
                <div class="fw-bold fs-2">${ventas.size()}</div>
                <div class="text-muted">En venta</div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Propiedades por tipo -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-pie-chart me-2 text-primary"></i>Propiedades por tipo
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-house me-2"></i>Casas</span>
                        <span class="badge bg-primary fs-6">${casas.size()}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-building me-2"></i>Apartamentos</span>
                        <span class="badge bg-success fs-6">${aptos.size()}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-map me-2"></i>Terrenos</span>
                        <span class="badge bg-warning fs-6">${terr.size()}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center p-2 bg-light rounded">
                        <span><i class="bi bi-grid me-2"></i>Otros (oficinas/locales)</span>
                        <span class="badge bg-secondary fs-6">${todas.size() - casas.size() - aptos.size() - terr.size()}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Propiedades por operación -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-bar-chart me-2 text-success"></i>Propiedades por operación
                    </h5>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-semibold">Venta</span>
                            <span>${ventas.size()} propiedades</span>
                        </div>
                        <div class="progress" style="height:20px;">
                            <div class="progress-bar bg-primary" style="width:${todas.size() > 0 ? (ventas.size() * 100 / todas.size()) : 0}%">
                                ${todas.size() > 0 ? (ventas.size() * 100 / todas.size()) : 0}%
                            </div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-semibold">Arriendo</span>
                            <span>${arriendos.size()} propiedades</span>
                        </div>
                        <div class="progress" style="height:20px;">
                            <div class="progress-bar bg-warning" style="width:${todas.size() > 0 ? (arriendos.size() * 100 / todas.size()) : 0}%">
                                ${todas.size() > 0 ? (arriendos.size() * 100 / todas.size()) : 0}%
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Citas por estado -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-calendar3 me-2 text-warning"></i>Citas por estado
                    </h5>
                </div>
                <div class="card-body">
                    <c:set var="pendientes"  value="0"/>
                    <c:set var="confirmadas" value="0"/>
                    <c:set var="canceladas"  value="0"/>
                    <c:set var="completadas" value="0"/>
                    <c:forEach var="cita" items="${citas}">
                        <c:if test="${cita.estado == 'pendiente'}">  <c:set var="pendientes"  value="${pendientes+1}"/></c:if>
                        <c:if test="${cita.estado == 'confirmada'}"> <c:set var="confirmadas" value="${confirmadas+1}"/></c:if>
                        <c:if test="${cita.estado == 'cancelada'}">  <c:set var="canceladas"  value="${canceladas+1}"/></c:if>
                        <c:if test="${cita.estado == 'completada'}"> <c:set var="completadas" value="${completadas+1}"/></c:if>
                    </c:forEach>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-hourglass-split me-2 text-warning"></i>Pendientes</span>
                        <span class="badge bg-warning text-dark fs-6">${pendientes}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-check-circle me-2 text-success"></i>Confirmadas</span>
                        <span class="badge bg-success fs-6">${confirmadas}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-x-circle me-2 text-danger"></i>Canceladas</span>
                        <span class="badge bg-danger fs-6">${canceladas}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center p-2 bg-light rounded">
                        <span><i class="bi bi-check-all me-2 text-info"></i>Completadas</span>
                        <span class="badge bg-info fs-6">${completadas}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Usuarios por rol -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-people me-2 text-info"></i>Usuarios por rol
                    </h5>
                </div>
                <div class="card-body">
                    <c:set var="admins"   value="0"/>
                    <c:set var="clientes" value="0"/>
                    <c:set var="inmos"    value="0"/>
                    <c:set var="usuBasic" value="0"/>
                    <c:forEach var="usr" items="${usuarios}">
                        <c:if test="${usr.rolNombre == 'admin'}">        <c:set var="admins"   value="${admins+1}"/></c:if>
                        <c:if test="${usr.rolNombre == 'cliente'}">      <c:set var="clientes" value="${clientes+1}"/></c:if>
                        <c:if test="${usr.rolNombre == 'inmobiliaria'}"> <c:set var="inmos"    value="${inmos+1}"/></c:if>
                        <c:if test="${usr.rolNombre == 'usuario'}">      <c:set var="usuBasic" value="${usuBasic+1}"/></c:if>
                    </c:forEach>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-shield-fill me-2 text-danger"></i>Administradores</span>
                        <span class="badge bg-danger fs-6">${admins}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-building me-2 text-primary"></i>Inmobiliarias</span>
                        <span class="badge bg-primary fs-6">${inmos}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-light rounded">
                        <span><i class="bi bi-person-check me-2 text-success"></i>Clientes</span>
                        <span class="badge bg-success fs-6">${clientes}</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center p-2 bg-light rounded">
                        <span><i class="bi bi-person me-2 text-secondary"></i>Usuarios básicos</span>
                        <span class="badge bg-secondary fs-6">${usuBasic}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabla propiedades disponibles -->
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-list-check me-2 text-success"></i>
                        Propiedades disponibles (${todas.size()})
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Título</th>
                                    <th>Tipo</th>
                                    <th>Operación</th>
                                    <th>Precio</th>
                                    <th>Ciudad</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${todas}">
                                    <tr>
                                        <td class="fw-semibold">${p.titulo}</td>
                                        <td><span class="badge bg-light text-dark border text-capitalize">${p.tipo}</span></td>
                                        <td><span class="badge ${p.operacion == 'venta' ? 'bg-primary' : 'bg-warning text-dark'}">${p.operacion}</span></td>
                                        <td><fmt:formatNumber value="${p.precio}" type="currency" currencyCode="COP" maxFractionDigits="0"/></td>
                                        <td>${p.ciudad}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.disponible}"><span class="badge bg-success">Disponible</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">No disponible</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/fragments/footer.jspf" %>
