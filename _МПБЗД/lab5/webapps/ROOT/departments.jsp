<%@ page import="java.util.*" %>
<title>Departments</title>

<table width=100% align=center>
    <tr>
        <td>
            
        </td>
        <td>
<table width=80% align=center border=1>
    <tr>
	<th>Title</th>
	<th>About</th>
	<th width=20%>Controls</th>
    </tr>
<%
    String[][] departments = (String[][])session.getAttribute("departments");
    if (departments != null)

    for (int i = 0 ; i < departments.length ; i++)
    {
%>
    <tr>
        <td align=center><%= departments[i][0] %></td>
        <td><%= departments[i][1] %></td>
	<td>
	    <form method=POST action=/del_department>
			<input type=hidden name=title value = '<%=departments[i][0] %>' >
			<input type=hidden name=about value = '<%=departments[i][1] %>' >
			<input type=submit value=Delete>
	    </form>
	    <form method=POST action=/pre_upd_department>
			<input type=hidden name=title value = '<%=departments[i][0] %>' >
			<input type=hidden name=about value = '<%=departments[i][1] %>' >
			<input type=submit value=Update>
	    </form>
	</td>
    </tr>
<%
    }
%>
</table>
        </td>
    </tr>
</table>
<a href=index.html>Main menu</a> | <a href=depservlet>Refresh</a> | <a href=new_department.html>Add department</a>