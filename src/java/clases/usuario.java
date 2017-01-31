package clases;

import java.time.LocalDate;
import java.util.ArrayList;

public class usuario {

    private int id;
    private String email, pass, nombre, apellidos, telefono;
    private LocalDate fechanac;
    private ArrayList<pagador> pagadores;
    private ArrayList<tarjeta> tarjetas;

    // CONTRUCTORES
    public usuario() {
        this.pagadores = new ArrayList();
        this.tarjetas = new ArrayList();
    }

    public usuario(String email, String pass) {
        this.email = email;
        this.pass = pass;
        this.pagadores = new ArrayList();
        this.tarjetas = new ArrayList();
    }

    public usuario(String email, String pass, String nombre, String apellidos, String telefono, LocalDate fechanac) {
        this.email = email;
        this.pass = pass;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.fechanac = fechanac;
        this.pagadores = new ArrayList();
        this.tarjetas = new ArrayList();
    }

    public usuario(int id, String email, String pass, String nombre, String apellidos, LocalDate fechanac) {
        this.id = id;
        this.email = email;
        this.pass = pass;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.fechanac = fechanac;
        this.pagadores = new ArrayList();
        this.tarjetas = new ArrayList();
    }

    // SETTERS AND GETTERS
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
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

    public LocalDate getFechanac() {
        return fechanac;
    }

    public void setFechanac(LocalDate fechanac) {
        this.fechanac = fechanac;
    }

    public ArrayList<pagador> getPagadores() {
        return pagadores;
    }

    public void setPagadores(ArrayList<pagador> pagadores) {
        this.pagadores = pagadores;
    }
    
    public void añadirPagador(pagador pagador){
        this.pagadores.add(pagador);
    }

    public ArrayList<tarjeta> getTarjetas() {
        return tarjetas;
    }

    public void setTarjetas(ArrayList<tarjeta> tarjetas) {
        this.tarjetas = tarjetas;
    }

    public void añadirTarjeta(tarjeta tarjeta){
        this.tarjetas.add(tarjeta);
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    
}
