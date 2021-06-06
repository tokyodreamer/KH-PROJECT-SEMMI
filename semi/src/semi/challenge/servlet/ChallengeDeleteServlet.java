package semi.challenge.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;

@WebServlet(urlPatterns = "/challenge/challengeDelete.kh")
public class ChallengeDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 인증글 번호
			int challengeNo = Integer.parseInt(req.getParameter("challengeNo"));
			
			//처리
			ChallengeDao challengeDao = new ChallengeDao();
			challengeDao.delete(challengeNo);
			
			//출력 : 목록으로 리다이렉트
			resp.sendRedirect("challengeList.jsp");
	
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		
		}
	}
	
	
}
