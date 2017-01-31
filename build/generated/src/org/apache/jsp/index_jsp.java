package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"es\">\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <link rel=\"shortcut icon\" href=\"images/icons/favicon.png\" type=\"image/png\" />\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <title>DreamHack Airline - Inicio</title>\n");
      out.write("    <!--<link href=\"css/bootstrap.css\" rel=\"stylesheet\" media=\"screen\">-->\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/cusom-theme.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/main.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/jquery-ui.theme.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/jquery-ui.css\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/jquery-ui.structure.css\">\n");
      out.write("    <script src=\"js/jquery-2.2.2.js\"></script>\n");
      out.write("    <script src=\"js/main.js\"></script>\n");
      out.write("    <script src=\"js/jquery-ui.min.js\"></script>\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body>\n");
      out.write("<nav class=\"navbar navbar-inverse\" role=\"navigation\">\n");
      out.write("            <!-- El logotipo y el icono que despliega el menú se agrupan\n");
      out.write("       para mostrarlos mejor en los dispositivos móviles -->\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\".navbar-ex1-collapse\">\n");
      out.write("                    <span class=\"sr-only\">Desplegar navegación</span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                </button>\n");
      out.write("                <a class=\"navbar-brand\" href=\"#\">DramHack Airline</a>\n");
      out.write("            </div>\n");
      out.write("            <!-- Agrupar los enlaces de navegación, los formularios y cualquier\n");
      out.write("       otro elemento que se pueda ocultar al minimizar la barra -->\n");
      out.write("            <div class=\"collapse navbar-collapse navbar-ex1-collapse\">\n");
      out.write("                <ul class=\"nav navbar-nav\">\n");
      out.write("                    <li class=\"active\"><a href=\"#\">INICIO</a></li>\n");
      out.write("                    <li><a href=\"#\">CHECK-IN WEB</a></li>\n");
      out.write("                    <li><a href=\"#\">MIS VUELOS</a></li>\n");
      out.write("                </ul>\n");
      out.write("                <form class=\"navbar-form navbar-right\" role=\"search\">\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                        <input type=\"email\" id=\"email\" class=\"form-control\" placeholder=\"e-mail\" required>\n");
      out.write("                        <input type=\"password\" id=\"contraseña\" class=\"form-control\" placeholder=\"Contraseña\" required>\n");
      out.write("                    </div>\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary\">Entrar</button>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("    <div class=\"container\">\n");
      out.write("        \n");
      out.write("        <div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">\n");
      out.write("            <!-- Indicators -->\n");
      out.write("            <ol class=\"carousel-indicators\">\n");
      out.write("                <li data-target=\"#myCarousel\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                <li data-target=\"#myCarousel\" data-slide-to=\"1\"></li>\n");
      out.write("                <li data-target=\"#myCarousel\" data-slide-to=\"2\"></li>\n");
      out.write("                <li data-target=\"#myCarousel\" data-slide-to=\"3\"></li>\n");
      out.write("            </ol>\n");
      out.write("            <!-- Wrapper for slides -->\n");
      out.write("            <div class=\"carousel-inner\" role=\"listbox\">\n");
      out.write("                <div class=\"item active\">\n");
      out.write("                    <img src=\"images/dh_valencia_edit.jpg\" alt=\"DH Valencia 15\" class=\"imagen_carousel\">\n");
      out.write("                    <div class=\"carousel-caption\">\n");
      out.write("                        <h3>Valencia</h3>\n");
      out.write("                        <p>DreamHack Valencia(España) 2015</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"item\">\n");
      out.write("                    <img src=\"images/dh_summer_edit.jpg\" alt=\"DH Estocolmo 15\" class=\"imagen_carousel\">\n");
      out.write("                    <div class=\"carousel-caption\">\n");
      out.write("                        <h3>Estocolmo</h3>\n");
      out.write("                        <p>DreamHack Estocolmo(Suecia) 2015</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"item\">\n");
      out.write("                    <img src=\"images/dh_napoca_edit.jpg\" alt=\"DH Napoca 15\" class=\"imagen_carousel\">\n");
      out.write("                    <div class=\"carousel-caption\">\n");
      out.write("                        <h3>Cluj Napoca</h3>\n");
      out.write("                        <p>DreamHack Cluj Napoca(Rumania) 2015</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"item\">\n");
      out.write("                    <img src=\"images/dh_moscu_edit.jpg\" alt=\"DH Moscu 15\" class=\"imagen_carousel\">\n");
      out.write("                    <div class=\"carousel-caption\">\n");
      out.write("                        <h3>Moscu</h3>\n");
      out.write("                        <p>DreamHack Moscu(Rusia) 2015</p>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <!-- Left and right controls -->\n");
      out.write("            <a class=\"left carousel-control\" href=\"#myCarousel\" role=\"button\" data-slide=\"prev\">\n");
      out.write("                <span class=\"glyphicon glyphicon-chevron-left\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"sr-only\">Previous</span>\n");
      out.write("            </a>\n");
      out.write("            <a class=\"right carousel-control\" href=\"#myCarousel\" role=\"button\" data-slide=\"next\">\n");
      out.write("                <span class=\"glyphicon glyphicon-chevron-right\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"sr-only\">Next</span>\n");
      out.write("            </a>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"row\">\n");
      out.write("            <div class=\"col-md-10 col-md-offset-1\" id=\"entradas\">\n");
      out.write("                <form action=\"dispatcherReserva\">\n");
      out.write("                    <table class=\"tabla-reserva\">\n");
      out.write("                        <tr>\n");
      out.write("                            <td>Desde:</td>\n");
      out.write("                            <td>A:</td>\n");
      out.write("                            <td><img src=\"images/icons/calendar.png\" alt=\"up\" width=\"18\"> <img src=\"images/icons/up.png\" alt=\"up\" width=\"18\"></td>\n");
      out.write("                            <td><img src=\"images/icons/calendar.png\" alt=\"up\" width=\"18\"> <img src=\"images/icons/down.png\" alt=\"up\" width=\"18\"></td>\n");
      out.write("                            <td>Viajeros</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <td>\n");
      out.write("                                <select class=\"selectpicker\" name=\"origen\" id=\"origen\" onchange=\"cambiaDestino(this.options[this.selectedIndex].value)\">\n");
      out.write("                                    <option value=\"Valencia\">Valencia</option>\n");
      out.write("                                    <option value=\"Estocolmo\">Estocolmo</option>\n");
      out.write("                                    <option value=\"Cluj-Napoca\">Cluj-Napoca</option>\n");
      out.write("                                    <option value=\"Moscu\">Moscu</option>\n");
      out.write("                                </select>\n");
      out.write("                            </td>\n");
      out.write("                            <td>\n");
      out.write("                                <select class=\"selectpicker\" name=\"destino\" id=\"destino\">\n");
      out.write("                                    <option value=\"Estocolmo\">Estocolmo</option>\n");
      out.write("                                    <option value=\"Cluj-Napoca\">Cluj-Napoca</option>\n");
      out.write("                                    <option value=\"Moscu\">Moscu</option>\n");
      out.write("                                </select>\n");
      out.write("                            </td>\n");
      out.write("                            <td>\n");
      out.write("                                <input type=\"text\" id=\"fechaida\" name=\"ida\" class=\"fecha\" placeholder=\"Ida\" required>\n");
      out.write("                            </td>\n");
      out.write("                            <td>\n");
      out.write("                                <input type=\"text\" id=\"fechavuelta\" name=\"vuelta\" class=\"fecha\" placeholder=\"Vuelta\">\n");
      out.write("                            </td>\n");
      out.write("                            <td>\n");
      out.write("                                <input type=\"text\" id=\"viajeros\" name=\"viajeros\" value=\"1\">\n");
      out.write("                            </td>\n");
      out.write("                            <td style=\"text-align: center;\">\n");
      out.write("                                <input type=\"submit\" value=\"Buscar vuelo\" class=\"btn btn-default\">\n");
      out.write("                            </td>\n");
      out.write("                        </tr>\n");
      out.write("                    </table>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    <script src=\"js/bootstrap.js\"></script>\n");
      out.write("</body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
