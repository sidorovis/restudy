
<%@ page import="java.util.*" %>

<%
    if (request.getParameter("logoff") != null) {
	session.invalidate();
	response.sendRedirect("index.jsp");
        return;
    }
    if( session.getAttribute("in_system") == null ) 
    {
        response.sendRedirect("login.html");
	return;
    }

%>
<html>
<head>
<title>C++ class references - base function list.</title>
</head>
<body>
<table width=100% align=center><tr><td bgcolor="#fff03a">
<a href=index.jsp>Main Menu</a><br/>
</td></tr>
<tr><td>

<%
	String[][] functions = (String[][])session.getAttribute("functions");
	ArrayList<String[]> ffunctions = (ArrayList<String[]>)session.getAttribute("ffunctions");
	if(functions != null && ffunctions == null) {
%>
		<table border="1" cellspacing="1" width=90% align=center>
			<tr>
				<th align=center>Name:</th>
				<th align=center>Description:</th>
				<th align=center>Theme:</th>
			</tr>
<%
		for(int i = 0; i < functions.length; i++) {
%>
			<tr>
				<td ><%=functions[i][0]%></td>
				<td ><%=functions[i][1]%></td>
				<td ><%=functions[i][2]%></td>
			</tr>
<%
		}
%>
		</table>

<%
		session.setAttribute("functions", null);
	}
%>	
</tr></td>
<tr><td>

<%
	if(ffunctions != null) {
	
%>
		<table border="1" cellspacing="0" width=90% align=center>
			<tr>
				<th align="center">Name</th>
				<th align="center">Description</th>
				<th align="center">Theme</th>
			</tr>
<%
		for(int i = 0; i < ffunctions.size(); i++) {
%>
			<tr>
				<td ><%=ffunctions.get(i)[0]%></td>
				<td ><%=ffunctions.get(i)[1]%></td>
				<td ><%=ffunctions.get(i)[2]%></td>
			</tr>
<%
		}
%>
		</table>
<%		
	}
		session.setAttribute("action", "showFunc");
		session.setAttribute("ffunctions", null);
		session.setAttribute("functions", null);
%>
</td></tr>
<tr><td bgcolor="#ff3286">
<TABLE width=100% align=center><tr><td><b><u>Actions:</td><td align=center>
<form method="POST" action='/aipos4' >
	<input type="hidden" name="action" value="sortFunctions">
	<input type="submit" <%=(functions == null) ? ("disabled") : ("")%> value="Sort Functions">
</td></form><td align=center>
<form method="POST" action='/aipos4' >
	<input type="hidden" name="action" value="findFunction">
	<input type="text" name="funcForFind">
	<input type="submit" value="Find Functions">
</td></form><td>
<form method="POST" action="/aipos4">
    <input type="hidden" name="action" value="showFunc">
    <input type="submit" src="img/exit.jpg" value="Refresh">
</td></form>
</tr>
</table>
</tr></td></table>
