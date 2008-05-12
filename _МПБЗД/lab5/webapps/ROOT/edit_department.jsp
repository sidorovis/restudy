<%
    String old_title = (String)session.getAttribute("old_title");
    String title = (String)session.getAttribute("title");
    String about = (String)session.getAttribute("about");
%>

<form method=POST action=/upd_department>
	<input type=hidden name=old_title value='<%=title%>'><br>
    Department Title: <input type=text name=title value='<%=title%>'><br>
    Department About: <input type=text name=about value='<%=about%>'><br>
    <input type=submit value=Edit>
</form>