package semi.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.admin.beans.AdminDao;
import semi.admin.beans.AdminDto;

@WebServlet(urlPatterns = "/admin/adminLogin.kh")
public class AdminLoginServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			AdminDto adminDto = new AdminDto();
			adminDto.setAdminId(req.getParameter("adminId"));
			adminDto.setAdminPw(req.getParameter("adminPw"));
			
			
			AdminDao adminDao = new AdminDao();
			AdminDto find = adminDao.login(adminDto);
			
			if(find!=null) {
				req.getSession().setAttribute("adminNo", find.getAdminNo());
				resp.sendRedirect(req.getContextPath()+"/auth/authList.jsp");
			}
			else {
				resp.sendRedirect("adminLogin.jsp?error");
			}
		} 
		
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
