package com.mx.utex.Model;

public class BeanProducto {
    private int idproducto;
    private String nombre;
    private BeanDatos idfabricante;
    private String fecharegistro;
    private int status;


    public BeanProducto() {
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public BeanDatos getIdfabricante() {
        return idfabricante;
    }

    public void setIdfabricante(BeanDatos idfabricante) {
        this.idfabricante = idfabricante;
    }

    public String getFecharegistro() {
        return fecharegistro;
    }

    public void setFecharegistro(String fecharegistro) {
        this.fecharegistro = fecharegistro;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
