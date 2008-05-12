
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

public class UpdProServlet extends HttpServlet {
    
	private String endpoint = "http://localhost:8080/axis/pro.jws";
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
			String old_name = request.getParameter("old_name");
			String name = request.getParameter("name");
			String skill = request.getParameter("skill");
			String department = request.getParameter("department");
			String about = request.getParameter("about");

			Object[] params = new Object[5];
			params[0] = (Object)old_name;
			params[1] = (Object)name;
			params[2] = (Object)department;
			params[3] = (Object)skill;
			params[4] = (Object)about;

			int result = ((Integer)call.invoke("upd_pro",params)).intValue();
			if (result == -1)
    			    response.sendRedirect("/proservlet");
			else
			    response.sendRedirect("/proservlet");
		}
		catch(ServiceException e) 
		{
			e.printStackTrace(out);
		}
    }
}
