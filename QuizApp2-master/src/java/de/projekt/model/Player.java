/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package de.projekt.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jonas
 */
public class Player extends DatenbankZugang {
    private String name = null;
    private int user_id =1;
    private List<ResultSet> set  =new ArrayList<ResultSet>(); 
    private int id;
    private int points;

    public int getPoints() {
        return points;
    }
    
    public int getId() {
        return id;
    }
    
    public Player(String name, int points){
        this.name=name;
        this.points=points;
    }
    
    public Player(String name) throws ClassNotFoundException, SQLException{
        this.name=name;
    }
   
    
    public String getName(){
        return name;
    }
    
      public int getUser_id(){
        return user_id;
    } 
    
      
      
      public List<ResultSet> getDifficult(String thema) throws ClassNotFoundException, SQLException {
            connect();     
            Statement stmt= con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id-karte,gespielt, richtig,falsch FROM relation_beutzer_karten WHERE thema = '"+thema+"' AND id_benutzer = '"+user_id+"'");
            while(rs.next()){
                 set.add(rs);     // Jedes Resultset enthält einen Zeile der Tabelle relation_beutzer_karten
                                  // Diese werden nun an eine Liste angehängt  
            }
            for(int i=0;i<set.size();i++){                     // Liste wird sortiert   
                for(int j=i+1;j<set.size();j++){               // Vergleiche das erste Element mit dem nachfolgenden
                    ResultSet help1= (ResultSet) set.get(i);    
                    ResultSet help2= (ResultSet) set.get(j);
                double low = (double) (help1.getInt(4)/help1.getInt(5));    // In spalte 4 steht die Anzahl, wie oft die Karte falsch gemacht wurde wurde. In spalte 5 wie oft sie gespielt wurde
                    double high =(double) (help2.getInt(4)/help2.getInt(5));
                    if(low>high){                                               // Wenn die Karte oft falsch gemacht wurde, tausche Sie an die erste stelle der Liste
                        set.set(i,help1);
                        set.set(j,help2);
                    }
                }  
            }
            close();
            return set;     
        }
      
      public void getIdPlayer(String name) throws ClassNotFoundException, SQLException{
          connect();
          Statement stmt= con.createStatement();
          
          ResultSet rs = stmt.executeQuery("SELECT id_benutzer FROM benutzer WHERE name='"+name+"'");         
          int h=-1;
         
          if(rs.next())
              h= rs.getInt(1);
          this.id=h;
         
          
        }
      
      
      public void getLastDifficult(){}
}

