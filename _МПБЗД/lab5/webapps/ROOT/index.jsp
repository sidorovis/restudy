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
<title>C++ class references</title>
</head>
<body>
<table width=100%><tr><td align=right bgcolor="#EEEE00">
<form method="POST" action='index.jsp'>
    <input type="hidden" name="logoff" value="true">
    <input type="submit" src="img/exit.jpg" value="Log Off!">
</td></form></tr>
<tr><td bgcolor="#DDDDD00">
<form method="POST" action="/aipos4">
    <input type="hidden" name="action" value="showFunc">
    <input type="submit" src="img/exit.jpg" value="Function List">
</td></form></tr>
<tr><td bgcolor="#AA8877">
<%
	if(session.getAttribute("in_system").equals("1")) {
%>
	<form method="POST" action='/aipos4' >
		<input type="hidden" name="action" value="addFunction">
	  <table border="0" cellspacing="1">
	    <tr>
	      <th align="right">Name:</th>
	      <td align="left"><input type="text" name="func"></td>
	    </tr>
	    <tr>
	      <th align="right">Description:</th>
	      <td align="left"><TEXTAREA NAME="args" COLS=40 ROWS=6></TEXTAREA></td>
	    </tr>
		<tr>
	      <th align="right">Theme:</th>
	      <td align="left"><TEXTAREA NAME="descr" COLS=40 ROWS=6></TEXTAREA></td>
	    </tr>
	    <tr>
	      <td align="right"><input type="submit" value="Add Function"></td>
	      <td align="left"><input type="reset"></td>
	    </tr>
	  </table>
	</form>
<%
	}
	else
	{
%>
	If you have an admin right, logon like admin. and i'll get panel to add functions.<br>
	This posibiliti is main posibility to work with base.<hr/>
	Use if you can!<br>
	<table align=center><tr><td>
	Funny picture that can see only users. <br/>
	<img src="img/humor.jpg">
	</td></tr></table>
<%
	}
%>
</table>

</body>
</html>
