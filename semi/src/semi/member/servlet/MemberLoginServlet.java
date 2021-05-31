package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;
import semi.member.beans.MemberDto;

@WebServlet(urlPatterns = "/member/memberLogin.kh")
public class MemberLoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(req.getParameter("memberId"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			
			MemberDao memberDao = new MemberDao();
			MemberDto sth = memberDao.login(memberDto);
			
			if(sth !=null){
				req.getSession().setAttribute("memberNo", sth.getMemberNo());
				resp.sendRedirect("/semi/index.jsp");
			}
			else {
				resp.sendRedirect("memberLogin.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
