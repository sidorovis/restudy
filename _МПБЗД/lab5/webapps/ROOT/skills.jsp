<%@ page import="java.util.*" %>
<title>Skills</title>

<table width=100% align=center>
    <tr>
        <td>
            
        </td>
        <td>
<table width=80% align=center border=1>
    <tr>
	<th>Title</th>
	<th>Subjects</th>
	<th>About</th>
	<th width=20%>Controls</th>
    </tr>
<%
    String[][] skills = (String[][])session.getAttribute("skills");
    if (skills != null)

    for (int i = 0 ; i < skills.length ; i++)
    {
%>
    <tr>
        <td align=center><%= skills[i][0] %></td>
        <td><%= skills[i][1] %></td>
        <td><%= skills[i][2] %></td>
	<td>
	    <form method=POST action=/del_skill>
			<input type=hidden name=title value = '<%=skills[i][0] %>' >
			<input type=hidden name=subjects value = '<%=skills[i][1] %>' >
			<input type=hidden name=about value = '<%=skills[i][2] %>' >
			<input type=submit value=Delete>
	    </form>
	    <form method=POST action=/pre_upd_skill>
			<input type=hidden name=title value = '<%=skills[i][0] %>' >
			<input type=hidden name=subjects value = '<%=skills[i][1] %>' >
			<input type=hidden name=about value = '<%=skills[i][2] %>' >
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
<a href=index.html>Main menu</a> | <a href=skiservlet>Refresh</a> | <a href=new_skill.html>Add skill</a>