package clases;

import java.util.ArrayList;

public class pagador {
    
    private Integer id;
    private String nombre, apellidos, dni, direccion, poblacion;

    public pagador() {
    }

    public pagador(String nombre, String apellidos, String dni, String direccion, String poblacion) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = dni;
        this.direccion = direccion;
        this.poblacion = poblacion;
    }

    public pagador(int id, String nombre, String apellidos, String pasaporte, String direccion, String poblacion) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = pasaporte;
        this.direccion = direccion;
        this.poblacion = poblacion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getPoblacion() {
        return poblacion;
    }

    public void setPoblacion(String poblacion) {
        this.poblacion = poblacion;
    }

    
}
