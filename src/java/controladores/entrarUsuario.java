package controladores;

import clases.ConexionBBDD;
import clases.base64;
import clases.usuario;
import dao.opReserva;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class entrarUsuario extends HttpServlet {

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
        
        //Se recogen los datos del form
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        String jspOrigen = request.getParameter("jspOrigen");
        
        //Se cifra la contraseña
        base64 objbase64 = new base64();
        contraseña = objbase64.cifrarBase64(contraseña);

        //Se crea un objeto usuario para realizar la busqueda en la BBDD
        usuario usuario = new usuario(email, contraseña);

        try {
            opReserva objOP = new opReserva();
            usuario = objOP.verificarUsuario(usuario, conexion);
            HttpSession sesion = request.getSession(true);
            if (usuario != null) {
                sesion.setAttribute("usuario", usuario);
                response.sendRedirect(jspOrigen);
            } else {
                sesion.setAttribute("codError", 3);
                response.sendRedirect(jspOrigen);
            }
        } catch (SQLException er) {

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
