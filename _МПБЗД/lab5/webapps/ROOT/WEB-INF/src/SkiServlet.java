
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

public class SkiServlet extends HttpServlet {
    
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
		try{
			Call call = makeCall();
	
			HttpSession session = request.getSession(true);

			String[][] skills = ((String[][])call.invoke("get_datas", new Object[] {}));
			session.setAttribute("skills", skills);
			response.sendRedirect("/skills.jsp");

		} catch(ServiceException e) 
		{
			e.printStackTrace(out);
		}
 
//		doPost(request, response);
	}

        public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException 
	{
		PrintWriter out = response.getWriter();

		try 
		{
			Call call = makeCall();
			HttpSession session = request.getSession(false);

/*			if(request.getParameter("action") != null && !request.getParameter("action").equals("addFunction"))
			{
//				if (request.getParameter("action").equals("showFunc"))
//				{
					int rowCount = ((Integer)call.invoke("getRowCount", new Object[] {})).intValue();
					String[][] functions = new String[rowCount][3];
					Object[] funcNumber = new Object[1];
					for(int i = 0; i < rowCount; i++ ) 
					{
						funcNumber[0] = ((Object)new Integer(i));
						String[] function = (String[])call.invoke("getRow", funcNumber);
						if (function != null)
						{
							functions[i][0] = function[0];
							functions[i][1] = function[1];
							functions[i][2] = function[2];
						}
					}
					session.setAttribute("functions", functions);
//				}
	        		if(request.getParameter("action").equals("sortFunctions"))
				{
					functions = (String[][])session.getAttribute("functions");
					for(int i = 0; i < functions.length; ++i)
						for(int j = i+1; j < functions.length; ++j)
							if(functions[i][0].compareTo(functions[j][0]) < 0) 
							{
								String[] temp = functions[j];
								functions[j] = functions[i];
								functions[i] = temp;
							}	
					session.setAttribute("functions", functions);
				}

				if(request.getParameter("action").equals("findFunction")) 
				{
					ArrayList<String[]> ffunctions = new ArrayList<String[]>();
					rowCount = (Integer)call.invoke("getRowCount", new Object[] {});
					funcNumber = new Object[1];
					for(int i = 0; i < rowCount; ++i) 
					{
						funcNumber[0] = (Object)new Integer(i);
						String[] function = (String[])call.invoke("getRow", funcNumber);

						if(	function[0].indexOf(request.getParameter("funcForFind")) > -1 || 
							function[1].indexOf(request.getParameter("funcForFind")) > -1 || 
							function[2].indexOf(request.getParameter("funcForFind")) > -1) 
						{
							ffunctions.add(function);
						}
					}
					session.setAttribute("ffunctions", ffunctions);
				}
				response.sendRedirect("/functions.jsp");
			}
*/			
		} catch(ServiceException e) {
			e.printStackTrace(out);
		}
    }

}

