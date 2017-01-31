/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import clases.reserva;
import clases.vuelo;
import clases.ConexionBBDD;
import dao.opReserva;
import java.io.IOException;
import java.util.ArrayList;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class buscarAsientos extends HttpServlet {

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

        //Se cogen los datos de la sesion
        HttpSession sesion = request.getSession(true);
        String tipovuelo = (String) sesion.getAttribute("tipovuelo");
        reserva reserva = (reserva) sesion.getAttribute("reserva");

        //Se crea el objeto de operaciones y se llama a la funcion para recibir un arraylist con los huecos libres
        opReserva objOP = new opReserva();
        vuelo vuelo = reserva.getVueloida();
        try {
            boolean[] asientosLibres = objOP.asientosOcupados(vuelo, conexion);
            sesion.setAttribute("asientosLibresIda", asientosLibres);
            response.sendRedirect("reservaf4a.jsp");
        } catch (SQLException er) {
            sesion.setAttribute("codError", 1);
            sesion.setAttribute("msjError", "Error con la base de datos");
            response.sendRedirect("error.jsp");
        }


        /*response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet buscarAsientos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet buscarAsientos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }*/
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
