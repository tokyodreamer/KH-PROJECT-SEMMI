package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;
import semi.member.beans.MemberDto;

@WebServlet(urlPatterns="/member/memberJoin.kh")
public class MemberJoinServlet extends HttpServlet{
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 
		try {
			//준비(회원정보)
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(req.getParameter("memberId"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			memberDto.setMemberNick(req.getParameter("memberNick"));
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
		
			
			//계산
			MemberDao memberDao = new MemberDao();
			memberDao.regist(memberDto);
			
			
			//출력(리다이렉트)
			resp.sendRedirect("memberJoinSuccess.jsp");
		}

		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}



}
	
}
