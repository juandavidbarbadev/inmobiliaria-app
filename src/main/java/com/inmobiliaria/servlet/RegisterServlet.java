package com.inmobiliaria.servlet;

import com.inmobiliaria.dao.UsuarioDAO;
import com.inmobiliaria.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String nombre    = req.getParameter("nombre");
        String apellido  = req.getParameter("apellido");
        String email     = req.getParameter("email");
        String password  = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String telefono  = req.getParameter("telefono");
        String rolParam  = req.getParameter("rol");

        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Todos los campos obligatorios deben completarse.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(password2)) {
            req.setAttribute("error", "Las contraseñas no coinciden.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "La contraseña debe tener al menos 6 caracteres.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
            return;
        }

        try {
            if (usuarioDAO.emailExiste(email)) {
                req.setAttribute("error", "Este email ya está registrado.");
                req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
                return;
            }

            // Determinar rol: solo cliente (3) o usuario (2)
            int rolId = "cliente".equals(rolParam) ? 3 : 2;

            Usuario nuevo = new Usuario(nombre.trim(), apellido.trim(), email.trim(), password, rolId);
            nuevo.setTelefono(telefono);

            if (usuarioDAO.registrar(nuevo)) {
                req.setAttribute("exito", "Registro exitoso. Ya puedes iniciar sesión.");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "No se pudo completar el registro. Intenta de nuevo.");
                req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error del servidor: " + e.getMessage());
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/jsp/register.jsp");
    }
}
