<%-- 
    Document   : AusgabeMultiplayer
    Created on : 04.07.2016, 18:53:29
    Author     : Jonas
--%>


<%@page import="de.projekt.model.AntwortenUebergabe"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.css" />
        <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
        <script src="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.js"></script>
        <title>Multiplayer</title>
        </style>
        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    </head>
    <body>
         <%
         int right= 0;
         int wrong =0;
         boolean lantwort= true;
         int i=0;
         int [] santworten ={0};
         String res="0";
         int gesamteantworten=5;
         
         String namegegner = (String)request.getAttribute("namegegner");
         String frage = (String)request.getAttribute("frage");
         String antwor1 = (String)request.getAttribute("antwor1");
         String antwor2 = (String)request.getAttribute("antwor2");
         String antwor3 = (String)request.getAttribute("antwor3");
         String antwor4 = (String)request.getAttribute("antwor4");
         String antwor5 = (String)request.getAttribute("antwor5");
         String checkanswer= (String)request.getAttribute("checkanswer");
         
        
         if(checkanswer.equals("0"))
            res="1";
         
         
         String correct1 = (String)request.getAttribute("correct1");
         String correct2 = (String)request.getAttribute("correct2");
        
         String correct3 = (String)request.getAttribute("correct3");
         String correct4 = (String)request.getAttribute("correct4");
         String correct5 = (String)request.getAttribute("correct5");
        //______________Zum Häckchen setzen in den alten kästchen____________
          String abgegeben = (String) request.getAttribute("abgegeben");
          
          
          
          if(antwor5.equals("")){
              gesamteantworten--;    
          }
          if(abgegeben!=null){
                    
                    AntwortenUebergabe help =(AntwortenUebergabe) request.getAttribute("santworten");
                 if(antwor5.equals("")){
                     lantwort = false;
                 }
                 santworten = help.getSantworten();
                 
                 
          }
          
          
          
         //String user1 = (String)request.getAttribute("user1");
         //String user2 = (String)request.getAttribute("user2");
         //String user3 = (String)request.getAttribute("user3");
         //String user4 = (String)request.getAttribute("user4");
         //String user5 = (String)request.getAttribute("user5");
    %>
        
    
        
    <%! // gibt zurück, ob die der Benutzer ein Häckchen in das Kästschen an der stelle b gesetzt hat
        public boolean answerCheck(int[] a, int b){
            for(int i=0;i<a.length;i++){
                    if(a[i]==b){
                     return true;
                    }
            }
      return false;
        }       
        
        //Gibt einen Hacken zurückfalls die richtige Antwort angekreuz wurde, oder keine falsche antwort. Sonst wird ein Kreuz ausgegeben
        public String correct(int pos,String correct, int [] santworten){
              if(correct.equals("1")&&answerCheck(santworten,pos)==true){ 
                return "✔";
            }if(!correct.equals("1")&& answerCheck(santworten,pos)==false){
               return "✔";
              }else
              return "\u2718";
        }
        %>
        
          <div data-role="header" data-theme="b" id="header">            
                <form action="LoginControllerServlet" method="post" class="ui-btn-left">
                    <button data-theme="a">Back</button>
                </form>    
                <h1>  L'Odyssee </h1>           
                <form action="LogoutController" method=""post class="ui-btn-right">
                    <button data-theme="a">Logout</button>
                </form>     
            </div>
        <div data-role="content" style="margin:10px">
        
        <p><%out.println("Du spielst gegen: "+namegegner);%><p>
        
        <p> <b>Frage</b>: <%out.println(frage);%>
      
       
        <form action="VerarbeitungsControllerMulti?res=<%out.print(res);%>" method="post">
            <fieldset data-role="controlgroup"  data-theme="a">
                <label>
                <input name="antwort" type="Checkbox" value="a1"<%if(abgegeben!=null &&answerCheck(santworten,1))out.println("checked=\"checked\"");%>><%out.println(antwor1);%> <% if(checkanswer.equals("1"))out.println(correct(1,correct1,santworten));%> 
                </label><br>
                
                <input name="antwort" type="Checkbox" value="a2"<%if(abgegeben!=null &&answerCheck(santworten,2))out.println("checked=\"checked\"");%>><%out.println(antwor2);%><% if(checkanswer.equals("1"))out.println(correct(2,correct2,santworten));%> <br>
        <input name="antwort" type="Checkbox" value="a3"<%if(abgegeben!=null &&answerCheck(santworten,3))out.println("checked=\"checked\"");%>><%out.println(antwor3);%><% if(checkanswer.equals("1"))out.println(correct(3,correct3,santworten));%><br>
        <input name="antwort" type="Checkbox" value="a4"<%if(abgegeben!=null &&answerCheck(santworten,4))out.println("checked=\"checked\"");%>><%out.println(antwor4);%><% if(checkanswer.equals("1"))out.println(correct(4,correct4,santworten));%><br>
        
        <!-- To-do : antwor5.equals("") um alle Fragen, falls es zum beispiel keine 4 Fragen hab-->
        <!-- To-do 2 : Leere Frage auf der DatenBank löschen/ sonst gibt es manchmal einen Fehler-->
        <!-- To-do 3 : Zurückbutton und Log-out-->
        <!-- To-do 4 : Einzelspielermodus, die Antwort wird nicht angezeigt-->
        <!-- To-do 5 : Backend Button zum hochladen von Datein-->
        <!-- To-do 6 : Mehrspielermodus und Ranking fertig-->
        <!-- To-do 7 : Designe-->
        <!--____________Nice to have_____________-->
        <!-- To-do 1 : Kategorien nach Stadt ordnen-->
        
         <% if(!antwor5.equals("")){
            out.println("<input name=\"antwort\" type=\"Checkbox\" value=\"a5\">"+antwor5); 
            if(checkanswer.equals("1"+ ""))
                out.println(correct(5,correct5, santworten));
            }
         %>
            </fieldset>
        </p>
       
            <button>nächste Frage</button>
            
        </form>
    </div>          
          
      
      
        <div data-role="footer" data-theme="c" id="footer"><h1></h1></div>
       
    </body>
</html>
