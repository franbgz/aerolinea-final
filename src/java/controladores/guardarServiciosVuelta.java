package controladores;

import clases.servicio;
import clases.reserva;
import java.util.ArrayList;
import java.io.IOException;
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
public class guardarServiciosVuelta extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(true);
        reserva reserva = (reserva) sesion.getAttribute("reserva");
        ArrayList<servicio> servicios = (ArrayList) sesion.getAttribute("servicios");

        try {
            for (int i = 0; i < reserva.getNumpasajeros(); i++) {
                ArrayList<servicio> serviciospasajero = new ArrayList();
                String[] serviciosactivos = request.getParameterValues("servicio-" + i);
                ArrayList<Integer> serv = new ArrayList();
                for (String serviciosactivo : serviciosactivos) {
                    serv.add(Integer.parseInt(serviciosactivo));
                }
                ArrayList<servicio> serviciosvuelta = new ArrayList();
                for (int j = 0; j < serv.size(); j++) {
                    int idServicio = serv.get(j);
                    serviciosvuelta.add(servicios.get(idServicio));
                }
                
                if(reserva.getPasajero(i).getBebe() != null){
                    serviciosvuelta.add(servicios.get(3));
                }

                reserva.getPasajero(i).setServiciosvuelta(serviciosvuelta);
            }
        }catch(NullPointerException er){
            
        }

        sesion.setAttribute("reserva", reserva);

        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher("/buscarAsientos");
        rd.forward(request, response);
        /*response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet guardarServiciosVuelta</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet guardarServiciosVuelta at " + request.getContextPath() + "</h1>");
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
