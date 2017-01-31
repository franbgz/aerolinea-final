package controladores;

import clases.servicio;
import clases.reserva;
import clases.bebe;
import java.util.ArrayList;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class guardarServiciosIda extends HttpServlet {

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
                ArrayList<servicio> serviciosida = new ArrayList();
                for (int j = 0; j < serv.size(); j++) {
                    int idServicio = serv.get(j);
                    serviciosida.add(servicios.get(idServicio));
                    if (idServicio == 3) {
                        String nombreBebe = request.getParameter("nombreBebe" + i);
                        String apellidosBebe = request.getParameter("apellidosBebe" + i);
                        String dniBebe = request.getParameter("dniBebe" + i);
                        bebe bebe = new bebe(nombreBebe, apellidosBebe, dniBebe);
                        reserva.getPasajero(i).setBebe(bebe);
                    }
                }

                reserva.getPasajero(i).setServiciosida(serviciosida);
            }
        }catch(NullPointerException er){
            
        }

        sesion.setAttribute("reserva", reserva);
        String tipovuelo = (String) sesion.getAttribute("tipovuelo");
        if (tipovuelo.equals("soloida")) {
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/buscarAsientos");
            rd.forward(request, response);
        } else {
            response.sendRedirect("reservaf3b.jsp");
        }
        /*response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet guardarServiciosIda</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet guardarServiciosIda at " + request.getContextPath() + "</h1>");
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
