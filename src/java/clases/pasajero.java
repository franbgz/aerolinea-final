package clases;

import java.time.LocalDate;
import java.util.ArrayList;

public class pasajero {
    
    private Integer id, asientoida, asientovuelta;
    private String nombre, apellidos, pasaporte, genero, edad, nacionalidad, tarjetaida, tarjetavuelta;
    private ArrayList<servicio> serviciosida, serviciosvuelta;
    private bebe bebe;
    private LocalDate fechanac, cadpasaporte;

    public pasajero() {
        this.serviciosida = new ArrayList();
        this.serviciosvuelta = new ArrayList();
    }

    public pasajero(int id, String nombre, String apellidos, String pasaporte, String genero, LocalDate fechanac) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.pasaporte = pasaporte;
        this.genero = genero;
        this.fechanac = fechanac;
        this.serviciosida = new ArrayList();
        this.serviciosvuelta = new ArrayList();
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

    public String getPasaporte() {
        return pasaporte;
    }

    public void setPasaporte(String pasaporte) {
        this.pasaporte = pasaporte;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public LocalDate getFechanac() {
        return fechanac;
    }

    public void setFechanac(LocalDate fechanac) {
        this.fechanac = fechanac;
    }

    public String getEdad() {
        return edad;
    }

    public void setEdad(String edad) {
        this.edad = edad;
    }

    public ArrayList<servicio> getServiciosida() {
        return serviciosida;
    }

    public void setServiciosida(ArrayList<servicio> serviciosida) {
        this.serviciosida = serviciosida;
    }

    public ArrayList<servicio> getServiciosvuelta() {
        return serviciosvuelta;
    }

    public void setServiciosvuelta(ArrayList<servicio> serviciosvuelta) {
        this.serviciosvuelta = serviciosvuelta;
    }

    public bebe getBebe() {
        return bebe;
    }

    public void setBebe(bebe bebe) {
        this.bebe = bebe;
    }

    public Integer getAsientoida() {
        return asientoida;
    }

    public void setAsientoida(int asientoida) {
        this.asientoida = asientoida;
    }

    public Integer getAsientovuelta() {
        return asientovuelta;
    }

    public void setAsientovuelta(int asientovuelta) {
        this.asientovuelta = asientovuelta;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public LocalDate getCadpasaporte() {
        return cadpasaporte;
    }

    public void setCadpasaporte(LocalDate cadpasaporte) {
        this.cadpasaporte = cadpasaporte;
    }

    public String getTarjetaida() {
        return tarjetaida;
    }

    public void setTarjetaida(String tarjetaida) {
        this.tarjetaida = tarjetaida;
    }

    public String getTarjetavuelta() {
        return tarjetavuelta;
    }

    public void setTarjetavuelta(String tarjetavuelta) {
        this.tarjetavuelta = tarjetavuelta;
    }
    
    
}
