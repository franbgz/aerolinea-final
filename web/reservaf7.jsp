<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.vuelo" %>
<%@page import="clases.pasajero" %>
<%@page import="clases.aeropuerto"%>
<%@page import="clases.servicio" %>
<%@page import="clases.bebe" %>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.reserva"%>
<%@page import="clases.pagador" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%
    String tipovuelo = (String) session.getAttribute("tipovuelo");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = (aeropuerto) session.getAttribute("aeropuertorigen");
    aeropuerto aerodestino = (aeropuerto) session.getAttribute("aeropuertodestino");
    reserva reserva = (reserva) session.getAttribute("reserva");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    ArrayList<pagador> pagadores = (ArrayList) session.getAttribute("pagadores");
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
                        <input type="hidden" name="jspOrigen" value="reservaf7.jsp">
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
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px; color: #a0bac5">Vuelos / Pasajeros / Servicios / Resumen / <span style="color: #ff6600;">Pago</span></h2>
                    <h3>Direccion de facturación</h3>
                    <form action="asignarPagador">
                        <table class="table">
                            <tr>
                                <th></th>
                                <th>Nombre</th>
                                <th>Apellidos</th>
                                <th>DNI</th>
                                <th>Dirección</th>
                                <th>Poblacion</th>
                            </tr>

                            <%
                            for (pagador pagador : pagadores) {%>
                            <tr>
                                <td><input type="radio" name="pagador" value="<% out.print(pagador.getId()); %>"</td>
                                <td><% out.print(pagador.getNombre()); %></td>
                                <td><% out.print(pagador.getApellidos()); %></td>
                                <td><% out.print(pagador.getDni()); %></td>
                                <td><% out.print(pagador.getDireccion()); %></td>
                                <td><% out.print(pagador.getPoblacion()); %></td>
                            </tr>
                            <%}
                            %>
                            <tr>
                                <td><input type="radio" name="pagador" value="new" required></td>
                                <td><input type="text" name="nombrePagador" placeholder="Nombre" class="form-control"></td>
                                <td><input type="text" name="apellidosPagador" placeholder="Apellidos" class="form-control"></td>
                                <td><input type="text" name="dniPagador" placeholder="DNI" class="form-control"></td>
                                <td><input type="text" name="direccionPagador" placeholder="Dirección" class="form-control"></td>
                                <td><input type="text" name="poblacionPagador" placeholder="Población" class="form-control"></td>
                            </tr>
                        </table>
                        <div style="clear: both">
                            <div style="text-align: right; margin-bottom: 10px;"><input type="submit" value="Siguiente" class="btn btn-primary"></div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>

    </body>

</html>
