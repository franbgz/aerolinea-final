package controladores;

import clases.ConexionBBDD;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import clases.usuario;
import clases.base64;
import clases.reserva;
import dao.opReserva;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class registrarUsuario extends HttpServlet {

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

        //Recoger los datos del formulario
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        String repcontraseña = request.getParameter("repetircontraseña");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");
        String fechanac = request.getParameter("fechanac");

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate fechanacimiento = LocalDate.parse(fechanac, dtf);

        //Se comprueba que las contraseña coinciden
        HttpSession sesion = request.getSession(true);
        if (contraseña.equals(repcontraseña)) {
            //Se crea un objeto de base64 para cifrar la contraseña
            base64 objbase64 = new base64();
            contraseña = objbase64.cifrarBase64(contraseña);

            //Se crea un objeto usuario a partir de los datos obtenidos
            usuario usuario = new usuario(email, contraseña, nombre, apellidos, telefono, fechanacimiento);

            //Se crea el objeto de operaciones reserva y se invoca al metodo para insertar un nuevo usuario
            opReserva objOP = new opReserva();
            try {
                int idUsuario = objOP.registrarUsuario(usuario, conexion);
                usuario.setId(idUsuario);
                reserva reserva = (reserva) sesion.getAttribute("reserva");
                reserva.setUsuario(usuario);
                sesion.setAttribute("reserva", reserva);
                sesion.setAttribute("usuario", usuario);

                ServletContext sc = getServletContext();
                RequestDispatcher rd = sc.getRequestDispatcher("/buscarPagadores");
                rd.forward(request, response);
            } catch (SQLException er) {
                int cod = er.getErrorCode();
                if (er.getErrorCode() == 1062) {
                    sesion.setAttribute("codError", 2);
                    response.sendRedirect("reservaf6.jsp");
                } else {
                    sesion.setAttribute("codError", 1);
                    sesion.setAttribute("msjError", "Error con la base de datos");
                    response.sendRedirect("error.jsp");
                }
            }
        } else {
            sesion.setAttribute("codError", 1);
            response.sendRedirect("reservaf6.jsp");
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
