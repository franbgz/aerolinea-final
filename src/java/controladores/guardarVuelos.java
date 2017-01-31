package controladores;

import clases.ConexionBBDD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.*;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

public class guardarVuelos extends HttpServlet {

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
        
        //Recogiendo la sesion
        HttpSession sesion = request.getSession(true);
        String tipovuelo = (String)sesion.getAttribute("tipovuelo");
        
        //Recogiendo informacion de los selecionados
        int vueloida = Integer.parseInt(request.getParameter("vueloida"));
        
        
        //Creando el objeto reserva
        reserva reserva = new reserva();
        
        //Recogiendo de nuevo los arraylist de vuelos y buscando el seleccionado
        ArrayList<vuelo> vuelosida = (ArrayList)sesion.getAttribute("vuelosida");
        for (vuelo vuelo : vuelosida) {
            if(vuelo.getId() == vueloida){
                reserva.setVueloida(vuelo);
            }
        }
        
        if(tipovuelo.equals("idavuelta")){
            int vuelovuelta = Integer.parseInt(request.getParameter("vuelovuelta"));
            ArrayList<vuelo> vuelosvuelta = (ArrayList<vuelo>)sesion.getAttribute("vuelosvuelta");
            for(vuelo vuelo : vuelosvuelta){
                if(vuelo.getId() == vuelovuelta){
                    reserva.setVuelovuelta(vuelo);
                }
            }
        }
        
        //Guardando el numero de viajeros y guardando la reserva en la sesion
        reserva.setNumpasajeros((Integer)sesion.getAttribute("viajeros"));
        reserva.setPrecio(reserva.getVueloida().getPrecio()*reserva.getNumpasajeros());
        if(reserva.getVuelovuelta() != null){
            reserva.setPrecio(reserva.getPrecio() + reserva.getVuelovuelta().getPrecio()*reserva.getNumpasajeros());
        }
        sesion.setAttribute("reserva", reserva);
        
        //Redirigiendo hacian el JSP fase 2
        response.sendRedirect("reservaf2.jsp");
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
