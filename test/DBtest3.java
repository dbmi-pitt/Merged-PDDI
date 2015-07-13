import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.ddi.drug_ajax;


//test SearchServlet
public class DBtest3 {
	
	    private drug_ajax servlet;
	    private MockHttpServletRequest request;
	    private MockHttpServletResponse response;

	    @Before
	    public void setUp() {
	        servlet = new drug_ajax();
	        request = new MockHttpServletRequest();
	        response = new MockHttpServletResponse();
	    }

	    @Test
	    public void correctSqlResponseLarge() throws ServletException, IOException {
	        request.addParameter("drug", "simvastatin");

	        servlet.doPost(request, response);
	        String[] test = servlet.testresult.split(",");
	        //assertEquals("text/html", response.getContentType());
	        System.out.println("JUNIT3");
	        System.out.println("_______________________________________");
	        System.out.println("Drug1 : \n simvastatin");
	        System.out.println("Total results : \n" + test.length);
	        System.out.println("_______________________________________");
	        assertTrue(servlet.testresult != null);
	    }
	    
	    
}
