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
    String tipovuelo = (String) session.getAttribute("tipovuelo");
    ArrayList<vuelo> vuelosida = (ArrayList<vuelo>) session.getAttribute("vuelosida");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = (aeropuerto) session.getAttribute("aeropuertorigen");
    aeropuerto aerodestino = (aeropuerto) session.getAttribute("aeropuertodestino");
    reserva reserva = (reserva) session.getAttribute("reserva");
    ArrayList<pasajero> pasajeros = reserva.getPasajeros();
    ArrayList<servicio> servicios = (ArrayList) session.getAttribute("servicios");
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
                
            </div>
        </nav>
        <div class="container">

            <div class="row">
                <div class="col-md-10 col-md-offset-1 cuerporeserva">
                    <img src="images/logo.png" height="57" style="float: right;">
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px; color: #a0bac5">Vuelos / Pasajeros / Servicios / Resumen / <span style="color: #ff6600;">Pago</span></h2>
                    <div class="cuerpousuario">
                        <h3>Necesitamos que te identifiques en nuestro sistema para contrinuar</h3>
                        <div class="diventrar">
                            <h3 style="text-align: center">Si ya has viajado con nosotros...</h3>
                            <%try {
                                    int codError = (Integer) session.getAttribute("codError");
                                    if (codError == 3) { %>
                            <div class="alert alert-danger alert-dismissable aviso">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                No existe ningun usuario con ese email y/o contraseña
                            </div>
                            <%}
                                } catch (NullPointerException er) {
                                }
                            %>
                            <form action="verificarUsuario">
                                <table class="tablaf6">
                                    <tr>
                                        <td><label for="email">e-mail</label></td>
                                        <td><input type="email" id="email" name="email" class="form-control" placeholder="email" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="contraseña">Contraseña</label></td>
                                        <td><input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Contraseña" required></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: center"><input type="submit" value="Entrar" class="btn btn-primary"></td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                        <div class="divreqistrar">
                            <h3 style="text-align: center">Si eres nuevo en DreamHack Airline...</h3>
                            <%
                                try {
                                    int codError = (Integer) session.getAttribute("codError");
                                    if (codError == 1) { %>
                            <div class="alert alert-danger alert-dismissable aviso">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                Comprueba que la confirmacion de la contraseña coincide
                            </div>
                            <%}
                                if (codError == 2) { %>
                            <div class="alert alert-danger alert-dismissable aviso">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                Ya existe un usuario con ese email
                            </div>
                            <%}

                                } catch (NullPointerException er) {

                                }
                            %>
                            <form action="registrarUsuario">
                                <table class="tablaf6">
                                    <tr>
                                        <td><label for="email">e-mail</label></td>
                                        <td><input type="email" name="email" id="email" placeholder="email" class="form-control" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="contraseña">Contraseña</label></td>
                                        <td><input type="password" name="contraseña" id="contraseña" placeholder="Contraseña" class="form-control" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="repetircontraseña">Confirmar contraseña</label></td>
                                        <td><input type="password" name="repetircontraseña" id="repetircontraseña" placeholder="Confirmar contraseña" class="form-control" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="nombre">Nombre</label></td>
                                        <td><input type="text" name="nombre" id="nombre" placeholder="Nombre" class="form-control" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="apellidos">Apellidos</label></td>
                                        <td><input type="text" name="apellidos" id="apellidos" placeholder="Apellidos" class="form-control" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="telefono">Teléfono</label></td>
                                        <td><input type="text" name="telefono" id="telefono" placeholder="Teléfono" class="form-control"></td>
                                    </tr>
                                    <tr>
                                        <td><label for="fechanac">Fecha nacimiento</label></td>
                                        <td><input type="text" name="fechanac" id="fechanac" class="fechanacAdulto" placeholder="Fecha nacimiento" required></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: center;"><input type="submit" value="Registrar" class="btn btn-primary"></td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>



                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
    </body>

</html>