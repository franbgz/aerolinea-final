package clases;

import java.util.ArrayList;
import java.time.LocalDateTime;

public class reserva {
    
    private int id, numpasajeros, precio;
    private vuelo vueloida, vuelovuelta;
    private String codigo;
    private pagador pagador;
    private tarjeta tarjeta;
    private LocalDateTime fecha;
    private usuario usuario;
    private ArrayList<pasajero> pasajeros = new ArrayList();

    public reserva() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumpasajeros() {
        return numpasajeros;
    }

    public void setNumpasajeros(int numpasajeros) {
        this.numpasajeros = numpasajeros;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public vuelo getVueloida() {
        return vueloida;
    }

    public void setVueloida(vuelo vueloida) {
        this.vueloida = vueloida;
    }

    public vuelo getVuelovuelta() {
        return vuelovuelta;
    }

    public void setVuelovuelta(vuelo vuelovuelta) {
        this.vuelovuelta = vuelovuelta;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public pagador getPagador() {
        return pagador;
    }

    public void setPagador(pagador pagador) {
        this.pagador = pagador;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(usuario usuario) {
        this.usuario = usuario;
    }

    public ArrayList<pasajero> getPasajeros() {
        return pasajeros;
    }

    public void setPasajeros(ArrayList<pasajero> pasajeros) {
        this.pasajeros = pasajeros;
    }
    
    public void añadirPasajero(pasajero pasajero){
        pasajeros.add(pasajero);
    }
    
    public pasajero getPasajero(int i){
        return this.pasajeros.get(i);
    }

    public tarjeta getTarjeta() {
        return tarjeta;
    }

    public void setTarjeta(tarjeta tarjeta) {
        this.tarjeta = tarjeta;
    }
    
    
}
