package com.inmobiliaria.model;

import java.time.LocalDateTime;

public class Cita {
    private int id;
    private int clienteId;
    private int propiedadId;
    private LocalDateTime fechaCita;
    private String mensaje;
    private String estado;
    private LocalDateTime createdAt;

    public Cita() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getClienteId() { return clienteId; }
    public void setClienteId(int clienteId) { this.clienteId = clienteId; }
    public int getPropiedadId() { return propiedadId; }
    public void setPropiedadId(int propiedadId) { this.propiedadId = propiedadId; }
    public LocalDateTime getFechaCita() { return fechaCita; }
    public void setFechaCita(LocalDateTime fechaCita) { this.fechaCita = fechaCita; }
    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
