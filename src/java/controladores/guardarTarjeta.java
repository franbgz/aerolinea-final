package controladores;

import java.io.IOException;
import clases.reserva;
import clases.base64;
import clases.tarjeta;
import java.time.LocalDate;
import clases.usuario;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class guardarTarjeta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //Se recoge la reserva de la sesion
        HttpSession sesion = request.getSession(true);
        reserva reserva = (reserva) sesion.getAttribute("reserva");
        //Se comprueba la opcion seleccionada y se recogen los datos
        String opcion = request.getParameter("tarjeta");
        if (opcion.equals("new")) {
            tarjeta tarjeta = new tarjeta();
            base64 base64 = new base64();
            tarjeta.setNumero(base64.cifrarBase64(request.getParameter("numero")));
            tarjeta.setPropietario(request.getParameter("propietario"));
            tarjeta.setCodseguridad(request.getParameter("codigo"));

            LocalDate fecha = LocalDate.of(Integer.parseInt(request.getParameter("añoCaducidad")), Integer.parseInt(request.getParameter("mesCaducidad")), 1);
            tarjeta.setCaducidad(fecha);

            reserva.setTarjeta(tarjeta);
            sesion.setAttribute("reserva", reserva);
            response.sendRedirect("reservaf9.jsp");
        } else {
            int idTarjeta = Integer.parseInt(opcion);
            usuario usuario = (usuario)sesion.getAttribute("usuario");
            for (tarjeta tarjeta : usuario.getTarjetas()) {
                if (tarjeta.getId() == idTarjeta) {
                    if (tarjeta.getCodseguridad().equals(request.getParameter("codseguridadtarjeta-" + tarjeta.getId()))) {
                        reserva.setTarjeta(tarjeta);
                        sesion.setAttribute("reserva", reserva);
                        response.sendRedirect("reservaf9.jsp");
                    } else {
                        sesion.setAttribute("codError", 5);
                        response.sendRedirect("reservaf8.jsp");
                    }
                }
            }
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
