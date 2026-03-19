package com.inmobiliaria.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://127.0.0.1:3306/inmobiliaria_db" +
        "?useSSL=false" +
        "&serverTimezone=America/Bogota" +
        "&allowPublicKeyRetrieval=true" +
        "&useUnicode=true" +
        "&characterEncoding=UTF-8";

    private static final String USER     = "root";
    private static final String PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver MySQL no encontrado: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); }
            catch (SQLException e) {
                System.err.println("Error cerrando conexión: " + e.getMessage());
            }
        }
    }
}