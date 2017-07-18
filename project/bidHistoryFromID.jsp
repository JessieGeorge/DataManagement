<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*" import ="java.util.*" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Yabe</title>
</head>
<body>
<% 
ApplicationDAO dao = new ApplicationDAO();
try 
{
       	Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connectionUrl = "jdbc:mysql://classvm69.cs.rutgers.edu:3306/yabeDatabase?autoReconnect=true";
      
        Connection conn = DriverManager.getConnection(connectionUrl,"root", "TorGorWit24");
        
        String allAIDQuery = "SELECT A.aid FROM Auction A";
        PreparedStatement pt1 = conn.prepareStatement(allAIDQuery);
        ResultSet rs1 = pt1.executeQuery();
      
String a;
a = request.getParameter("userRequestedAid").toString();
if(!a.matches("[0-9]+"))
{
%>
<b> Invalid entry. </b>

<% 	
}
else
{
  int givenAid = Integer.parseInt(a);
  
  boolean validAID = false; 
  while(rs1.next())
  {
  	if(givenAid==rs1.getInt("aid"))
  	{	validAID = true;
  		break;
  	}
  }
  
  if(!validAID)
	{%>
	<b> Invalid entry. </b>
	<% 
	}
  else
  {
	  //go to bid History from list 
%>
	  <a href=<%= "\"bidHistoryFromList.jsp?Id=" + givenAid + "\"" %>> Bid History for <%= givenAid %> </a>
<%
  }
}
%>
<%
rs1.close();
pt1.close();
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