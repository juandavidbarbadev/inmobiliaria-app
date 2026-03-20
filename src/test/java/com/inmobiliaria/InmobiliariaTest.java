package com.inmobiliaria;

import com.inmobiliaria.dao.CitaDAO;
import com.inmobiliaria.dao.PropiedadDAO;
import com.inmobiliaria.dao.UsuarioDAO;
import com.inmobiliaria.model.Cita;
import com.inmobiliaria.model.Propiedad;
import com.inmobiliaria.model.Usuario;
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Pruebas unitarias para los DAOs del sistema InmobiliariaApp
 * Sprint 3 — Testing unitario con JUnit 4
 */
public class InmobiliariaTest {

    private UsuarioDAO usuarioDAO;
    private PropiedadDAO propiedadDAO;
    private CitaDAO citaDAO;

    @Before
    public void setUp() {
        usuarioDAO   = new UsuarioDAO();
        propiedadDAO = new PropiedadDAO();
        citaDAO      = new CitaDAO();
    }

    // ============================================================
    // PRUEBAS DE CONEXIÓN
    // ============================================================

    @Test
    public void testConexionBD() {
        try {
            Connection conn = com.inmobiliaria.util.DBConnection.getConnection();
            assertNotNull("La conexión no debe ser null", conn);
            assertFalse("La conexión debe estar abierta", conn.isClosed());
            conn.close();
            System.out.println("✅ testConexionBD: PASÓ");
        } catch (SQLException e) {
            fail("Error de conexión: " + e.getMessage());
        }
    }

    // ============================================================
    // PRUEBAS DE USUARIO
    // ============================================================

    @Test
    public void testListarUsuarios() {
        try {
            List<Usuario> usuarios = usuarioDAO.listarTodos();
            assertNotNull("La lista no debe ser null", usuarios);
            assertTrue("Debe haber al menos 2 usuarios", usuarios.size() >= 2);
            System.out.println("✅ testListarUsuarios: PASÓ — " + usuarios.size() + " usuarios encontrados");
        } catch (SQLException e) {
            fail("Error al listar usuarios: " + e.getMessage());
        }
    }

    @Test
    public void testBuscarUsuarioPorId() {
        try {
            Usuario usuario = usuarioDAO.buscarPorId(1);
            assertNotNull("El usuario con ID 1 debe existir", usuario);
            assertEquals("El ID debe ser 1", 1, usuario.getId());
            assertNotNull("El nombre no debe ser null", usuario.getNombre());
            assertNotNull("El rol no debe ser null", usuario.getRolNombre());
            System.out.println("✅ testBuscarUsuarioPorId: PASÓ — Usuario: " + usuario.getNombre());
        } catch (SQLException e) {
            fail("Error al buscar usuario: " + e.getMessage());
        }
    }

    @Test
    public void testLoginCorrecto() {
        try {
            // Usa las credenciales reales que tienes en la BD
            Usuario usuario = usuarioDAO.login("admin@inmobiliaria.com", "Admin123!");
            assertNotNull("El login debe ser exitoso con credenciales correctas", usuario);
            assertEquals("El rol debe ser admin", "admin", usuario.getRolNombre());
            System.out.println("✅ testLoginCorrecto: PASÓ — Rol: " + usuario.getRolNombre());
        } catch (SQLException e) {
            fail("Error en login: " + e.getMessage());
        }
    }

    @Test
    public void testLoginIncorrecto() {
        try {
            Usuario usuario = usuarioDAO.login("admin@inmobiliaria.com", "contraseñaIncorrecta");
            assertNull("El login debe fallar con contraseña incorrecta", usuario);
            System.out.println("✅ testLoginIncorrecto: PASÓ — Login rechazado correctamente");
        } catch (SQLException e) {
            fail("Error en login incorrecto: " + e.getMessage());
        }
    }

    @Test
    public void testEmailExiste() {
        try {
            boolean existe = usuarioDAO.emailExiste("admin@inmobiliaria.com");
            assertTrue("El email del admin debe existir", existe);

            boolean noExiste = usuarioDAO.emailExiste("noexiste@test.com");
            assertFalse("Un email inexistente no debe existir", noExiste);
            System.out.println("✅ testEmailExiste: PASÓ");
        } catch (SQLException e) {
            fail("Error al verificar email: " + e.getMessage());
        }
    }

    // ============================================================
    // PRUEBAS DE PROPIEDAD
    // ============================================================

    @Test
    public void testListarPropiedades() {
        try {
            List<Propiedad> propiedades = propiedadDAO.listar(null, null, null, null);
            assertNotNull("La lista no debe ser null", propiedades);
            assertTrue("Debe haber al menos 1 propiedad", propiedades.size() >= 1);
            System.out.println("✅ testListarPropiedades: PASÓ — " + propiedades.size() + " propiedades");
        } catch (SQLException e) {
            fail("Error al listar propiedades: " + e.getMessage());
        }
    }

    @Test
    public void testFiltrarPropiedadesPorTipo() {
        try {
            List<Propiedad> casas = propiedadDAO.listar("casa", null, null, null);
            assertNotNull("La lista de casas no debe ser null", casas);
            for (Propiedad p : casas) {
                assertEquals("Todas deben ser de tipo casa", "casa", p.getTipo());
            }
            System.out.println("✅ testFiltrarPropiedadesPorTipo: PASÓ — " + casas.size() + " casas");
        } catch (SQLException e) {
            fail("Error al filtrar propiedades: " + e.getMessage());
        }
    }

    @Test
    public void testBuscarPropiedadPorId() {
        try {
            Propiedad prop = propiedadDAO.buscarPorId(1);
            assertNotNull("La propiedad con ID 1 debe existir", prop);
            assertEquals("El ID debe ser 1", 1, prop.getId());
            assertNotNull("El título no debe ser null", prop.getTitulo());
            assertTrue("El precio debe ser positivo", prop.getPrecio().compareTo(BigDecimal.ZERO) > 0);
            System.out.println("✅ testBuscarPropiedadPorId: PASÓ — " + prop.getTitulo());
        } catch (SQLException e) {
            fail("Error al buscar propiedad: " + e.getMessage());
        }
    }

    @Test
    public void testListarPropiedadesPorUsuario() {
        try {
            List<Propiedad> props = propiedadDAO.listarPorUsuario(2);
            assertNotNull("La lista no debe ser null", props);
            for (Propiedad p : props) {
                assertEquals("Todas deben pertenecer al usuario 2", 2, p.getUsuarioId());
            }
            System.out.println("✅ testListarPropiedadesPorUsuario: PASÓ — " + props.size() + " propiedades del usuario 2");
        } catch (SQLException e) {
            fail("Error al listar propiedades por usuario: " + e.getMessage());
        }
    }

    @After
    public void tearDown() {
        System.out.println("--- Test completado ---");
    }
}
