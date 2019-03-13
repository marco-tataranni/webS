<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="javax.servlet.http.Cookie"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
    </head>
    <body>
    <%
        HttpSession ses =request.getSession(false);
        String output = "";
        if(request.getMethod().equals("GET"))
        {
            
            if(request.getParameter("logout")!=null && request.getParameter("logout").equals("true")){
              
              ses.invalidate();
              
              %>
               <meta http-equiv="refresh" content="0; url=/html/login.html">
              <%
                  
            }
            
            
            if (ses!= null)
            {
            
                
                output="benvenuto nella home "+((String)ses.getAttribute("user")); 
                
            }else
            {
              %>
               <meta http-equiv="refresh" content="0; url=/html/login.html">
              <%
            }
            

        
        }else if(request.getMethod().equals("POST"))
        {
            String connURL ="jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=zuliani.nicolo;user=zuliani.nicolo;password=xxx123#";
    
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            
            
            try { // Load SQL Server JDBC driver and establish connection.
              Connection connection = DriverManager.getConnection(connURL);
              
              
              //CALCOLO ID  
              String sql = "select MAX(id) as max from mw_users;";
    	      Statement s = connection.createStatement(); 
    	      ResultSet rs = s.executeQuery(sql);
              rs.next();
    	      int id = rs.getInt("max");
                
              //USER ESISTE
              sql = "select top 1 username from mw_users where username = ?;";
    	      PreparedStatement st = connection.prepareStatement(sql); 
    	      st.setString(1, request.getParameter("username"));
    	      ResultSet rs2 = st.executeQuery(); 
                  
    	      boolean existsUser = rs2.next();
    	      
    	      //EMAIL ESISTE
               sql = "select top 1 username from mw_users where mail = ?;";
    	      PreparedStatement st1 = connection.prepareStatement(sql); 
    	      st1.setString(1, request.getParameter("email"));
    	      ResultSet rs3 = st1.executeQuery(); 
                  
    	      boolean existsEmail = rs3.next();
    
              if(existsUser){
                  output+="Il tuo username e' gia' stato usato!<br>";
              }
              if(existsEmail){
                  output+="La tua mail e' gia' stato usata!<br>";
              }
              
              if(output.isEmpty()){
                if(request.getParameter("login")==null) {
                    
                    
                if(request.getParameter("nome")==null || request.getParameter("nome").isEmpty()){
                    output+="Non hai inserito il nome<br>";
                }
    	           
    	        if(request.getParameter("cognome")==null || request.getParameter("cognome").isEmpty()){
                    output+="Non hai inserito il cognome<br>";
                }
                
                if(request.getParameter("email")==null || request.getParameter("email").isEmpty()){
                    output+="Non hai inserito l'email<br>";
                }
                
                if(request.getParameter("username")==null || request.getParameter("username").isEmpty()){
                    output+="Non hai inserito il nome utente<br>";
                }
                
                if(request.getParameter("password")==null || request.getParameter("password").isEmpty()){
                    output+="Non hai inserito la password<br>";
                }          
    	         
    	        if(output.isEmpty()){
    	            sql = "INSERT INTO mw_users(id,nome,cognome,mail,psw,username) VALUES(?,?,?,?,?,?)";
    		       PreparedStatement st2 = connection.prepareStatement(sql); 
    		       st2.setInt(1, id + 1);
       			   st2.setString(2, request.getParameter("nome"));
    			   st2.setString(3, request.getParameter("cognome"));
         		   st2.setString(4, request.getParameter("email"));
    			   st2.setString(5, request.getParameter("password"));
    		       st2.setString(6, request.getParameter("username"));
    			   st2.executeUpdate();
    	           output="Registrato con successo! <br> <a href=\"home.jsp?logout=true\">Logout</a>"; 
    	           
    	           HttpSession sessionR= request.getSession();
    	           sessionR.setAttribute("user", request.getParameter("username"));
    	        }
    	           
    	           
    	       
                }else if (request.getParameter("register")==null) {
                    
                       if(request.getParameter("LoginUser")==null || request.getParameter("LoginUser").isEmpty()){
                    output+="Non hai inserito il nome utente<br>";
                 }
                
                 if(request.getParameter("LoginPassword")==null || request.getParameter("LoginPassword").isEmpty()){
                     output+="Non hai inserito la password<br>";
                 }  
                 
                 if(output.isEmpty()){
                     sql = "select top 1 mail from mw_users where username = ? AND psw = ?;";
    	 
    	             PreparedStatement st3 = connection.prepareStatement(sql);
    	             st3.setString(1, request.getParameter("LoginUser"));
    	             st3.setString(2, request.getParameter("LoginPassword"));
    	             ResultSet rs4 = st3.executeQuery(); 
                  
    	             if(rs4.next()){
    	               output="Bentornato nella home! <br> <a href=\"home.jsp?logout=true\">Logout</a>";
    	               HttpSession session= request.getSession();
    	               session.setAttribute("user", request.getParameter("LoginUser"));
    	               //LOGGATO
    	             } 
                 }
    
              
                }            
              }
                     
              connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }finally{
              if(output.isEmpty())
                output = "Errore di connessione"; 
            }
    
            }
            
    %>
    
    <p><%= output %></p>
    
    
   
    
      
    </body>
</html>