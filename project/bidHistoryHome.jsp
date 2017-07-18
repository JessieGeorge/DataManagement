<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*" import ="java.util.*" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Yabe</title>
</head>
<body>

<form action = bidHistoryFromID.jsp>
Enter Auction ID: 
<input type="text" name="userRequestedAid" >
<input type="submit" value="View Bid History">
</form>
<br>
<br>
OR
<br>
<br>

<!-- add link here -->
<a href = "listOfAuctions.jsp"> Select from list of auctions </a>
</body>
</html>