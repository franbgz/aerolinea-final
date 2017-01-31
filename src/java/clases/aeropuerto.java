package clases;

public class aeropuerto {

    int id;
    String iata, ciudad, pais;

    //CONSTRUCTORES
    public aeropuerto() {
    }

    public aeropuerto(String ciudad) {
        this.ciudad = ciudad;
    }
    
    

    public aeropuerto(int id, String iata, String ciudad, String pais) {
        this.id = id;
        this.iata = iata;
        this.ciudad = ciudad;
        this.pais = pais;
    }

    // SETTERS AND GETTERS
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIata() {
        return iata;
    }

    public void setIata(String iata) {
        this.iata = iata;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

}
