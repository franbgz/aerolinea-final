/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import clases.ConexionBBDD;
import java.io.IOException;
import dao.opReserva;
import clases.usuario;
import clases.tarjeta;
import java.util.ArrayList;
import javax.servlet.ServletException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class buscarTarjetas extends HttpServlet {

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

        //Se recoge el usuario de la sesion
        HttpSession sesion = request.getSession(true);
        usuario usuario = (usuario) sesion.getAttribute("usuario");

        //Se crea el objeto operaciones reserva y se invoca al metodo de recoger las tarjetas de un usuario
        opReserva objOP = new opReserva();
        try {
            ArrayList<tarjeta> tarjetas = objOP.buscarTarjetas(usuario, conexion);
            usuario.setTarjetas(tarjetas);
            sesion.setAttribute("usuario", usuario);
            response.sendRedirect("reservaf8.jsp");
        } catch (SQLException er) {
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
