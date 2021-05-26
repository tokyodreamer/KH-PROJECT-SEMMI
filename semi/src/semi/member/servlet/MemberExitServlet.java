package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.member.beans.MemberDao;

@WebServlet(urlPatterns="/member/memberExit.kh")
public class MemberExitServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			//준비(회원번호 자신 )파라미터가 아닌 회원 자신의 번호==세션을 조회??
			
			int memberNo=(int)req.getSession().getAttribute("memberNo"); //세션 적용 코드
//			int memberNo=Integer.parseInt(req.getParameter("memberNo")); //세션 없는 코드
			
			//처리: 탈퇴 + 로그아웃(Primary Key 로 삭제(?))
			MemberDao memberDao = new MemberDao();
			memberDao.exit(memberNo);
			
			req.getSession().removeAttribute("memberNo"); //로그아웃 처리(세션)
			
			//출력: 탈퇴 완료 후 메시지로 리다이렉트
			resp.sendRedirect("memberExitSuccess.jsp");
			
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	
	}

}
