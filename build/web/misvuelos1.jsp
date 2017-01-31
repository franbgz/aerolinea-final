<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.reserva" %>
<%@page import="clases.aeropuerto"%>
<%@page import="clases.vuelo" %>
<%@page import="java.util.ArrayList" %>
<%
    usuario usuario = (usuario) session.getAttribute("usuario");
    ArrayList<reserva> reservas = (ArrayList) session.getAttribute("vuelos");
%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="images/icons/favicon.png" type="image/png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>DreamHack Airline - MIS VUELOS</title>
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
                    <li><a href="facturar">CHECK-IN WEB</a></li>
                    <li class="active"><a href="misvuelos">MIS VUELOS</a></li>
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
                    <h2 style="border-bottom: 1px solid black;">Mis vuelos</h2>
                    <%
                        if (reservas.isEmpty()) {%>
                    <h2 style="text-align: center">Todavía no has volado con nosotros</h2>
                    <h4 style="text-align: center">    
                        Puedes hacer tu reserva de vuelo en INICIO pulsando en el siguiente botón:
                        <br>
                        <a href="index.jsp"><button class="btn btn-primary">Inicio</button></a>
                    </h4>
                    <%} else {%>
                    <table class="table">
                        <tr>
                            <th>Reserva</th>
                            <th>Vuelo ida</th>
                            <th>Vuelo vuelta</th>
                            <th>Fecha</th>
                            <th>Mas detalles</th>
                        </tr>
                        <%
                            for (reserva reserva : reservas) {%>
                        <form action="misvuelos2.jsp">
                            <input type="hidden" value="<% out.print(reserva.getId()); %>" name="idReserva">
                            <tr>
                                <td>
                                    <% out.print(reserva.getCodigo()); %>
                                </td>
                                <td>
                                    <%
                                        if (reserva.getVueloida() != null) {
                                            out.print(reserva.getVueloida().toString());
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        if (reserva.getVuelovuelta() != null) {
                                            out.print(reserva.getVuelovuelta().toString());
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        out.print(reserva.getVueloida().obtenerFecha());
                                        if(reserva.getVuelovuelta() != null){
                                            out.print( " - "  + reserva.getVuelovuelta().obtenerFecha());
                                        }
                                    %>
                                </td>
                                <td>
                                    <input type="submit" value="Mas detalles" class="btn btn-primary" >
                                </td>
                            </tr>
                        </form>
                        <%}
                        %>
                    </table>
                    <%}
                    %>


                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
    </body>

</html>
