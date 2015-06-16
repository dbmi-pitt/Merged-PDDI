import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import com.ddi.SearchServlet;

public class testsql {
	
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
	    public void correctSqlResponseNormal() throws ServletException, IOException {
	        request.addParameter("drug1", "simvastatin");
	        request.addParameter("drug2", "ketoconazole");
	        String[] sourcesList = {"CredibleMeds", "DIKB", "Drugbank"};
	        request.addParameter("sourcesList", sourcesList);

	        servlet.doPost(request, response);

	        //assertEquals("text/html", response.getContentType());

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

	        assertEquals(0, servlet.results.getResults().size());
	    }
	
}
