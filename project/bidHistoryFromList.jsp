
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
<%
int userClickedAid = Integer.parseInt(request.getParameter("Id"));
%>
<b> Bid history for Auction #</b> <%= userClickedAid %>
<br></br>

<% 
ApplicationDAO dao = new ApplicationDAO();
		
try 
{
       	Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://classvm69.cs.rutgers.edu:3306/yabeDatabase?autoReconnect=true";
      
        Connection conn = DriverManager.getConnection(connectionUrl,"root", "TorGorWit24");
        
        String vehicleQuery = "SELECT V.make, V.model, V.vtype FROM Vehicle V, Auction A WHERE A.aid=? AND V.VIN = A.VIN";
        PreparedStatement pt1 = conn.prepareStatement(vehicleQuery);
        pt1.setInt(1, userClickedAid);
        ResultSet rs1 = pt1.executeQuery();
%>

<% 
while(rs1.next())
{
%>
<b> Vehicle: </b> <%= rs1.getString("make") %> <%= rs1.getString("model") %> <%= rs1.getString("vtype") %>
<%
}
%>
<br></br>
<br></br>

<%
String bidQuery = "SELECT B.bidder, B.bid_amount, B.bid_date, B.bid_time FROM Auction A, Bid B WHERE A.aid = ? AND B.aid = A.aid";
PreparedStatement pt = conn.prepareStatement(bidQuery);
pt.setInt(1, userClickedAid);
ResultSet rs = pt.executeQuery();
%>

<%
boolean emptyRS = false;
if(!rs.isBeforeFirst())
{
	emptyRS = true;
%>
<b> No bids placed yet. </b>
<% 
}

if(!emptyRS)
{
%>	
	<table>
	<tr>
	<th>Bidder</th>
	<th>Bid Amount</th>
	<th>Bid Date</th>
	<th>Bid Time</th>
	</tr>
<%
while(rs.next()) 
{ 
%>
<tr>
<td> <%= rs.getString("bidder") %> </td>
<td> <%= rs.getString("bid_amount") %> </td>
<td> <%= rs.getString("bid_date") %> </td>
<td> <%= rs.getString("bid_time") %> </td>

</tr>
<%
}
}
%>

<%
rs1.close();
rs.close();
pt1.close();
pt.close();
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
</body>
</html>