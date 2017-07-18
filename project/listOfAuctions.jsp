<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*" import ="java.util.*" import ="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Yabe</title>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
</head>
<body>
<b> Click the Auction ID to view bid history for that vehicle. </b> 
<br></br>
<br></br>

<% 
ApplicationDAO dao = new ApplicationDAO();
		
try 
{
       	Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://classvm69.cs.rutgers.edu:3306/yabeDatabase?autoReconnect=true";
      
        Connection conn = DriverManager.getConnection(connectionUrl,"root", "TorGorWit24");
        
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT DISTINCT A.aid, V.make, V.model, V.vtype FROM Auction A, Vehicle V WHERE V.VIN = A.VIN ORDER BY A.aid");
%>
<table>
<tr>
<th>Auction ID</th>
<th>Vehicle</th>
</tr>
<%
while(rs.next()) 
{ 
%>
<tr>
<td> <a href=<%= "\"bidHistoryFromList.jsp?Id=" + rs.getInt("aid") + "\"" %>> <%= rs.getInt("aid") %> </a></td>
<td> <%= rs.getString("make") %> <%= rs.getString("model") %> <%= rs.getString("vtype") %></td>
</tr>
<%
}
%>

<%
rs.close();
stmt.close();
conn.close();
}
catch(SQLException sqle)
{
	out.println(sqle.getMessage());
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>


</table>
</body>
</html>