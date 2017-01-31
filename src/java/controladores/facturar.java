package controladores;

import clases.ConexionBBDD;
import clases.usuario;
import java.io.IOException;
import clases.reserva;
import java.util.ArrayList;
import dao.opFacturar;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class facturar extends HttpServlet {

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

        HttpSession sesion = request.getSession(true);
        usuario usuario = (usuario) sesion.getAttribute("usuario");

        if (usuario != null) {
            opFacturar objOP = new opFacturar();
            try {
                ArrayList<reserva> reservas = new ArrayList();
                reservas = objOP.reservasSinFacturar(usuario, conexion);
                reservas = objOP.completarVuelos(reservas, conexion);
                reservas = objOP.completarPasajeros(reservas, conexion);
                
                sesion.setAttribute("reservas", reservas);
                response.sendRedirect("facturarf1.jsp");
            } catch (SQLException er) {
                String msg = er.getMessage();
                String pth = er.getSQLState();
                sesion.setAttribute("codError", 1);
                sesion.setAttribute("msjError", "Error con la base de datos");
                response.sendRedirect("error.jsp");
            }

        } else {
            sesion.setAttribute("origenlogin", "facturar");
            response.sendRedirect("login.jsp");
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
