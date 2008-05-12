<%@ page import="java.util.*" %>
<title>Proffs</title>

<table width=100% align=center>
    <tr>
        <td>
            
        </td>
        <td>
<table width=80% align=center border=1>
    <tr>
	<th>Name</th>
	<th>Skill</th>
	<th>Department</th>
	<th>About</th>
	<th width=20%>Controls</th>
    </tr>
<%
    String[][] proffs = (String[][])session.getAttribute("proffs");
    if (proffs != null)

    for (int i = 0 ; i < proffs.length ; i++)
    {
%>
    <tr>
        <td align=center><%= proffs[i][0] %></td>
        <td><%= proffs[i][1] %></td>
        <td><%= proffs[i][2] %></td>
        <td><%= proffs[i][3] %></td>
	<td>
	    <form method=POST action=/del_proff>
			<input type=hidden name='name' value = '<%=proffs[i][0] %>' >
			<input type=hidden name=skill value = '<%=proffs[i][1] %>' >
			<input type=hidden name=department value = '<%=proffs[i][2] %>' >
			<input type=hidden name=about value = '<%=proffs[i][3] %>' >
			<input type=submit value=Delete>
	    </form>
	    <form method=POST action=/pre_upd_proff>
			<input type=hidden name='name' value = '<%=proffs[i][0] %>' >
			<input type=hidden name=skill value = '<%=proffs[i][1] %>' >
			<input type=hidden name=department value = '<%=proffs[i][2] %>' >
			<input type=hidden name=about value = '<%=proffs[i][3] %>' >
			<input type=submit value=Edit>
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
<a href=index.html>Main menu</a> | <a href=proservlet>Refresh</a> | <a href=new_proff.html>Add proff</a>