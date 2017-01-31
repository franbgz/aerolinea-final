<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="images/icons/favicon.png" type="image/png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>DreamHack Airline - Log In</title>
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
            </div>
        </nav>
        <div class="container">

            <div class="row">
                <div class="col-md-10 col-md-offset-1 cuerporeserva">
                    <img src="images/logo.png" height="57" style="float: right">
                    <h2 style="border-bottom: 1px solid black;">Inicia sesión para continuar</h2>
                    <form action="entrarUsuario2">
                        <table class="tabla-login">
                            <%try {
                                    int codError = (Integer) session.getAttribute("codError");
                                    if (codError == 3) { %>
                            <div class="alert alert-danger alert-dismissable aviso" style="width: 40%; margin: 0 auto;">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                No existe ningun usuario con ese email y/o contraseña
                            </div>
                            <%}
                                    session.removeAttribute("codError");
                                } catch (NullPointerException er) {
                                }
                            %>
                            <tr>
                                <td>e-mail</td>
                                <td><input type="text" name="email" placeholder="e-mail" class="form-control" required></td>
                            </tr>
                            <tr>
                                <td>Contraseña</td>
                                <td><input type="password" name="contraseña" placeholder="Contraseña" class="form-control" required></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" class="btn btn-primary" value="Entrar"></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
    </body>

</html>
