import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.ddi.DDIServlet;


//test DDIServlet
public class DBtest2 {
	
	    private DDIServlet servlet;
	    private MockHttpServletRequest request;
	    private MockHttpServletResponse response;

	    @Before
	    public void setUp() {
	        servlet = new DDIServlet();
	        request = new MockHttpServletRequest();
	        response = new MockHttpServletResponse();
	    }

	    @Test
	    public void correctSqlResponseLarge() throws ServletException, IOException {

	        servlet.doPost(request, response);

	        //assertEquals("text/html", response.getContentType());
	        System.out.println("JUNIT2");
	        System.out.println("_______________________________________");
	        System.out.println("Total drugs: " + servlet.drug.getDrugNames().size());
	        System.out.println("Total source categories: " + servlet.drug.getSourceSet().size());
	        System.out.println("_______________________________________");
	        assertTrue(servlet.drug.getDrugNames() != null);
	    }

	    
}
