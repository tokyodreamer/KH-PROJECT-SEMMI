package semi.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/admin/adminLogout.kh")
public class AdminLogoutServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			Integer adminNo = (Integer)req.getSession().getAttribute("adminNo");
			
			if(adminNo != null) {
				req.getSession().removeAttribute("adminNo");
			}
			
			else {
				req.getSession().removeAttribute("adminNo");
			}
			
			resp.sendRedirect(req.getContextPath());
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
