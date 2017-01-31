<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.vuelo" %>
<%@page import="clases.pasajero" %>
<%@page import="clases.aeropuerto"%>
<%@page import="clases.servicio" %>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.reserva"%>
<%
    String tipovuelo = (String) session.getAttribute("tipovuelo");
    ArrayList<vuelo> vuelosida = (ArrayList<vuelo>) session.getAttribute("vuelosida");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = (aeropuerto) session.getAttribute("aeropuertorigen");
    aeropuerto aerodestino = (aeropuerto) session.getAttribute("aeropuertodestino");
    reserva reserva = (reserva) session.getAttribute("reserva");
    ArrayList<pasajero> pasajeros = reserva.getPasajeros();
    ArrayList<servicio> servicios = (ArrayList) session.getAttribute("servicios");
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
                        <input type="hidden" name="jspOrigen" value="reservaf3b.jsp">
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
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px; color: #a0bac5">Vuelos / Pasajeros / <span style="color: #ff6600;">Servicios </span><span style="color: #152329;">/ Resumen / Pago</span></h2>
                    <form action="guardarServiciosVuelta">
                        <div class="cuerpoformulario">

                            <h2>Servicios de vuelta / <% out.print(aerodestino.getCiudad() + " - " + aerorigen.getCiudad());%></h2>

                            <div id="accordion">
                                <%
                                    int numpasajeros = (Integer) session.getAttribute("viajeros");
                                    for (int i = 0; i < numpasajeros; i++) {%>
                                <h3><% out.print(pasajeros.get(i).getNombre() + " " + pasajeros.get(i).getApellidos()); %></h3>
                                <div>
                                    <table class="table">
                                        <%
                                            for (int x = 0; x < servicios.size(); x++) {
                                                if (x != 3) {
                                        %>
                                        <tr>
                                            <td><input type="checkbox" id="<% out.print("servicio" + x + "-" + i); %>" name="<% out.print("servicio-" + i); %>" <% if (x == 3) {
                                                    out.print("onchange='añadirBebe(" + i + ")'");
                                                } %><% if (!pasajeros.get(i).getEdad().equals("adulto") && x == 3) { %> disabled <% } %> value="<% out.print(x); %>"></td>
                                            <td><label for="<% out.print("servicio" + x + "-" + i); %>"><% out.print(servicios.get(x).getNombre()); %></label></td>
                                            <td><% out.print(servicios.get(x).getDescripcion()); %><% if (x == 3) {%> <div id="<% out.print("divbebe" + i); %>"></div> <%} %></td>
                                            <td><% out.print(servicios.get(x).getPrecio()); %>€</td>
                                        </tr>
                                        <%
                                                }
                                            }
                                        %>
                                    </table>
                                </div>
                                <% }
                                %>
                            </div>
                        </div>
                        <div class="ventanaflotante">
                            <div style="text-align: center; font-size: 28px;">Mi reserva <img src="images/icons/ticket.png" alt="up" width="24" style="display: inline"></div>
                            <div id="acordeonservicios">
                                <h3>Vuelo <img src="images/icons/up.png" alt="up" width="18"></h3>
                                <div>
                                </div>
                                <h3>Pasajeros <img src="images/icons/man.png" alt="up" width="18"></h3>
                                <div>
                                </div>
                                <h3>Servicios <img src="images/icons/services.png" alt="up" width="18"></h3>
                                <div>
                                </div>
                            </div>
                            <div style="text-align: right; margin-top: 3px;">
                                Total: <span id="total">0</span> €
                            </div>
                        </div>
                        <div style="clear: both">
                            <div style="text-align: right; margin-bottom: 10px;"><input type="submit" value="Siguiente" class="btn btn-primary"></div>

                        </div>
                    </form>
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
