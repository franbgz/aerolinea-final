package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import java.io.OutputStream;

import clases.*;
import java.awt.image.BufferedImage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class obtenerQR extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("image/jpeg");

        HttpSession sesion = request.getSession(true);
        int numpasajero = Integer.parseInt(request.getParameter("numpasajero"));
        String tipo = request.getParameter("tipo");
        reserva reservaselec = (reserva) sesion.getAttribute("reservaselec");
        
        QR qr = new QR();

        pasajero pasajero = reservaselec.getPasajero(numpasajero);
        String texto = "";
        if (tipo.equals("ida")) {
            texto += reservaselec.getVueloida().toString() + "\n";
        } else {
            texto += reservaselec.getVuelovuelta().toString() + "\n";
        }
        texto += reservaselec.getCodigo() + "\n";
        texto += pasajero.getNombre() + " " + pasajero.getApellidos() + "\n";
        texto += pasajero.getPasaporte() + " Cad:" + pasajero.getCadpasaporte().toString() + "\n";
        texto += pasajero.getFechanac() + " " + pasajero.getGenero() + "\n";
        texto += pasajero.getNacionalidad() + "\n";
        if (pasajero.getBebe() != null) {
            bebe bebe = pasajero.getBebe();
            texto += "Datos bebe: " + bebe.getNombre() + " " + bebe.getApellidos() + "\n";
        }
        if (tipo.equals("ida")) {
            texto += "Asiento: " + pasajero.getAsientoida() + "\n";
        } else {
            texto += "Asiento: " + pasajero.getAsientovuelta() + "\n";
        }

        BufferedImage bidi = qr.generar(texto);
        try (OutputStream out = response.getOutputStream()) {
            ImageIO.write(bidi, "jpg", out);
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
