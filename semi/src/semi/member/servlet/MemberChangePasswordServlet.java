package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;

@WebServlet(urlPatterns= "/member/editPw.kh")
public class MemberChangePasswordServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int memberNo = (int)req.getSession().getAttribute("memberNo");
			
			
			req.setCharacterEncoding("UTF-8");
			String nowPw = req.getParameter("nowPw");
			String newPw = req.getParameter("newPw");
			

			MemberDao memberDao = new MemberDao();
			
			boolean result = memberDao.changePassword(memberNo, nowPw, newPw);
			
			
			if(result) {
				resp.sendRedirect("editPwSuccess.jsp");
			}
			else {
				resp.sendRedirect("editPw.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
