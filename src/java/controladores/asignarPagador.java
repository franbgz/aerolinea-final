package controladores;

import clases.reserva;
import clases.pagador;
import java.util.ArrayList;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class asignarPagador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //Se recoge la reserva de sesion
        HttpSession sesion = request.getSession(true);
        reserva reserva = (reserva) sesion.getAttribute("reserva");
        //Se comprueba la opcion seleccionada y se recogen los datos
        String opcion = request.getParameter("pagador");
        if (opcion.equals("new")) {
            String nombre = request.getParameter("nombrePagador");
            String apellidos = request.getParameter("apellidosPagador");
            String dni = request.getParameter("dniPagador");
            String direccion = request.getParameter("direccionPagador");
            String poblacion = request.getParameter("poblacionPagador");
            pagador pagador = new pagador(nombre, apellidos, dni, direccion, poblacion);

            reserva.setPagador(pagador);
        } else {
            ArrayList<pagador> pagadores = (ArrayList) sesion.getAttribute("pagadores");
            int idPagador = Integer.parseInt(opcion);
            for (pagador pagador : pagadores) {
                if (pagador.getId() == idPagador) {
                    reserva.setPagador(pagador);
                }
            }
        }

        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher("/buscarTarjetas");
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
