/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.projekt.controller;

import de.projekt.model.Karteikarte;
import de.projekt.model.Multi;
import de.projekt.model.Player;
import de.projekt.model.DatenbankZugang;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Shaun
 */
@WebServlet(name = "ControllerCategory", urlPatterns = {"/ControllerCategory"})
public class ControllerCategory extends HttpServlet {
       public static String thema=null;

       /*final String JDBC_TREIBER = "com.mysql.jdbc.Driver";
       final String JDBC_URL = "jdbc:mysql://127.0.0.1:3307/mob164db";
       final String JDBC_USER = "mob164";      // Hier Wert eintragen!
       final String JDBC_PASSWORD = "S!ya0V8scj";  // Hier Wert eintragen! // Hier Wert eintragen!*/
       Connection con= null;
       DatenbankZugang dbconnection = new DatenbankZugang();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {  
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if(thema==null){
    //______ Abgleich des Themas mit der Datenbank _______       
            int categoryId;  // jeder Kategorie hat einen Wert / Vortlaufender Wert auf der Datenbank
            String strCategoryParameter = request.getParameter("category");
            try{
                categoryId = Integer.parseInt(strCategoryParameter);
                con = dbconnection.connect();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM thema WHERE idthema='"+categoryId+"';");
                if(rs.next()){   
                    thema=rs.getString("name");
                }
                con.close();
            }catch (Exception e){
                System.out.println(e);
                forwardToErrorView(request, response, "Es wurde keine gültige Kategorie ausgewählt!" +e);
                 /* Und den Controller verlassen! */
                return;
            }
    //________________       
                    
            HttpSession session = request.getSession();
            System.out.println("ControllerCategory Session: " + session);
            Multi ueberpruefen= new Multi((Player) session.getAttribute("player"));
            System.out.println("ControllerCategory Player: " + (Player)session.getAttribute("player") + "\n" + "ueberpruefen: " + ueberpruefen);
            
        //______ Überprüft ob ein Gegner eine Anfrage gestellt hat ______    
            try{
                int[] anfrageid= ueberpruefen.checkAnfrage(); // Guckt ob für den Spieler Spielanfargen vorliegen
                List <String> name =new ArrayList<String>();
                for(int i=0;i<anfrageid.length;i++){
                    name.add(ueberpruefen.getPlayer(anfrageid[i]));  // Sucht anhander der Game-Id eines Duell den Passenden Spieler und gibt diesen als String zurück
                }
                request.setAttribute("anfrageid", anfrageid);  //übergeben der einzelnen id's der Multiplayerspiele
                request.setAttribute("anfrage", name); // übergibt einen Namen mit dem String des Gegners
            }catch(Exception e){
                System.out.println("ControllerCategory.java / Bin in der Exception, als ich probiert habe die Anfragen für die Multigames zu laden");
                System.out.println(e);
            }
            
        /*Wenn die Kategorie erfolgreich gewählt wurde
         *Weiterleitung zur Wahl des Spielmodus*/
            request.getRequestDispatcher("/WEB-INF/views/Spielmodiwahl.jsp").forward(request, response);
        /*Wenn die Variable Thema nicht 0 ist, wurde schon eine Kategorie ausgewählt. Dann Soll noch bestimmt werden, ob es sich
            um einen Single- oder multi-player handelt.
       */
  // Sobald der Spieler weiter zur Spielmodiwahl geleitet wurde, ist das Thema festgelegt. Da der ControllerCategory auch desen Anfragen verarbeitet
  // wird er automatisch in die else geleitet
            }else{
            String playmode = request.getParameter("category");
            //single-Player 
            if("3".equals(playmode)){
               request.setAttribute("uebergabe", thema);
               request.getRequestDispatcher("VerarbeitungsControllerSingle").forward(request, response);
               System.out.println("Hier bin ich im singleplayer-Modus.");
               return;
            }else if("2".equals(playmode) || "0".equals(playmode)){
                request.getRequestDispatcher("VerarbeitungsControllerMulti").forward(request, response);
                System.out.println("Hier bin ich im multiplayer-Modus.");
                return;
            }
        }
    }
        
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void forwardToErrorView(HttpServletRequest request, HttpServletResponse response, String errorMessage) 
            throws ServletException, IOException{
        /* Fehlermeldung im Request-Scope hinterlegen, damit die View sie anzeigen kann: */
		request.setAttribute("errorMessage", errorMessage);
                request.getRequestDispatcher("/WEB-INF/views/category.jsp").forward(request, response);
    } 

}
