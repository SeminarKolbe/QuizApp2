<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="de.projekt.model.DatenbankZugang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
        <title>Kategorieauswahl</title>
        <link rel="stylesheet" href="stylesheet.css" type="text/css"/>
    </head>
    <body>
        <div data-role="page">   
            <%! public List<String> kategorie() {

                    Connection con = null;
                    DatenbankZugang dbconnection = new DatenbankZugang();

                    List<String> help = new ArrayList<>();
                    try {
                        con = dbconnection.connect();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM thema;");
                        while (rs.next()) {
                            help.add("<a href=\"ControllerCategory?category=" + rs.getInt("idthema") + "\">" + rs.getString("name") + "</a>");
                        }
                        System.out.println(help);
                        con.close();
                    } catch (Exception e) {
                        System.out.println(e);
                        System.out.println("Bin in der Exception");
                    }
                    return help;
                }
            %>


 



            <% List<String> kategorie;
            %>
  <!-- HEADER-->
            <div data-role="header" data-theme="b" id="header">            
                <form action="LoginControllerServlet" method="post" class="ui-btn-left">
                    <button data-theme="a">Back</button>
                </form>    
                <h1>  L'Odyssee </h1>           
                <form action="LogoutController" method="post" class="ui-btn-right">
                    <button data-theme="a">Logout</button>
                </form>     
            </div>
<!-- /HEADER-->

            <div data-role="content" style="margin:10px">
            
                <h1>Herzlich Willkommen ${userName}!</h1>

                <!--Falls Kategorie ungültig oder falsch gewählt folgt eine Fehlermeldung -->
                <h2><font color="red">${errorMessage}</font></h2>
                <!-------------------------------->

                <p>Wähle eine Kategorie:</p>

                <div id="kategorieauswahl" style="text-align: center;">
                    <ul data-role="listview" data-ajax="false" data-inset="true" data-theme="c">
                <!-- KATEGORIEN WERDEN GELADEN -->    
                      <% kategorie = kategorie(); 
                        for (int i = 0; i < kategorie.size(); i++) {
                            out.print("<li>"+kategorie.get(i)+"</li>");
                        }
                        %></ul> 
                </div>
            </div>    
                <div data-role="footer" data-theme="c" id="footer"><h1></h1></div>
        </div>
    </body>
</html>