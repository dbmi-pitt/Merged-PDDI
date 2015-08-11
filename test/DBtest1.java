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

import com.ddi.SearchServlet;


//test SearchServlet
public class DBtest1 {
	
	    private SearchServlet servlet;
	    private MockHttpServletRequest request;
	    private MockHttpServletResponse response;

	    @Before
	    public void setUp() {
	        servlet = new SearchServlet();
	        request = new MockHttpServletRequest();
	        response = new MockHttpServletResponse();
	    }

	    @Test
	    public void correctSqlResponseLarge() throws ServletException, IOException {
	        request.addParameter("drug1", "simvastatin");
	        request.addParameter("drug2", "ketoconazole");
	        String[] sourcesList = {"CredibleMeds", "DIKB", "Drugbank", "NDF-RT", "ONC-HighPriority", "ONC-NonInteruptive"};
	        request.addParameter("sourcesList", sourcesList);

	        servlet.doPost(request, response);

	        //assertEquals("text/html", response.getContentType());
	        System.out.println("JUNIT1");
	        System.out.println("_______________________________________");
	        System.out.println("Total results: " + servlet.results.getResults0().size());
	        System.out.println(servlet.results.getResults0().get("simvastatin+ketoconazole+evidenceStatement+DIKB"));
	        System.out.println("_______________________________________");
	        assertTrue(servlet.rs != null);
	    }
	    
	    
	    @Test
	    public void correctSqlResponseNormal() throws ServletException, IOException {
	        request.addParameter("drug1", "TOLBUTAMIDE");
	        request.addParameter("drug2", "FLUVOXAMINE");
	        String[] sourcesList = {"CredibleMeds", "DIKB", "Drugbank"};
	        request.addParameter("sourcesList", sourcesList);

	        servlet.doPost(request, response);

	        //assertEquals("text/html", response.getContentType());
	        System.out.println("JUNIT2");
	        System.out.println("_______________________________________");
	        System.out.println("Total results: " + servlet.results.getResults0().size());
	        System.out.println("_______________________________________");
	        assertTrue(servlet.rs != null);
	    }
	    

	    
	    @Test
	    public void correctSqlResponseNull() throws ServletException, IOException {
	        request.addParameter("drug1", "simvastatin");
	        request.addParameter("drug2", "ket");
	        String[] sourcesList = {"CredibleMeds", "DIKB", "Drugbank"};
	        request.addParameter("sourcesList", sourcesList);

	        servlet.doPost(request, response);

	        //assertEquals("text/html", response.getContentType());
	        System.out.println("JUNIT3");
	        System.out.println("_______________________________________");
	        System.out.println("Total results: " + servlet.results.getResults0().size());
	        System.out.println("_______________________________________");
	        assertEquals(0, servlet.results.getResults0().size());
	    }
	    
}
