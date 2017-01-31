<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%@page import="clases.reserva" %>
<%@page import="clases.vuelo" %>
<%@page import="clases.aeropuerto"%>
<%@page import="java.util.ArrayList"%>
<%
    String tipovuelo = (String) session.getAttribute("tipovuelo");
    ArrayList<vuelo> vuelosida = (ArrayList<vuelo>) session.getAttribute("vuelosida");
    usuario usuario = (usuario) session.getAttribute("usuario");
    aeropuerto aerorigen = (aeropuerto) session.getAttribute("aeropuertorigen");
    aeropuerto aerodestino = (aeropuerto) session.getAttribute("aeropuertodestino");
    reserva reserva = (reserva) session.getAttribute("reserva");
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
                        <input type="hidden" name="jspOrigen" value="reservaf2.jsp">
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
                    <h2 style="border-bottom: 1px solid #152329; padding-top: 0px; color: #a0bac5">Vuelos /<span style="color: #ff6600;"> Pasajeros </span><span style="color: #152329;">/ Servicios / Resumen / Pago</span></h2>
                    <form action="guardarPasajeros">
                        <div class="cuerpoformulario">
                            <div id="accordion">
                                <h3>Pasajero 1</h3>
                                <div>
                                    <table class="tablaformulario">
                                        <tr>
                                            <td><label for="tratamiento1">Tratamiento</label></td>
                                            <td>
                                                <select id="tratamiento1" class="form-control">
                                                    <option>Mr</option>
                                                    <option>Mrs</option>
                                                    <option>Miss</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="nombre1">Nombre</label></td>
                                            <td><input type="text" id="nombre1" name="nombre1" required class="form-control" placeholder="Nombre"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="apellidos1">Apellidos</label></td>
                                            <td><input type="text" id="apellidos1" name="apellidos1" required class="form-control" placeholder="Apellidos"></td>
                                        </tr>
                                        <tr >
                                            <td><label for="dni1">DNI</label></td>
                                            <td><input type="text" id="dni1" name="dni1" class="form-control" placeholder="DNI"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="cadpasaporte1">Caducidad  DNI</label></td>
                                            <td><input type="text" id="cadpasaporte1" name="cadpasaporte1" class="fechalib" placeholder="Caducidad DNI"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="genero1">Género</label></td>
                                            <td>
                                                <select id="genero1" name="genero1" class="form-control">
                                                    <option value="hombre">Hombre</option>
                                                    <option value="mujer">Mujer</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="edad1">Edad</label></td>
                                            <td>
                                                <select id="edad1" disabled class="form-control">
                                                    <option value="adulto">Adulto</option>
                                                </select>
                                                <input type="edad1" name="edad1" value="adulto" hidden>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="nacionalidad1">Nacionalidad</label></td>
                                            <td>
                                                <select id="nacionalidad1" name="nacionalidad1" class="form-control">
                                                    <option value="España">España</option>
                                                    <option value="Francia">Francia</option>
                                                    <option value="Alemania">Alemania</option>
                                                    <option value="Italia">Italia</option>
                                                    <option value="Reino Unido">Reino Unido</option>
                                                    <option value="Portugal">Portugal</option>
                                                    <option value="Suecia">Suecia</option>
                                                    <option value="Polinia">Polonia</option>
                                                    <option value="Suiza">Suiza</option>
                                                    <option value="Dinamarca">Dinamarca</option>
                                                    <option value="Belgica">Belgica</option>
                                                    <option value="Rumania">Rumania</option>
                                                    <option value="Rusia">Rusia</option>
                                                    <option value="Grecia">Grecia</option>
                                                    <option value="Paises Bajos">Paises Bajos</option>
                                                    <option value="Estados Unidos">Estados Unidos</option>
                                                    <option value="Otro pais">Otro pais</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="fechanac1">Fecha nacimiento</label></td>
                                            <td><input type="text" id="fechanac1" name="fechanac1" placeholder="Fecha nacimiento"></td>
                                        </tr>
                                    </table>
                                </div>
                                <%
                                    int numpasajeros = (Integer) session.getAttribute("viajeros");
                                    for (int i = 1; i < numpasajeros; i++) {%>
                                <h3>Pasajero <% out.print(i + 1); %></h3>
                                <div>
                                    <table class="tablaformulario">
                                        <tr>
                                            <td><label for="nombre<% out.print(i + 1); %>">Nombre</label></td>
                                            <td><input type="text" name="nombre<% out.print(i + 1); %>" id="nombre<% out.print(i + 1); %>" required class="form-control" placeholder="Nombre"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="apellidos<% out.print(i + 1); %>">Apellidos</label></td>
                                            <td><input type="text" name="apellidos<% out.print(i + 1); %>" id="apellidos<% out.print(i + 1); %>" required class="form-control" placeholder="Apellidos"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="dni<% out.print(i + 1); %>">DNI</label></td>
                                            <td><input type="text" name="dni<% out.print(i + 1); %>" id="dni<% out.print(i + 1); %>" class="form-control" placeholder="DNI"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="cadpasaporte<% out.print(i + 1); %>">Caducidad  DNI</label></td>
                                            <td><input type="text" id="cadpasaporte<% out.print(i + 1); %>" name="cadpasaporte<% out.print(i + 1); %>" class="fechalib" placeholder="Caducidad DNI"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="genero<% out.print(i + 1); %>">Género</label></td>
                                            <td>
                                                <select name="genero<% out.print(i + 1); %>" id="genero<% out.print(i + 1); %>" class="form-control">
                                                    <option value="hombre">Hombre</option>
                                                    <option value="mujer">Mujer</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="edad<% out.print(i + 1); %>">Edad</label></td>
                                            <td>
                                                <select name="edad<% out.print(i + 1); %>" id="edad<% out.print(i + 1); %>" class="form-control">
                                                    <option value="adulto">Adulto</option>
                                                    <option value="menor">Menor</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="nacionalidad<% out.print(i + 1); %>">Nacionalidad</label></td>
                                            <td>
                                                <select id="nacionalidad<% out.print(i + 1); %>" name="nacionalidad<% out.print(i + 1); %>" class="form-control">
                                                    <option value="España">España</option>
                                                    <option value="Francia">Francia</option>
                                                    <option value="Alemania">Alemania</option>
                                                    <option value="Italia">Italia</option>
                                                    <option value="Reino Unido">Reino Unido</option>
                                                    <option value="Portugal">Portugal</option>
                                                    <option value="Suecia">Suecia</option>
                                                    <option value="Polinia">Polonia</option>
                                                    <option value="Suiza">Suiza</option>
                                                    <option value="Dinamarca">Dinamarca</option>
                                                    <option value="Belgica">Belgica</option>
                                                    <option value="Rumania">Rumania</option>
                                                    <option value="Rusia">Rusia</option>
                                                    <option value="Grecia">Grecia</option>
                                                    <option value="Paises Bajos">Paises Bajos</option>
                                                    <option value="Estados Unidos">Estados Unidos</option>
                                                    <option value="Otro pais">Otro pais</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label for="fechanac<% out.print(i + 1); %>">Fecha nacimiento</label></td>
                                            <td><input type="text" id="fechanac<% out.print(i + 1); %>" name="fechanac<% out.print(i + 1); %>" class="fechanac" placeholder="Fecha nacimiento"></td>
                                        </tr>
                                    </table>
                                </div>
                                <% }
                                %>
                            </div>
                        </div>
                        <div class="ventanaflotante">
                            <div style="text-align: center; font-size: 28px;">Mi reserva <img src="images/icons/ticket.png" alt="up" width="24" style="display: inline"></div>
                            <div id="acordeonpasajero">
                                <h3>Vuelo <img src="images/icons/up.png" alt="up" width="18"></h3>
                                <div>
                                    <div id="vueloida-vflotante">
                                        <table class="tabla-interior-vflotante" style="margin-bottom: 5px;">
                                            <tr>
                                                <td colspan="2" style="text-align: center; font-weight: bold; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">
                                                    Vuelo ida
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Num:</td>
                                                <td style="text-align: right;"><% out.print(reserva.getVueloida().getNumero()); %></td>
                                            </tr>
                                            <tr>
                                                <td>Precio:</td>
                                                <td style="text-align: right;"><% out.print(numpasajeros + "x " + reserva.getVueloida().getPrecio() + "€"); %></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="font-weight: bold; text-align: right;"><% out.print(reserva.getVueloida().getPrecio()*reserva.getNumpasajeros() + "€"); %></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="vuelovuelta-vflotante">
                                        <%
                                            if (reserva.getVuelovuelta() != null) {%>
                                        <table class="tabla-interior-vflotante">
                                            <tr>
                                                <td colspan="2" style="text-align: center; font-weight: bold; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">
                                                    Vuelo vuelta
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Num:</td>
                                                <td style="text-align: right;"><% out.print(reserva.getVuelovuelta().getNumero()); %></td>
                                            </tr>
                                            <tr>
                                                <td>Precio:</td>
                                                <td style="text-align: right"><% out.print(numpasajeros + "x " + reserva.getVuelovuelta().getPrecio() + "€"); %></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="font-weight: bold; text-align: right;"><% out.print(reserva.getVuelovuelta().getPrecio()*reserva.getNumpasajeros() + "€"); %></td>
                                            </tr>
                                        </table>
                                        <%}
                                        %>
                                    </div>

                                </div>
                                <h3>Pasajeros <img src="images/icons/man.png" alt="up" width="18"></h3>
                                <div>
                                </div>
                            </div>
                            <div style="text-align: right; margin-top: 3px;">
                                Total: <span id="total"><% out.print(reserva.getPrecio()); %></span> €
                            </div>
                        </div>
                        <div style="clear: both">
                            <div style="text-align: right; margin-bottom: 10px;"><input type="submit" value="Siguiente" class="btn btn-primary"></div>
                            <p>
                                Si necesitas viajar con un bebé, no lo incluyas aquí como un pasajero. Se considera un servicio ya que no ocupa un asiento. Podrás rellenar sus datos en la siguiente sección Servicios.
                            </p>
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