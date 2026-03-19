package com.inmobiliaria.servlet;

import com.inmobiliaria.dao.UsuarioDAO;
import com.inmobiliaria.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Usuario usuario = usuarioDAO.login(email, password);

            if (usuario != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("usuario", usuario);
                session.setAttribute("rolNombre", usuario.getRolNombre());
                session.setMaxInactiveInterval(30 * 60);

                // Redirigir según rol
                String ctx = req.getContextPath();
                switch (usuario.getRolNombre()) {
                    case "admin":        resp.sendRedirect(ctx + "/jsp/admin/dashboard.jsp");        break;
                    case "inmobiliaria": resp.sendRedirect(ctx + "/jsp/inmobiliaria/dashboard.jsp"); break;
                    case "cliente":      resp.sendRedirect(ctx + "/jsp/cliente/dashboard.jsp");      break;
                    default:             resp.sendRedirect(ctx + "/jsp/usuario/dashboard.jsp");      break;
                }
            } else {
                req.setAttribute("error", "Email o contraseña incorrectos.");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error del servidor: " + e.getMessage());
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
    }
}
