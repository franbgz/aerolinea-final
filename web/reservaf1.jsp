
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.vuelo" %>
<%@page import="clases.aeropuerto"%>
<%@page import="java.util.ArrayList"%>
<%
    String tipovuelo = (String) session.getAttribute("tipovuelo");
    ArrayList<vuelo> vuelosida = (ArrayList<vuelo>) session.getAttribute("vuelosida");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = (aeropuerto) session.getAttribute("aeropuertorigen");
    aeropuerto aerodestino = (aeropuerto) session.getAttribute("aeropuertodestino");
    int numviajeros = (Integer)session.getAttribute("viajeros");
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
        <script src="js/reservaf1JS.js"></script>
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
                        <input type="hidden" name="jspOrigen" value="reservaf1.jsp">
                    </div>
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </form>
                <%}%>
            </div>
        </nav>
        <div class="container">

            <div class="row">
                <div class="col-md-10 col-md-offset-1 cuerporeserva">

                    <%
                        if (tipovuelo.equals("soloida")) {%>
                    <div class="alert alert-warning alert-dismissable aviso">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        Solo has seleccionado fecha de ida. Si quieres un vuelo de vuelta regresa a Inicio y selecciona una fecha de vuelta.
                    </div>
                    <%}
                    %>
                    <img src="images/logo.png" height="57" style="float: right">
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px;"><span style="color: #ff6600">Vuelos </span>/ Pasajeros / Servicios / Resumen / Pago</h2>

                    <form action="guardarVuelos" id="formulariovuelo">
                        <div>
                            <div class="cuerpoformulario">


                                <h3><% out.println(aerorigen.getCiudad() + "(" + aerorigen.getIata() + ") - " + aerodestino.getCiudad() + "(" + aerodestino.getIata() + ")"); %></h3>
                                <table class="table">
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Precio</th>
                                        <th>Número vuelo</th>
                                        <th title="Formato de fecha dd-MM-yyyy" style="cursor: help">Fecha*</th>
                                        <th>Hora salida</th>
                                        <th>Hora llegada</th>
                                    </tr>
                                    <%
                                        for (int i = 0; i < vuelosida.size(); i++) {
                                    %>
                                    <tr>
                                        <td style="text-align: center">
                                            <%
                                                if (i == 0) {
                                            %>
                                            <img src="images/icons/star.png" height="26">
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td><input type="radio" name="vueloida" value="<% out.print(vuelosida.get(i).getId()); %>" required onChange="buscarVuelo(<% out.print(vuelosida.get(i).getId()); %>, <% out.print(numviajeros); %>, 'ida')"></td>
                                        <td><% out.println(vuelosida.get(i).getPrecio()); %> €</td>
                                        <td><% out.println(vuelosida.get(i).getNumero()); %></td>
                                        <td><% out.println(vuelosida.get(i).getFecha().getDayOfMonth() + "-" + vuelosida.get(i).getFecha().getMonthValue() + "-" + vuelosida.get(i).getFecha().getYear()); %></td>
                                        <td><% out.println(vuelosida.get(i).getHoraSalida().toString()); %></td>
                                        <td><% out.println(vuelosida.get(i).getHoraLlegada().toString()); %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                                <%
                                    if (tipovuelo.equals("idavuelta")) {
                                        ArrayList<vuelo> vuelosvuelta = (ArrayList<vuelo>) session.getAttribute("vuelosvuelta");

                                %>
                                <h3><% out.println(aerodestino.getCiudad() + "(" + aerodestino.getIata() + ") - " + aerorigen.getCiudad() + "(" + aerorigen.getIata() + ")"); %></h3>
                                <table class="table">
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Precio</th>
                                        <th>Número vuelo</th>
                                        <th>Fecha</th>
                                        <th>Hora salida</th>
                                        <th>Hora llegada</th>
                                    </tr>
                                    <%
                                        for (int i = 0; i < vuelosvuelta.size(); i++) {
                                    %>
                                    <tr>
                                        <td style="text-align: center">
                                            <%
                                                if (i == 0) {
                                            %>
                                            <img src="images/icons/star.png" height="26">
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td><input type="radio" name="vuelovuelta" value="<% out.print(vuelosvuelta.get(i).getId()); %>" required onChange="buscarVuelo(<% out.print(vuelosvuelta.get(i).getId()); %>, <% out.print(numviajeros); %>, 'vuelta')"></td>
                                        <td><% out.println(vuelosvuelta.get(i).getPrecio()); %> €</td>
                                        <td><% out.println(vuelosvuelta.get(i).getNumero()); %></td>
                                        <td><% out.println(vuelosvuelta.get(i).getFecha().getDayOfMonth() + "-" + vuelosvuelta.get(i).getFecha().getMonthValue() + "-" + vuelosvuelta.get(i).getFecha().getYear()); %></td>
                                        <td><% out.println(vuelosvuelta.get(i).getHoraSalida().toString()); %></td>
                                        <td><% out.println(vuelosvuelta.get(i).getHoraLlegada().toString()); %></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                                <%
                                    }
                                %> 


                            </div>
                            <div class="ventanaflotante">
                                <div style="text-align: center; font-size: 28px;">Mi reserva <img src="images/icons/ticket.png" alt="up" width="24" style="display: inline"></div>
                                <div id="acordeonvuelo">
                                    <h3>Vuelo <img src="images/icons/up.png" alt="up" width="18"></h3>
                                    <div>
                                        <div id="vueloida-vflotante">Elige un vuelo</div>
                                        <div id="vuelovuelta-vflotante"></div>
                                    </div>
                                </div>
                                <div style="text-align: right; margin-top: 3px;">
                                    Total: <span id="total">0</span> €
                                </div>
                            </div>
                            <div style="clear: both">
                                <div style="text-align: right; margin-bottom: 10px;"><input type="submit" value="Siguiente" class="btn btn-primary"></div>
                                <p>Los horarios de salida y llegada de los vuelos son locales al lugar donde se despega o aterriza respectivamente.
                                    <br>
                                    <img src="images/icons/star.png" height="22" style="float: left">Este icono al lado de los vuelos representa el vuelo más cercano a la fecha que nos has indicado.
                                </p>
                            </div>
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
