package com.inmobiliaria.dao;

import com.inmobiliaria.model.Usuario;
import com.inmobiliaria.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean registrar(Usuario u) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, apellido, email, password, telefono, rol_id) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getEmail());
            ps.setString(4, BCrypt.hashpw(u.getPassword(), BCrypt.gensalt()));
            ps.setString(5, u.getTelefono());
            ps.setInt(6, u.getRolId() == 0 ? 2 : u.getRolId());
            return ps.executeUpdate() > 0;
        }
    }

    public Usuario login(String email, String password) throws SQLException {
        String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                     "JOIN roles r ON u.rol_id = r.id " +
                     "WHERE u.email = ? AND u.activo = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hash = rs.getString("password");
                if (BCrypt.checkpw(password, hash)) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    public boolean emailExiste(String email) throws SQLException {
        String sql = "SELECT id FROM usuarios WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        }
    }

    public List<Usuario> listarTodos() throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                     "JOIN roles r ON u.rol_id = r.id ORDER BY u.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapRow(rs));
        }
        return lista;
    }

    public Usuario buscarPorId(int id) throws SQLException {
        String sql = "SELECT u.*, r.nombre as rol_nombre FROM usuarios u " +
                     "JOIN roles r ON u.rol_id = r.id WHERE u.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public boolean toggleActivo(int id) throws SQLException {
        String sql = "UPDATE usuarios SET activo = NOT activo WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean actualizar(Usuario u) throws SQLException {
        String sql = "UPDATE usuarios SET nombre=?, apellido=?, telefono=?, rol_id=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getTelefono());
            ps.setInt(4, u.getRolId());
            ps.setInt(5, u.getId());
            return ps.executeUpdate() > 0;
        }
    }

    private Usuario mapRow(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setEmail(rs.getString("email"));
        u.setTelefono(rs.getString("telefono"));
        u.setFoto(rs.getString("foto"));
        u.setRolId(rs.getInt("rol_id"));
        u.setRolNombre(rs.getString("rol_nombre"));
        u.setActivo(rs.getBoolean("activo"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) u.setCreatedAt(ts.toLocalDateTime());
        return u;
    }
}
