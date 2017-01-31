package clases;

import java.time.LocalDate;

public class tarjeta {
    
    private Integer id, usos;
    private String numero, propietario, codseguridad;
    private LocalDate caducidad;

    public tarjeta() {
    }

    public tarjeta(String numero, String propietario, String codseguridad, LocalDate caducidad, int usos) {
        this.usos = usos;
        this.numero = numero;
        this.propietario = propietario;
        this.codseguridad = codseguridad;
        this.caducidad = caducidad;
    }

    public tarjeta(int id, String numero, String propietario, String codseguridad, LocalDate caducidad, int usos) {
        this.id = id;
        this.usos = usos;
        this.numero = numero;
        this.propietario = propietario;
        this.codseguridad = codseguridad;
        this.caducidad = caducidad;
    }

    public Integer getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsos() {
        return usos;
    }

    public void setUsos(int usos) {
        this.usos = usos;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getPropietario() {
        return propietario;
    }

    public void setPropietario(String propietario) {
        this.propietario = propietario;
    }

    public String getCodseguridad() {
        return codseguridad;
    }

    public void setCodseguridad(String codseguridad) {
        this.codseguridad = codseguridad;
    }

    public LocalDate getCaducidad() {
        return caducidad;
    }

    public void setCaducidad(LocalDate caducidad) {
        this.caducidad = caducidad;
    }
    
    

    
}
