package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;
import semi.member.beans.MemberDto;

@WebServlet(urlPatterns = "/member/editMember.kh")
public class MemberChangeServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 세션(회원번호) , 파라미터(나머지5개 정보) --> 회원정보(DTO)
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberNo((int)req.getSession().getAttribute("memberNo"));
			memberDto.setMemberNick(req.getParameter("memberNick"));
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			
			//처리
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.changeInformation(memberDto);
			
			//출력
			if(result) {
				resp.sendRedirect("");
			}
			else {
				resp.sendRedirect("");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
