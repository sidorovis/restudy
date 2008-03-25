
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.axis.client.Service;
import org.apache.axis.client.Call;
import javax.xml.rpc.ServiceException;
import java.net.URL;
import java.net.MalformedURLException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;

public class LoginServlet extends HttpServlet 
{
	private String endpoint = "http://localhost:8080/axis/aipos4.jws";
	private PrintWriter log = null;
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		try 
		{
			log = new PrintWriter("servlet.log");
		} 
		catch(Exception e) 
		{
		    // Do nothing
		}
	}
 
	private Call makeCall() throws MalformedURLException, ServiceException
	{
	    Service service = new Service();
	    Call call = (Call) service.createCall();
    	    call.setTargetEndpointAddress(new URL(endpoint));
	    return call;
	}
	
	private void redirect(String url,HttpServletRequest request,
                      HttpServletResponse response) throws IOException, ServletException 
	{
		getServletConfig().getServletContext().getRequestDispatcher(url).forward(request, response);
	}
	
        public void doGet(HttpServletRequest request,HttpServletResponse response)
        throws IOException, ServletException 
	{
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(true);
		String adm = (String)session.getAttribute("in_system");
		if (adm == null) 
		{
			redirect("/login.html", request, response);
			return;
		}
		doPost(request, response);
		return;
	}

        public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException 
	{
		PrintWriter out = response.getWriter();
		try 
		{
			Call call = makeCall();
			HttpSession session = request.getSession(false);
			String usr = request.getParameter("login");
			String passw = request.getParameter("passw");
			String adm = (String)session.getAttribute("in_system");
			if(adm == null && usr != null && passw != null) {
				Object[] param = new Object[2];
				param[0] = (Object)usr;
				param[1] = (Object)passw;
				int ret = ((Integer)call.invoke("checkUser", param)).intValue();
				if( ret == -1 )
				{
					redirect("/register.html", request, response);
					return;
				}
				else if(ret == 1)
				{
					redirect("/error_login.jsp", request, response);
					return;
				}
				else if(ret == 2)
				{
					session.setAttribute("in_system", "0");
				        session.setAttribute("FUNC", "a");
				}
				else if(ret == 3)
				{
					session.setAttribute("in_system", "1");
				        session.setAttribute("FUNC", "a");
				}
				redirect("/index.jsp", request, response);
				return;
			}
			else
			    if ( adm != null )
			    {
				redirect("/index.jsp", request, response);
				return;
			    }
			
			String reg_usr = request.getParameter("reg_usr");
			String reg_passw = request.getParameter("reg_passw");
			if(reg_usr != null && reg_passw != null) {
				Object[] param = new Object[2];
				param[0] = (Object)reg_usr;
				param[1] = (Object)reg_passw;
				int ret = ((Integer)call.invoke("addUser", param)).intValue();
				if ( ret == 1 )
					redirect("/login.html", request, response);
				else
					redirect("/error_register.jsp", request, response);
				return;
			}
		}
		 catch(ServiceException e) 
		{
			e.printStackTrace(out);
		}
	}
}
