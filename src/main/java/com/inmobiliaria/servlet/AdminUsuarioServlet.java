package com.inmobiliaria.servlet;

import com.inmobiliaria.dao.UsuarioDAO;
import com.inmobiliaria.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminUsuarioServlet")
public class AdminUsuarioServlet extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
        String ctx = req.getContextPath();

        if (usuario == null || !usuario.getRolNombre().equals("admin")) {
            resp.sendRedirect(ctx + "/jsp/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");

        try {
            if ("toggle".equals(action) && idStr != null) {
                int id = Integer.parseInt(idStr);
                dao.toggleActivo(id);
                resp.sendRedirect(ctx + "/jsp/admin/dashboard.jsp");
            }
        } catch (Exception e) {
            resp.sendRedirect(ctx + "/jsp/admin/dashboard.jsp?error=" + e.getMessage());
        }
    }
}
