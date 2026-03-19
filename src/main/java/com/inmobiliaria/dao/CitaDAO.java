package com.inmobiliaria.dao;

import com.inmobiliaria.model.Cita;
import com.inmobiliaria.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CitaDAO {

    public boolean insertar(Cita c) throws SQLException {
        String sql = "INSERT INTO citas (cliente_id, propiedad_id, fecha_cita, mensaje, estado) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, c.getClienteId());
            ps.setInt(2, c.getPropiedadId());
            ps.setTimestamp(3, Timestamp.valueOf(c.getFechaCita()));
            ps.setString(4, c.getMensaje());
            ps.setString(5, "pendiente");
            return ps.executeUpdate() > 0;
        }
    }

    public List<Cita> listarPorCliente(int clienteId) throws SQLException {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT * FROM citas WHERE cliente_id = ? ORDER BY fecha_cita DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, clienteId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapRow(rs));
        }
        return lista;
    }

    public List<Cita> listarTodas() throws SQLException {
        List<Cita> lista = new ArrayList<>();
        String sql = "SELECT * FROM citas ORDER BY fecha_cita DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapRow(rs));
        }
        return lista;
    }

    public boolean actualizarEstado(int id, String estado) throws SQLException {
        String sql = "UPDATE citas SET estado = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Cita mapRow(ResultSet rs) throws SQLException {
        Cita c = new Cita();
        c.setId(rs.getInt("id"));
        c.setClienteId(rs.getInt("cliente_id"));
        c.setPropiedadId(rs.getInt("propiedad_id"));
        Timestamp ts = rs.getTimestamp("fecha_cita");
        if (ts != null) c.setFechaCita(ts.toLocalDateTime());
        c.setMensaje(rs.getString("mensaje"));
        c.setEstado(rs.getString("estado"));
        Timestamp ca = rs.getTimestamp("created_at");
        if (ca != null) c.setCreatedAt(ca.toLocalDateTime());
        return c;
    }
}
