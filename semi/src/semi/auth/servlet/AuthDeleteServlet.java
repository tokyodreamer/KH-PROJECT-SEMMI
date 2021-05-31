package semi.auth.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.auth.beans.AuthDao;

@WebServlet(urlPatterns = "/auth/authDelete.kh")
public class AuthDeleteServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 인증글 번호
			int authNo = Integer.parseInt(req.getParameter("authNo"));
			
			//처리
			AuthDao authDao = new AuthDao();
			authDao.delete(authNo);
			
			//출력 : 목록으로 리다이렉트
			resp.sendRedirect("authList.jsp");
	
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
}
}
