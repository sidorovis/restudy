<%
    String name = (String)session.getAttribute("name");
    String department = (String)session.getAttribute("department");
    String skill = (String)session.getAttribute("skill");
    String about = (String)session.getAttribute("about");
%>

<form method=POST action=/upd_proff>
	<input type=hidden name=old_name value='<%=name%>'><br>
    Proff Name: <input type=text name=name value='<%=name%>'><br>
    Proff Skill: <input type=text name=skill value='<%=skill%>'><br>
    Proff Department: <input type=text name=department value='<%=department%>'><br>
    Proff About: <input type=text name=about value='<%=about%>'><br>
    <input type=submit value=Edit>
</form>