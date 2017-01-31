<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.reserva"%>
<%@page import="clases.tarjeta" %>
<%@page import="clases.base64" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%
    usuario usuario = (usuario) session.getAttribute("usuario");
    reserva reserva = (reserva) session.getAttribute("reserva");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    ArrayList<tarjeta> tarjetas = usuario.getTarjetas();
    base64 base64 = new base64();
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
                        <input type="hidden" name="jspOrigen" value="reservaf8.jsp">
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
                    <h3>Tarjeta de pago</h3>
                    <form action="guardarTarjeta">
                        <%
                            if (!tarjetas.isEmpty()) {%>
                        <h4>Tus tarjetas anteriores</h4>
                        <%}
                            for (tarjeta tarjeta : tarjetas) {%>
                        <table class="table">
                            <tr>
                                <td rowspan="4"><input type="radio" name="tarjeta" value="<% out.print(tarjeta.getId()); %>"></td>
                                <td>Número tarjeta</td>
                                <%
                                    String numeroDescifrado = base64.descifrarBase64(tarjeta.getNumero());
                                %>
                                <td>**** **** **** <% out.print(numeroDescifrado.substring(numeroDescifrado.length() - 4)); %></td>
                            </tr>
                            <tr>
                                <td>Nombre propietario</td>
                                <td><% out.print(tarjeta.getPropietario()); %></td>
                            </tr>
                            <tr>
                                <td>Fecha caducidad</td>
                                <td><% out.print(tarjeta.getCaducidad().getMonthValue() + "/" + tarjeta.getCaducidad().getYear()); %></td>
                            </tr>
                            <tr>
                                <td>Codigo seguridad CVV</td>
                                <td><input type="text" maxlength="3" name="codseguridadtarjeta-<% out.print(tarjeta.getId()); %>" class="form-control" placeholder="CVV"></td>
                            </tr>
                        </table> 
                        <br>
                        <%}
                        %>
                        <h4>Nueva tarjeta</h4>
                        <table class="table">
                            <tr>
                                <td rowspan="4"><input type="radio" name="tarjeta" value="new" required></td>
                                <td>Número Tarjeta</td>
                                <td><input type="text" name="numero" class="form-control" placeholder="Número" maxlength="12"></td>
                            </tr>
                            <tr>
                                <td>Nombre propietario</td>
                                <td><input type="text" name="propietario" class="form-control" placeholder="Nombre"></td>
                            </tr>
                            <tr>
                                <td>Caducidad</td>
                                <td>
                                    <div class="form-inline">
                                        <select name="mesCaducidad" id="mesCaducidad" class="form-control">
                                        </select>
                                        <select name="añoCaducidad" id="añoCaducidad" class="form-control"></select>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td>Codigo seguridad CVV</td>
                                <td><input type="text" id="codigo" name="codigo" class="form-control" placeholder="CVV" maxlength="3"></td>
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
        <%
            try {
                int codError = (Integer) session.getAttribute("codError");
        if (codError == 5) {%>
        <script>
            alert("El CVV introducido no es valido");
        </script>
        <%}
                session.removeAttribute("codError");
            } catch (NullPointerException er) {

            }
        %>
    </body>

</html>
