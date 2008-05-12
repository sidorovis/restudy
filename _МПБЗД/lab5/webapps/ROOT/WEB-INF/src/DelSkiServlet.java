
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

public class DelSkiServlet extends HttpServlet {
    
	private String endpoint = "http://localhost:8080/axis/ski.jws";
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
		doPost(request, response);
	}

        public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException 
	{
		PrintWriter out = response.getWriter();

		try 
		{
			Call call = makeCall();
			HttpSession session = request.getSession(false);
			String ski_title = request.getParameter("title");
			String ski_subjects = request.getParameter("subjects");
			String ski_about = request.getParameter("about");
			Object[] params = new Object[3];
			params[0] = (Object)ski_title;
			params[1] = (Object)ski_subjects;
			params[2] = (Object)ski_about;
			int result = ((Integer)call.invoke("del_ski",params)).intValue();
			if (result == -1)
    			    response.sendRedirect("/new_skill.html");
			else
			    response.sendRedirect("/skiservlet");
		}
		catch(ServiceException e) 
		{
			e.printStackTrace(out);
		}
    }
}
