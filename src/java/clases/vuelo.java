package clases;

import java.time.LocalDate;
import java.time.LocalTime;

public class vuelo{

    private int id, conexion, disponible, precio;
    private String numero;
    private LocalDate fecha;
    private LocalTime horaSalida, horaLlegada;
    private aeropuerto origen, destino;

    //CONTRUCTORES
    public vuelo() {
    }

    public vuelo(int id) {
        this.id = id;
    }

    public vuelo(int id, int conexion, String numero, LocalDate fecha, LocalTime horaSalida, LocalTime horaLlegada, int disponible, int precio) {
        this.id = id;
        this.conexion = conexion;
        this.disponible = disponible;
        this.precio = precio;
        this.numero = numero;
        this.fecha = fecha;
        this.horaSalida = horaSalida;
        this.horaLlegada = horaLlegada;
    }

    //GETTERS AND SETTERS
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getConexion() {
        return conexion;
    }

    public void setConexion(int conexion) {
        this.conexion = conexion;
    }

    public int getDisponible() {
        return disponible;
    }

    public void setDisponible(int disponible) {
        this.disponible = disponible;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public LocalTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }

    public LocalTime getHoraLlegada() {
        return horaLlegada;
    }

    public void setHoraLlegada(LocalTime horaLlegada) {
        this.horaLlegada = horaLlegada;
    }

    public aeropuerto getOrigen() {
        return origen;
    }

    public void setOrigen(aeropuerto origen) {
        this.origen = origen;
    }

    public aeropuerto getDestino() {
        return destino;
    }

    public void setDestino(aeropuerto destino) {
        this.destino = destino;
    }
    
    public String obtenerDatos(){
        return this.numero + " / " + this.origen.getCiudad()+ "("+ this.origen.getIata()+") - " + this.destino.getCiudad() + "(" + this.destino.getIata() + ")";
    }
    
    public String obtenerFecha(){
        return this.fecha.getDayOfMonth() + "/" + this.fecha.getMonthValue() + "/" + this.fecha.getYear();
    }

    @Override
    public String toString() {
        return this.numero + " / " + this.origen.getIata() + " - " + this.destino.getIata();
    }

    
}
