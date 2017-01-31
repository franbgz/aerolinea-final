package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import clases.usuario;

public final class error_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");

    /*int codError = (Integer)session.getAttribute("codError");*/
    String msjError = (String) session.getAttribute("msjError");
    usuario usuario = (usuario) session.getAttribute("usuario");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"es\">\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("        <link rel=\"shortcut icon\" href=\"images/icons/favicon.png\" type=\"image/png\" />\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <title>DreamHack Airline - Error</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/cusom-theme.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/main.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/jquery-ui.theme.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/jquery-ui.css\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/jquery-ui.structure.css\">\n");
      out.write("        <script src=\"js/jquery-2.2.2.js\"></script>\n");
      out.write("        <script src=\"js/main.js\"></script>\n");
      out.write("        <script src=\"js/jquery-ui.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("        <nav class=\"navbar navbar-inverse\" role=\"navigation\">\n");
      out.write("            <!-- El logotipo y el icono que despliega el menú se agrupan\n");
      out.write("       para mostrarlos mejor en los dispositivos móviles -->\n");
      out.write("            <div class=\"navbar-header\">\n");
      out.write("                <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\".navbar-ex1-collapse\">\n");
      out.write("                    <span class=\"sr-only\">Desplegar navegación</span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                    <span class=\"icon-bar\"></span>\n");
      out.write("                </button>\n");
      out.write("                <a class=\"navbar-brand\" href=\"index.jsp\">DramHack Airline</a>\n");
      out.write("            </div>\n");
      out.write("            <!-- Agrupar los enlaces de navegación, los formularios y cualquier\n");
      out.write("       otro elemento que se pueda ocultar al minimizar la barra -->\n");
      out.write("            <div class=\"collapse navbar-collapse navbar-ex1-collapse\">\n");
      out.write("                <ul class=\"nav navbar-nav\">\n");
      out.write("                    <li class=\"active\"><a href=\"index.jsp\">INICIO</a></li>\n");
      out.write("                    <li><a href=\"#\">CHECK-IN WEB</a></li>\n");
      out.write("                    <li><a href=\"#\">MIS VUELOS</a></li>\n");
      out.write("                </ul>\n");
      out.write("                ");

                    if (usuario != null) {
                
      out.write("\n");
      out.write("                <form class=\"navbar-form navbar-right\" role=\"search\">\n");
      out.write("                    <div class=\"form-group texto-usuario\">\n");
      out.write("                        Bienvenido, ");
 out.println(usuario.getNombre());
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary\">Salir</button>\n");
      out.write("                </form>\n");
      out.write("\n");
      out.write("                ");
} else {
      out.write("\n");
      out.write("                <form class=\"navbar-form navbar-right\" role=\"search\">\n");
      out.write("                    <div class=\"form-group\">\n");
      out.write("                        <input type=\"email\" id=\"email\" class=\"form-control\" placeholder=\"e-mail\" required>\n");
      out.write("                        <input type=\"password\" id=\"contraseña\" class=\"form-control\" placeholder=\"Contraseña\" required>\n");
      out.write("                    </div>\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary\">Entrar</button>\n");
      out.write("                </form>\n");
      out.write("                ");
}
      out.write("\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-10 col-md-offset-1 cuerpoerror\">\n");
      out.write("                    <img src=\"images/icons/error2.png\" width=\"128\" style=\"float:left; margin-right: 20px;\">\n");
      out.write("                    <h1>Se produjo un error</h1>\n");
      out.write("                    <p>Codigo de error: ");
 /*out.print(codError);*/ 
      out.write("</p>\n");
      out.write("                    <p>Mensaje de error: ");
 out.print(msjError);
      out.write("</p>\n");
      out.write("                    <p>Puede volver a la pagina de inicio haciendo clic en el siguiente boton:\n");
      out.write("                    </p>\n");
      out.write("                    <p style=\"text-align: center\">\n");
      out.write("                        <a href=\"index.jsp\"><button class=\"btn btn-primary\">Inicio</button></a>\n");
      out.write("                    </p>\n");
      out.write("\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <script src=\"js/bootstrap.js\"></script>\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
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
