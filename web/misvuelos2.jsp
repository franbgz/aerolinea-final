<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.vuelo" %>
<%@page import="clases.pasajero" %>
<%@page import="clases.aeropuerto"%>
<%@page import="clases.servicio" %>
<%@page import="clases.bebe" %>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.reserva"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%
    int vueloElegido = Integer.parseInt(request.getParameter("idReserva"));
    ArrayList<reserva> reservas = (ArrayList) session.getAttribute("vuelos");
    reserva reservaElegida = new reserva();
    for(reserva reserva : reservas){
        if(reserva.getId() == vueloElegido){
            reservaElegida = reserva;
            break;
        }
    }
    ArrayList<vuelo> vuelosida = (ArrayList<vuelo>) session.getAttribute("vuelosida");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = reservaElegida.getVueloida().getOrigen();
    aeropuerto aerodestino = reservaElegida.getVueloida().getDestino();
    ArrayList<pasajero> pasajeros = reservaElegida.getPasajeros();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="images/icons/favicon.png" type="image/png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>DreamHack Airline - Reserva</title>
        <link rel="stylesheet" href="css/cusom-theme.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/jquery-ui.theme.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/jquery-ui.structure.css">
        <script src="js/jquery-2.2.2.js"></script>
        <script src="js/main.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/aux.js" type="text/javascript"></script>
    </head>

    <body>
        <nav class="navbar navbar-inverse" role="navigation">
            <!-- El logotipo y el icono que despliega el menú se agrupan
       para mostrarlos mejor en los dispositivos móviles -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Desplegar navegación</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">DreamHack Airline</a>
            </div>
            <!-- Agrupar los enlaces de navegación, los formularios y cualquier
       otro elemento que se pueda ocultar al minimizar la barra -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="index.jsp">INICIO</a></li>
                    <li><a href="facturar">CHECK-IN WEB</a></li>
                    <li><a href="misvuelos">MIS VUELOS</a></li>
                </ul>
                <%
                    if (usuario != null) {
                %>
                <form class="navbar-form navbar-right" role="search" action="limpiarUsuario">
                    <div class="form-group texto-usuario">
                        Bienvenido, <% out.println(usuario.getNombre());%>
                    </div>
                    <button type="submit" class="btn btn-primary">Salir</button>
                </form>

                <%} else {%>
                <form class="navbar-form navbar-right" role="search" action="entrarUsuario">
                    <div class="form-group">
                        <input type="email" id="email" name="email" class="form-control" placeholder="e-mail" required>
                        <input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Contraseña" required>
                        <input type="hidden" name="jspOrigen" value="reservaf5.jsp">
                    </div>
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </form>
                <%}%>
            </div>
        </nav>
        <div class="container">

            <div class="row">
                <div class="col-md-10 col-md-offset-1 cuerporeserva">
                    <img src="images/logo.png" height="57" style="float: right;">
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px; color: #a0bac5"><span style="color: #152329;">Reserva</span> <span style="color: #ff6600;"><% out.print(reservaElegida.getCodigo()); %></span></h2>
                    <div class="cuerporesumen">
                            
                            <div class="tituloresumen">Vuelo</div>
                            <table class="tablaresumen">
                                <% int cantidadtotal = 0; %>
                                <tr>
                                    <td class="tdelemento"><% out.print(aerorigen.getCiudad() + "(" + aerorigen.getIata() + ")" + " - " + aerodestino.getCiudad() + "(" + aerodestino.getIata() + ") [" + reservaElegida.getVueloida().getNumero() + "] x" + reservaElegida.getNumpasajeros() + " pasajero/s"); %></td>
                                    <td class="tdprecio"><% out.print((reservaElegida.getVueloida().getPrecio() * reservaElegida.getNumpasajeros()) + " €"); %></td>
                                    <% int cantidadvuelo = reservaElegida.getVueloida().getPrecio() * reservaElegida.getNumpasajeros(); %>
                                </tr>
                                <%
                                    if (reservaElegida.getVuelovuelta() != null) {%>
                                <tr>
                                    <td class="tdelemento"><% out.print(aerodestino.getCiudad() + "(" + aerodestino.getIata() + ")" + " - " + aerorigen.getCiudad() + "(" + aerorigen.getIata() + ") [" + reservaElegida.getVuelovuelta().getNumero() + "] x" + reservaElegida.getNumpasajeros() + " pasajero/s"); %></td>
                                    <td class="tdprecio"><% out.print((reservaElegida.getVuelovuelta().getPrecio() * reservaElegida.getNumpasajeros()) + " €"); %></td>
                                    <% cantidadvuelo = cantidadvuelo + reservaElegida.getVuelovuelta().getPrecio() * reservaElegida.getNumpasajeros(); %>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td class="tdelemento bold">Total</td>
                                    <td class="tdprecio bold"><% out.print(cantidadvuelo + " €");%></td>
                                    <% cantidadtotal += cantidadvuelo; %>
                                </tr>
                            </table>
                            <div class="tituloresumen">Pasajeros</div>
                            <table class="tablaresumen">
                                <%
                                    for (pasajero pasajero : reservaElegida.getPasajeros()) {%>
                                <tr>
                                    <td><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos()); %></td>
                                    <td><% out.print(pasajero.getPasaporte()); %></td>
                                    <td><% out.print(formatter.format(pasajero.getFechanac())); %></td>
                                    <td><% out.print(pasajero.getGenero()); %></td>
                                    <td><% out.print(pasajero.getNacionalidad()); %></td>
                                </tr>

                                <%if (pasajero.getBebe() != null) {
                                        bebe bebe = pasajero.getBebe();
                                %>
                                <tr>
                                    <td><% out.print(bebe.getNombre() + " " + bebe.getApellidos()); %></td>
                                    <td><% out.print(bebe.getDni()); %></td>
                                    <td>bebe</td>
                                </tr>
                                <%}
                                    }
                                %>
                            </table>


                            <div class="tituloresumen">Servicios</div>

                            <%
                                int cantidadservicios = 0;
                                for (pasajero pasajero : reservaElegida.getPasajeros()) {%>
                            <table class="tablaresumen">

                                <tr>
                                    <td colspan="2"><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos() + " (" + pasajero.getPasaporte() + ") ");
                                        if (reservaElegida.getVuelovuelta() == null) {
                                            out.print("Asiento: " + pasajero.getAsientoida());
                                        } else {
                                            out.print("Asiento ida: " + pasajero.getAsientoida() + " / Asiento vuelta: " + pasajero.getAsientovuelta());
                                        }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">Servicios <% if (reservaElegida.getVuelovuelta() != null) {
                                            out.print("ida");
                                        } %></td>
                                </tr>
                                <%
                                    if (pasajero.getServiciosida().isEmpty()) {%>
                                <tr>
                                    <td>&nbsp;&nbsp;&nbsp;Ningún servicio</td>
                                </tr>
                                <%} else {
                                    for (servicio servicio : pasajero.getServiciosida()) {%>
                                <tr>
                                    <td class="tdelemento"><% out.print("&nbsp;&nbsp;&nbsp;" + servicio.getNombre()); %></td>
                                    <td class="tdprecio"><% out.print(servicio.getPrecio() + " €"); %></td>
                                    <% cantidadservicios = cantidadservicios + servicio.getPrecio(); %>
                                </tr>
                                <%}
                                    }
                                %>
                                <%
                                    if (reservaElegida.getVuelovuelta() != null) {%>
                                <tr>
                                    <td colspan="2">Servicios vuelta</td>
                                </tr>
                                <%
                                    for (servicio servicio : pasajero.getServiciosvuelta()) {%>
                                <tr>
                                    <td class="tdelemento"><% out.print("&nbsp;&nbsp;&nbsp;" + servicio.getNombre()); %></td>
                                    <td class="tdprecio"><% out.print(servicio.getPrecio() + " €"); %></td>
                                    <% cantidadservicios = cantidadservicios + servicio.getPrecio(); %>
                                </tr>
                                <%}
                                %>
                                <%}
                                %>
                            </table> 
                            <br>
                            <%}

                            %>
                            <table class="tablaresumen">
                                <tr>
                                    <td class="tdelemento bold">Total</td>
                                    <td class="tdprecio bold"><% out.print(cantidadservicios + " €");%></td>
                                    <% cantidadtotal += cantidadservicios; %>
                                </tr>
                            </table>
                            <div class="tituloresumen">Total<div style="float: right"><% out.print(cantidadtotal + " €");%></div></div>

                        </div>
                        <div style="clear: both">
                            <div style="text-align: left; margin-bottom: 10px;"><a href="misvuelos1.jsp"><button class="btn btn-primary">Volver</button></a></div>

                        </div>
                        <input type="hidden" name="precio" value="<% out.print(cantidadtotal);%>">
                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
        <%
            try {
                int codError = (Integer) session.getAttribute("codError");
                if (codError == 3) {%>
        <script>
            alert("No existe ningun usuario con ese email y/o contraseña");
        </script>
        <%}
                session.removeAttribute("codError");
            } catch (NullPointerException er) {

            }
        %>
    </body>

</html>
