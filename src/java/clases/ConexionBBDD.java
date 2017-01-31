package clases;

import java.sql.*;

public class ConexionBBDD {

    private static ConexionBBDD UnicaConexion = null;
    private Connection Conex;

    private ConexionBBDD() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        String connectionUrl = "jdbc:mysql://localhost:3306/dhairline";
        Conex = DriverManager.getConnection(connectionUrl, "root", "root");
    }

    public synchronized static ConexionBBDD GetConexion() throws ClassNotFoundException, SQLException {

        if (UnicaConexion == null) {
            UnicaConexion = new ConexionBBDD();
        }
        return UnicaConexion;
    }

    public Connection GetCon() {
        return Conex;
    }

    public void Destroy() throws SQLException {
        Conex.close();
    }
}
