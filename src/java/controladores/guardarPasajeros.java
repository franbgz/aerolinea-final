/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import clases.ConexionBBDD;
import java.io.IOException;
import java.io.PrintWriter;
import clases.pasajero;
import clases.reserva;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fran
 */
public class guardarPasajeros extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        
        //Cogiendo la reserva de la sesion
        HttpSession sesion = request.getSession(true);
        reserva reserva = (reserva)sesion.getAttribute("reserva");
        
        //Recuperando el numero de pasajeros de la reserva
        int pasajeros = reserva.getNumpasajeros();
        
        //Creando pasajeros a partir de los datos del formulario e insertandolos en el arraylist de reserva
        for (int i = 1; i <= pasajeros; i++) {
            pasajero pasajero = new pasajero();
            pasajero.setNombre(request.getParameter("nombre"+i));
            pasajero.setApellidos(request.getParameter("apellidos"+i));
            pasajero.setPasaporte(request.getParameter("dni"+i));
            pasajero.setGenero(request.getParameter("genero"+i));
            pasajero.setEdad(request.getParameter("edad"+i));
            pasajero.setNacionalidad(request.getParameter("nacionalidad"+i));
            
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            pasajero.setFechanac(LocalDate.parse(request.getParameter("fechanac"+i), dtf));
            pasajero.setCadpasaporte(LocalDate.parse(request.getParameter("cadpasaporte"+i), dtf));
            
            reserva.añadirPasajero(pasajero);
        }
        
        //Redirigiendo al servlet buscarSevicios
        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher("/buscarServicios");
        rd.forward(request, response);
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
