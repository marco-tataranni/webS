<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Elenco giudici XFactor</title>
    </head>
    <body>
        <h1>Elenco dei giudici di XFactor</h1>
        <% 
            
            String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=XFactor;user=titze.walter;password=galvani@2018";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            Connection connection = DriverManager.getConnection(connectionUrl);
			
			Statement stmt = connection.createStatement();

			String sql = "SELECT * FROM Giudice order by Cognome";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			out.print("<table>");
			
			out.print("<tr><th align=left>Cognome</th><th align=left>Nome</th></tr>");
			
    		while(rs.next()){

				String Nome = rs.getString("Nome");
				String Cognome = rs.getString("Cognome");
                
                out.print("<tr><td>" + Cognome + "</td><td>" + Nome + "</td></tr>");

	        }
	        
	        out.print("</table>");
	        
	        rs.close();
	        
	        connection.close();
        
        %>
    </body>
</html>