package com.inmobiliaria.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Propiedad {
    private int id;
    private String titulo;
    private String descripcion;
    private String tipo;
    private String operacion;
    private BigDecimal precio;
    private double areaM2;
    private int habitaciones;
    private int banos;
    private int parqueaderos;
    private String direccion;
    private String ciudad;
    private String barrio;
    private String fotoPrincipal;
    private boolean disponible;
    private int usuarioId;
    private LocalDateTime createdAt;

    public Propiedad() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getOperacion() { return operacion; }
    public void setOperacion(String operacion) { this.operacion = operacion; }
    public BigDecimal getPrecio() { return precio; }
    public void setPrecio(BigDecimal precio) { this.precio = precio; }
    public double getAreaM2() { return areaM2; }
    public void setAreaM2(double areaM2) { this.areaM2 = areaM2; }
    public int getHabitaciones() { return habitaciones; }
    public void setHabitaciones(int habitaciones) { this.habitaciones = habitaciones; }
    public int getBanos() { return banos; }
    public void setBanos(int banos) { this.banos = banos; }
    public int getParqueaderos() { return parqueaderos; }
    public void setParqueaderos(int parqueaderos) { this.parqueaderos = parqueaderos; }
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }
    public String getBarrio() { return barrio; }
    public void setBarrio(String barrio) { this.barrio = barrio; }
    public String getFotoPrincipal() { return fotoPrincipal; }
    public void setFotoPrincipal(String fotoPrincipal) { this.fotoPrincipal = fotoPrincipal; }
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    public int getUsuarioId() { return usuarioId; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
