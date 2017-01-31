<%-- 
    Document   : index
    Created on : 08-abr-2016, 20:49:05
    Author     : fran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="clases.usuario" %>
<%  usuario usuario = (usuario) session.getAttribute("usuario");%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="images/icons/favicon.png" type="image/png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>DreamHack Airline - Inicio</title>
        <!--<link href="css/bootstrap.css" rel="stylesheet" media="screen">-->
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
                    <li class="active"><a href="index.jsp">INICIO</a></li>
                    <li><a href="facturar">CHECK-IN WEB</a></li>
                    <li><a href="misvuelos">MIS VUELOS</a></li>
                </ul>

                <%                    if (usuario != null) {
                %>
                <form class="navbar-form navbar-right" role="search" action="limpiarUsuario">
                    <div class="form-group texto-usuario">
                        Bienvenido, <% out.println(usuario.getNombre()); %>
                    </div>
                    <button type="submit" class="btn btn-primary">Salir</button>
                </form>
                <%
                } else {%>
                <form class="navbar-form navbar-right" role="search" action="entrarUsuario">
                    <div class="form-group">
                        <input type="email" id="email" name="email" class="form-control" placeholder="e-mail" required>
                        <input type="password" id="contraseña" name="contraseña" class="form-control" placeholder="Contraseña" required>
                        <input type="hidden" name="jspOrigen" value="index.jsp" >
                    </div>
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </form>
                <%}%>

                <!--<form class="navbar-form navbar-right" role="search">
                    <div class="form-group">
                        <input type="email" id="email" class="form-control" placeholder="e-mail" required>
                        <input type="password" id="contraseña" class="form-control" placeholder="Contraseña" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </form>-->
            </div>
        </nav>
        <div class="container">

            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img src="images/dh_valencia_edit.jpg" alt="DH Valencia 15" class="imagen_carousel">
                        <div class="carousel-caption">
                            <h3>Valencia</h3>
                            <p>DreamHack Valencia(España) 2015</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="images/dh_summer_edit.jpg" alt="DH Estocolmo 15" class="imagen_carousel">
                        <div class="carousel-caption">
                            <h3>Estocolmo</h3>
                            <p>DreamHack Estocolmo(Suecia) 2015</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="images/dh_napoca_edit.jpg" alt="DH Napoca 15" class="imagen_carousel">
                        <div class="carousel-caption">
                            <h3>Cluj Napoca</h3>
                            <p>DreamHack Cluj Napoca(Rumania) 2015</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="images/dh_moscu_edit.jpg" alt="DH Moscu 15" class="imagen_carousel">
                        <div class="carousel-caption">
                            <h3>Moscu</h3>
                            <p>DreamHack Moscu(Rusia) 2015</p>
                        </div>
                    </div>
                </div>
                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <div class="row">
                <div class="col-md-10 col-md-offset-1" id="entradas">
                    <form action="dispatcherReserva">
                        <table class="tabla-reserva">
                            <tr>
                                <td>Desde</td>
                                <td>A</td>
                                <td><img src="images/icons/calendar.png" alt="up" width="18"> <img src="images/icons/up.png" alt="up" width="18"></td>
                                <td><img src="images/icons/calendar.png" alt="up" width="18"> <img src="images/icons/down.png" alt="up" width="18"></td>
                                <td>Viajeros</td>
                            </tr>
                            <tr>
                                <td>
                                    <select class="selectpicker" name="origen" id="origen" onchange="cambiaDestino(this.options[this.selectedIndex].value)">
                                        <option value="Valencia">Valencia</option>
                                        <option value="Estocolmo">Estocolmo</option>
                                        <option value="Cluj-Napoca">Cluj-Napoca</option>
                                        <option value="Moscu">Moscu</option>
                                    </select>
                                </td>
                                <td>
                                    <select class="selectpicker" name="destino" id="destino">
                                        <option value="Estocolmo">Estocolmo</option>
                                        <option value="Cluj-Napoca">Cluj-Napoca</option>
                                        <option value="Moscu">Moscu</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="text" id="fechaida" name="ida" class="fecha" placeholder="Ida" required>
                                </td>
                                <td>
                                    <input type="text" id="fechavuelta" name="vuelta" class="fecha" placeholder="Vuelta">
                                </td>
                                <td>
                                    <input type="text" id="viajeros" name="viajeros" value="1">
                                </td>
                                <td style="text-align: center;">
                                    <input type="submit" value="Buscar vuelo" class="btn btn-default">
                                </td>
                            </tr>
                        </table>
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

