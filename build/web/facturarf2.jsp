<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.reserva" %>
<%@page import="clases.aeropuerto"%>
<%@page import="clases.vuelo" %>
<%@page import="clases.pasajero" %>
<%@page import="java.util.ArrayList" %>
<%
    usuario usuario = (usuario) session.getAttribute("usuario");
    reserva reservaselec = (reserva) session.getAttribute("reservaselec");
    String opcion = (String) session.getAttribute("opcion");
%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="images/icons/favicon.png" type="image/png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>DreamHack Airline - Tarjeta de embarque</title>
        <link rel="stylesheet" href="css/cusom-theme.css">
        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="css/jquery-ui.theme.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/jquery-ui.structure.css">
        <script src="js/jquery-2.2.2.js"></script>
        <script src="js/main.js"></script>
        <script src="js/jquery-ui.min.js"></script>
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
                    <li class="active"><a href="facturar">CHECK-IN WEB</a></li>
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
                        <input type="hidden" name="jspOrigen" value="error.jsp">
                    </div>
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </form>
                <%}%>
            </div>
        </nav>
        <div class="container">

            <div class="row">
                <div class="col-md-10 col-md-offset-1 cuerporeserva">
                    <img src="images/logo.png" height="57" style="float: right">
                    <h2 style="border-bottom: 1px solid black;">Tarjeta de embarque</h2>
                    <%
                        if (opcion.equals("Ida")) {
                            for (int i = 0; i < reservaselec.getNumpasajeros(); i++) {
                                pasajero pasajero = reservaselec.getPasajero(i);%>
                    <div class="tarjeta">
                        <img src="obtenerQR?numpasajero=<% out.print(i); %>&tipo=ida" width="150px" style="float: left; margin: 5px 5px 5px 5px;">
                        <table class="tabla-tarjeta">
                            <tr>
                                <td><strong><% out.print(reservaselec.getVueloida().obtenerDatos()); %></strong></td>
                                <td>Hora de salida: <% out.print(reservaselec.getVueloida().getHoraSalida().toString()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getPasaporte()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(reservaselec.getCodigo()); %></td>
                            </tr>
                        </table>


                    </div>
                    <% }
                        }%>

                    <%
                        if (opcion.equals("Vuelta")) {
                            for (int i = 0; i < reservaselec.getNumpasajeros(); i++) {
                                pasajero pasajero = reservaselec.getPasajero(i);%>
                    <div class="tarjeta">
                        <img src="obtenerQR?numpasajero=<% out.print(i); %>&tipo=vuelta" width="150px" style="float: left; margin: 5px 5px 5px 5px;">
                        <table class="tabla-tarjeta">
                            <tr>
                                <td><strong><% out.print(reservaselec.getVuelovuelta().obtenerDatos()); %></strong></td>
                                <td>Hora de salida: <% out.print(reservaselec.getVuelovuelta().getHoraSalida().toString()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getPasaporte()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(reservaselec.getCodigo()); %></td>
                            </tr>
                        </table>


                    </div>
                    <% }
                        }%>
                    <%
                        if (opcion.equals("Ida y vuelta")) {%>
                    <h3>Vuelo de ida <% out.print(reservaselec.getVueloida().toString()); %></h3>
                    <%
                        for (int i = 0; i < reservaselec.getNumpasajeros(); i++) {
                            pasajero pasajero = reservaselec.getPasajero(i);%>
                    <div class="tarjeta">
                        <img src="obtenerQR?numpasajero=<% out.print(i); %>&tipo=ida" width="150px" style="float: left; margin: 5px 5px 5px 5px;">
                        <table class="tabla-tarjeta">
                            <tr>
                                <td><strong><% out.print(reservaselec.getVueloida().obtenerDatos()); %></strong> </td>
                                <td>Hora de salida: <% out.print(reservaselec.getVueloida().getHoraSalida().toString()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getPasaporte()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(reservaselec.getCodigo()); %></td>
                            </tr>
                        </table>


                    </div>
                    <% }%>
                    <h3>Vuelo de vuelta <% out.print(reservaselec.getVuelovuelta().toString()); %></h3>
                    <%
                        for (int i = 0; i < reservaselec.getNumpasajeros(); i++) {
                            pasajero pasajero = reservaselec.getPasajero(i);%>
                    <div class="tarjeta">
                        <img src="obtenerQR?numpasajero=<% out.print(i); %>&tipo=vuelta" width="150px" style="float: left; margin: 5px 5px 5px 5px;">
                        <table class="tabla-tarjeta">
                            <tr>
                                <td><strong><% out.print(reservaselec.getVuelovuelta().obtenerDatos()); %></strong></td>
                                <td>Hora de salida: <% out.print(reservaselec.getVuelovuelta().getHoraSalida().toString()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getNombre() + " " + pasajero.getApellidos()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(pasajero.getPasaporte()); %></td>
                            </tr>
                            <tr>
                                <td><% out.print(reservaselec.getCodigo());%></td>
                            </tr>
                        </table>


                    </div>
                    <%}
                                    }%>

                    <p style="text-align: center">
                        <a href="index.jsp"><button class="btn btn-primary">Inicio</button></a>
                    </p>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
    </body>

</html>
