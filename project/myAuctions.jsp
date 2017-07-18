<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*" import ="java.util.*" import="java.sql.*" %>
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
ApplicationDAO dao = new ApplicationDAO();
String current_user = (String) request.getSession().getAttribute("current_user"); 
%>
<b>Auction History for <%= current_user %> </b> 
<br></br>

<% 	
try 
{
       	Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://classvm69.cs.rutgers.edu:3306/yabeDatabase?autoReconnect=true";
      
        Connection conn = DriverManager.getConnection(connectionUrl,"root", "TorGorWit24");
        
        String boughtQuery = "SELECT DISTINCT A.aid, V.make, V.model, V.vtype FROM Auction A, Vehicle V, Bid B WHERE B.bidder = ? AND B.aid = A.aid AND V.VIN = A.VIN AND A.winner = B.bidder";
        PreparedStatement pt1 = conn.prepareStatement(boughtQuery);
        pt1.setString(1, current_user);
        ResultSet rs1 = pt1.executeQuery();
%>
<br></br>
<b>Vehicles I bought:</b> 
<br></br>

<%
boolean boughtNothing = false;
if(!rs1.isBeforeFirst())
{
	boughtNothing = true;
%>
<i> You haven't bought any vehicles yet. </i>
<% 
}

if(!boughtNothing)
{
%>	
<table>
<tr>
<th>Auction ID</th>
<th>Vehicle</th>
</tr>
<%
while(rs1.next()) 
{ 
%>
<tr>
<td> <%= rs1.getInt("aid") %> </td>
<td> <%= rs1.getString("make") %> <%= rs1.getString("model") %> <%= rs1.getString("vtype") %></td>
</tr>
<%
}
}
%>
</table>

<br></br>
<br></br>
<b>Vehicles I have bid on:</b> 
<br></br>
<%      
        String bidOnQuery = "SELECT DISTINCT A.aid, V.make, V.model, V.vtype FROM Auction A, Vehicle V, Bid B WHERE B.bidder = ? AND B.aid = A.aid AND V.VIN = A.VIN";
        PreparedStatement pt2 = conn.prepareStatement(bidOnQuery);
        pt2.setString(1, current_user);
        ResultSet rs2 = pt2.executeQuery();
%>
<%
boolean bidOnNothing = false;
if(!rs2.isBeforeFirst())
{
	bidOnNothing = true;
%>
<i> You haven't bid on any vehicles yet. </i>
<% 
}

if(!bidOnNothing)
{
%>	
<table>
<tr>
<th>Auction ID</th>
<th>Vehicle</th>
</tr>
<%
while(rs2.next()) 
{ 
%>
<tr>
<td> <%= rs2.getInt("aid") %> </td>
<td> <%= rs2.getString("make") %> <%= rs2.getString("model") %> <%= rs2.getString("vtype") %></td>
</tr>
<%
}
}
%>
</table>

<br></br>
<br></br>
<b>Vehicles I sold:</b> 
<br></br>
<%      
        String soldQuery = "SELECT DISTINCT A.aid, V.make, V.model, V.vtype FROM Auction A, Vehicle V WHERE A.seller = ? AND V.VIN = A.VIN AND A.winner IS NOT NULL";
        PreparedStatement pt3 = conn.prepareStatement(soldQuery);
        pt3.setString(1, current_user);
        ResultSet rs3 = pt3.executeQuery();
%>
<%
boolean soldNothing = false;
if(!rs3.isBeforeFirst())
{
	soldNothing = true;
%>
<i> You haven't sold any vehicles yet. </i>
<% 
}

if(!soldNothing)
{
%>	
<table>
<tr>
<th>Auction ID</th>
<th>Vehicle</th>
</tr>
<%
while(rs3.next()) 
{ 
%>
<tr>
<td> <%= rs3.getInt("aid") %> </td>
<td> <%= rs3.getString("make") %> <%= rs3.getString("model") %> <%= rs3.getString("vtype") %></td>
</tr>
<%
}
}
%>
</table>

<br></br>
<br></br>
<b>Vehicles I am selling:</b> 
<br></br>
<%      
        String amSellingQuery = "SELECT A.aid, V.make, V.model, V.vtype FROM Auction A, Vehicle V WHERE A.seller = ? AND V.VIN = A.VIN AND A.winner IS NULL";
        PreparedStatement pt4 = conn.prepareStatement(amSellingQuery);
        pt4.setString(1, current_user);
        ResultSet rs4 = pt4.executeQuery();
%>
<%
boolean amSellingNothing = false;
if(!rs4.isBeforeFirst())
{
	amSellingNothing = true;
%>
<i> You are not currently selling any vehicles. </i>
<% 
}

if(!amSellingNothing)
{
%>	
<table>
<tr>
<th>Auction ID</th>
<th>Vehicle</th>
</tr>
<%
while(rs4.next()) 
{ 
%>
<tr>
<td> <%= rs4.getInt("aid") %> </td>
<td> <%= rs4.getString("make") %> <%= rs4.getString("model") %> <%= rs4.getString("vtype") %></td>
</tr>
<%
}
}
%>
</table>

<br>
<br>
<b> What vehicles are my friends interested in? </b>
<br>
<form action = friendBidHistory.jsp>
Enter your friend's username: 
<input type="text" name="friendUsername" >
<input type="submit" value="Submit">
</form>

<%
rs1.close();
pt1.close();
rs2.close();
pt2.close();
rs3.close();
pt3.close();
rs4.close();
pt4.close();
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