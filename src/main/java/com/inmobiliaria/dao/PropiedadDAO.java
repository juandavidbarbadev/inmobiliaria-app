package com.inmobiliaria.dao;

import com.inmobiliaria.model.Propiedad;
import com.inmobiliaria.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropiedadDAO {

    /** Lista propiedades disponibles con filtros opcionales */
    public List<Propiedad> listar(String tipo, String operacion, String ciudad, Double precioMax) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM propiedades WHERE disponible = 1");
        List<Object> params = new ArrayList<>();

        if (tipo != null && !tipo.isEmpty()) {
            sql.append(" AND tipo = ?"); params.add(tipo);
        }
        if (operacion != null && !operacion.isEmpty()) {
            sql.append(" AND operacion = ?"); params.add(operacion);
        }
        if (ciudad != null && !ciudad.isEmpty()) {
            sql.append(" AND ciudad LIKE ?"); params.add("%" + ciudad + "%");
        }
        if (precioMax != null && precioMax > 0) {
            sql.append(" AND precio <= ?"); params.add(precioMax);
        }
        sql.append(" ORDER BY created_at DESC");

        List<Propiedad> lista = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapRow(rs));
        }
        return lista;
    }

    /** Busca propiedad por ID */
    public Propiedad buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM propiedades WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    /** Propiedades de un usuario específico (inmobiliaria) */
    public List<Propiedad> listarPorUsuario(int usuarioId) throws SQLException {
        String sql = "SELECT * FROM propiedades WHERE usuario_id = ? ORDER BY created_at DESC";
        List<Propiedad> lista = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapRow(rs));
        }
        return lista;
    }

    /** Inserta nueva propiedad */
    public boolean insertar(Propiedad p) throws SQLException {
        String sql = "INSERT INTO propiedades (titulo,descripcion,tipo,operacion,precio,area_m2,habitaciones,banos,parqueaderos,direccion,ciudad,barrio,foto_principal,usuario_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getTipo());
            ps.setString(4, p.getOperacion());
            ps.setBigDecimal(5, p.getPrecio());
            ps.setDouble(6, p.getAreaM2());
            ps.setInt(7, p.getHabitaciones());
            ps.setInt(8, p.getBanos());
            ps.setInt(9, p.getParqueaderos());
            ps.setString(10, p.getDireccion());
            ps.setString(11, p.getCiudad());
            ps.setString(12, p.getBarrio());
            ps.setString(13, p.getFotoPrincipal() != null ? p.getFotoPrincipal() : "prop_default.jpg");
            ps.setInt(14, p.getUsuarioId());
            return ps.executeUpdate() > 0;
        }
    }

    /** Actualiza propiedad existente */
    public boolean actualizar(Propiedad p) throws SQLException {
        String sql = "UPDATE propiedades SET titulo=?,descripcion=?,tipo=?,operacion=?,precio=?,area_m2=?,habitaciones=?,banos=?,parqueaderos=?,direccion=?,ciudad=?,barrio=?,disponible=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getTipo());
            ps.setString(4, p.getOperacion());
            ps.setBigDecimal(5, p.getPrecio());
            ps.setDouble(6, p.getAreaM2());
            ps.setInt(7, p.getHabitaciones());
            ps.setInt(8, p.getBanos());
            ps.setInt(9, p.getParqueaderos());
            ps.setString(10, p.getDireccion());
            ps.setString(11, p.getCiudad());
            ps.setString(12, p.getBarrio());
            ps.setBoolean(13, p.isDisponible());
            ps.setInt(14, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /** Elimina propiedad por ID */
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM propiedades WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Propiedad mapRow(ResultSet rs) throws SQLException {
        Propiedad p = new Propiedad();
        p.setId(rs.getInt("id"));
        p.setTitulo(rs.getString("titulo"));
        p.setDescripcion(rs.getString("descripcion"));
        p.setTipo(rs.getString("tipo"));
        p.setOperacion(rs.getString("operacion"));
        p.setPrecio(rs.getBigDecimal("precio"));
        p.setAreaM2(rs.getDouble("area_m2"));
        p.setHabitaciones(rs.getInt("habitaciones"));
        p.setBanos(rs.getInt("banos"));
        p.setParqueaderos(rs.getInt("parqueaderos"));
        p.setDireccion(rs.getString("direccion"));
        p.setCiudad(rs.getString("ciudad"));
        p.setBarrio(rs.getString("barrio"));
        p.setFotoPrincipal(rs.getString("foto_principal"));
        p.setDisponible(rs.getBoolean("disponible"));
        p.setUsuarioId(rs.getInt("usuario_id"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());
        return p;
    }
}
