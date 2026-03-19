package com.inmobiliaria.servlet;

import com.inmobiliaria.dao.CitaDAO;
import com.inmobiliaria.model.Cita;
import com.inmobiliaria.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/CitaServlet")
public class CitaServlet extends HttpServlet {

    private final CitaDAO dao = new CitaDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
        String ctx = req.getContextPath();

        if (usuario == null) {
            resp.sendRedirect(ctx + "/jsp/login.jsp");
            return;
        }

        try {
            Cita cita = new Cita();
            cita.setClienteId(usuario.getId());
            cita.setPropiedadId(Integer.parseInt(req.getParameter("propiedadId")));
            String fechaStr = req.getParameter("fechaCita");
            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            cita.setFechaCita(LocalDateTime.parse(fechaStr, fmt));
            cita.setMensaje(req.getParameter("mensaje"));

            if (dao.insertar(cita)) {
                resp.sendRedirect(ctx + "/jsp/cliente/dashboard.jsp?exito=Cita+solicitada+exitosamente");
            } else {
                req.setAttribute("error", "No se pudo registrar la cita.");
                req.getRequestDispatcher("/jsp/cliente/solicitar-cita.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/cliente/solicitar-cita.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");
        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
        String ctx = req.getContextPath();

        if (usuario == null) {
            resp.sendRedirect(ctx + "/jsp/login.jsp");
            return;
        }

        try {
            if (idStr != null && (action.equals("confirmar") || action.equals("cancelar"))) {
                int id = Integer.parseInt(idStr);
                String nuevoEstado = action.equals("confirmar") ? "confirmada" : "cancelada";
                dao.actualizarEstado(id, nuevoEstado);
                resp.sendRedirect(ctx + "/jsp/inmobiliaria/reportes.jsp");
            }
        } catch (Exception e) {
            resp.sendRedirect(ctx + "/jsp/inmobiliaria/reportes.jsp");
        }
    }
}
