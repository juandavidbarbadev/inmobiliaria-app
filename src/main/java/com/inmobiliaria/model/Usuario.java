package com.inmobiliaria.model;

import java.time.LocalDateTime;

public class Usuario {
    private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String password;
    private String telefono;
    private String foto;
    private int rolId;
    private String rolNombre;
    private boolean activo;
    private LocalDateTime createdAt;

    public Usuario() {}

    public Usuario(String nombre, String apellido, String email, String password, int rolId) {
        this.nombre   = nombre;
        this.apellido = apellido;
        this.email    = email;
        this.password = password;
        this.rolId    = rolId;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    public String getNombreCompleto() { return nombre + " " + apellido; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public String getFoto() { return foto; }
    public void setFoto(String foto) { this.foto = foto; }
    public int getRolId() { return rolId; }
    public void setRolId(int rolId) { this.rolId = rolId; }
    public String getRolNombre() { return rolNombre; }
    public void setRolNombre(String rolNombre) { this.rolNombre = rolNombre; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
