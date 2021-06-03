package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;

@WebServlet(urlPatterns ="/member/findPw.kh")
public class MemberPwFindServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String id = req.getParameter("id");
			String nick = req.getParameter("nick");
			MemberDao memberDao = new MemberDao();
			String pw = memberDao.searchPw(id,nick);
			
			if(pw !=null) {
				req.getSession().setAttribute("pw", pw);
				resp.sendRedirect("pwSuccess.jsp");
			}
			else {
				resp.sendRedirect("pwSearch.jsp?error");
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}

}
