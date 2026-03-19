package com.inmobiliaria.servlet;

import com.inmobiliaria.dao.PropiedadDAO;
import com.inmobiliaria.model.Propiedad;
import com.inmobiliaria.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/PropiedadServlet")
public class PropiedadServlet extends HttpServlet {

    private final PropiedadDAO dao = new PropiedadDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");

        if (usuario == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String ctx = req.getContextPath();

        try {
            if ("agregar".equals(action)) {
                Propiedad p = buildPropiedad(req);
                p.setUsuarioId(usuario.getId());
                if (dao.insertar(p)) {
                    resp.sendRedirect(ctx + "/jsp/inmobiliaria/dashboard.jsp?exito=Propiedad+agregada+exitosamente");
                } else {
                    req.setAttribute("error", "No se pudo agregar la propiedad.");
                    req.getRequestDispatcher("/jsp/inmobiliaria/agregar-propiedad.jsp").forward(req, resp);
                }

            } else if ("editar".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Propiedad p = buildPropiedad(req);
                p.setId(id);
                p.setDisponible("true".equals(req.getParameter("disponible")));
                if (dao.actualizar(p)) {
                    resp.sendRedirect(ctx + "/jsp/inmobiliaria/dashboard.jsp?exito=Propiedad+actualizada+exitosamente");
                } else {
                    req.setAttribute("error", "No se pudo actualizar la propiedad.");
                    req.getRequestDispatcher("/jsp/inmobiliaria/editar-propiedad.jsp?id=" + id).forward(req, resp);
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/inmobiliaria/dashboard.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
        String ctx = req.getContextPath();

        if (usuario == null) {
            resp.sendRedirect(ctx + "/jsp/login.jsp");
            return;
        }

        if ("eliminar".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.eliminar(id);
                resp.sendRedirect(ctx + "/jsp/inmobiliaria/dashboard.jsp?exito=Propiedad+eliminada+exitosamente");
            } catch (Exception e) {
                resp.sendRedirect(ctx + "/jsp/inmobiliaria/dashboard.jsp?error=No+se+pudo+eliminar");
            }
        }
    }

    private Propiedad buildPropiedad(HttpServletRequest req) {
        Propiedad p = new Propiedad();
        p.setTitulo(req.getParameter("titulo"));
        p.setDescripcion(req.getParameter("descripcion"));
        p.setTipo(req.getParameter("tipo"));
        p.setOperacion(req.getParameter("operacion"));

        String precioStr = req.getParameter("precio");
        if (precioStr != null && !precioStr.isEmpty()) {
            p.setPrecio(new BigDecimal(precioStr));
        }

        String areaStr = req.getParameter("areaM2");
        if (areaStr != null && !areaStr.isEmpty()) {
            p.setAreaM2(Double.parseDouble(areaStr));
        }

        String habStr = req.getParameter("habitaciones");
        p.setHabitaciones(habStr != null && !habStr.isEmpty() ? Integer.parseInt(habStr) : 0);

        String banosStr = req.getParameter("banos");
        p.setBanos(banosStr != null && !banosStr.isEmpty() ? Integer.parseInt(banosStr) : 0);

        String parqStr = req.getParameter("parqueaderos");
        p.setParqueaderos(parqStr != null && !parqStr.isEmpty() ? Integer.parseInt(parqStr) : 0);

        p.setCiudad(req.getParameter("ciudad"));
        p.setBarrio(req.getParameter("barrio"));
        p.setDireccion(req.getParameter("direccion"));
        p.setDisponible(true);
        return p;
    }
}
