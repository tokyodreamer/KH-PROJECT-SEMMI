package semi.auth.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;

@WebServlet(urlPatterns= "/auth/resultChange.kh")
public class AuthResultChangeServlet extends HttpServlet{

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			AuthDao authDao = new AuthDao();
			AuthDto authDto = new AuthDto();
			
			authDto.setAuthNo(Integer.parseInt(req.getParameter("authNo")));
			authDto.setAuthResult(req.getParameter("authResult"));
			authDto.setAuthReason(req.getParameter("authReason"));
			
			Boolean result = authDao.changeResult(authDto);
			if(result) {
				resp.sendRedirect("authList.jsp");
			}
			else {
				resp.sendRedirect("authDetail.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
	
	}
