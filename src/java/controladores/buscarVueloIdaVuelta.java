/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import clases.ConexionBBDD;
import clases.aeropuerto;
import clases.vuelo;
import dao.opReserva;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fran
 */
public class buscarVueloIdaVuelta extends HttpServlet {

    //VARIABLE GOBLAL
    Connection conexion;

    @Override
    public void init() throws ServletException {
        try {
            ConexionBBDD ConexBD = ConexionBBDD.GetConexion();
            conexion = ConexBD.GetCon();
        } catch (ClassNotFoundException | SQLException cnfe) {
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //SE COGEN LAS CIUDAD DE ORIGEN Y DESTINO
        String origen = request.getParameter("origen");
        String destino = request.getParameter("destino");

        //SE CREAN LOS AEROPUERTOS CON EL NOMBRE DE LA CIUDAD PARA COMPLETARLOS MAS ADELANTE
        aeropuerto aerorigen = new aeropuerto(origen);
        aeropuerto aerodestino = new aeropuerto(destino);

        //SE COGE LA FECHA Y SE CONVIERTE A OBJETO LOCALDATE
        String sa = request.getParameter("ida");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate salida = LocalDate.parse(sa, dtf);

        String vu = request.getParameter("vuelta");
        LocalDate vuelta = LocalDate.parse(vu, dtf);

        //SE COGE EL NUMERO DE VIAJEROS
        int viajeros = Integer.parseInt(request.getParameter("viajeros"));

        //SE CREA EL OBJETO DE OPERACIONES DE RESERVA Y SE LLAMA AL METODO PARA BUSCAR VUELOS
        opReserva objOP = new opReserva();
        try {
            aerorigen = objOP.buscarAeropuerto(aerorigen, conexion);
            aerodestino = objOP.buscarAeropuerto(aerodestino, conexion);
            ArrayList<vuelo> vuelosida = objOP.buscarVuelo(aerorigen, aerodestino, salida, conexion);
            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("vuelosida", vuelosida);

            ArrayList<vuelo> vuelosvuelta = objOP.buscarVuelo(aerodestino, aerorigen, vuelta, conexion);
            sesion.setAttribute("vuelosvuelta", vuelosvuelta);
            sesion.setAttribute("tipovuelo", "idavuelta");
            sesion.setAttribute("viajeros", viajeros);
            sesion.setAttribute("aeropuertorigen", aerorigen);
            sesion.setAttribute("aeropuertodestino", aerodestino);
            response.sendRedirect("reservaf1.jsp");
        } catch (SQLException er) {
            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("codError", 1);
            sesion.setAttribute("msjError", "Error con la base de datos");
            response.sendRedirect("error.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
