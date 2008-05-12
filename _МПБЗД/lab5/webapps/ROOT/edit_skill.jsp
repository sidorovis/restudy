<%
    String title = (String)session.getAttribute("title");
    String subjects = (String)session.getAttribute("subjects");
    String about = (String)session.getAttribute("about");
%>

<form method=POST action=/upd_skill>
	<input type=hidden name=old_title value='<%=title%>'><br>
    Skill Title: <input type=text name=title value = '<%=title%>'><br>
    Skill Subjects: <input type=text name=subjects value='<%=subjects%>'><br>
    Skill About: <input type=text name=about value='<%=about%>'><br>
    <input type=submit value=Edit>
</form>