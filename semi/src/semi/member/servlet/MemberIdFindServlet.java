package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;

@WebServlet(urlPatterns ="/member/findId.kh")
public class MemberIdFindServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			String memberEmail = req.getParameter("memberEmail");
			String memberNick = req.getParameter("memberNick");
			MemberDao memberDao = new MemberDao();
			String id = memberDao.searchId(memberEmail,memberNick);
			if(id !=null) {
				req.getSession().setAttribute("id", id);
				resp.sendRedirect("idSuccess.jsp");
			}
			else {
				resp.sendRedirect("idSearch.jsp?error");
			}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}

