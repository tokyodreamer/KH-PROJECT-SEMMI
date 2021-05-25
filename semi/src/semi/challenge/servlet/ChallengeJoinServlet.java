package semi.challenge.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;
import semi.challenge.beans.ChallengeDto;

@WebServlet(urlPatterns = "/challenge/challengeJoin.kh")
public class ChallengeJoinServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int challengeNo = 0;
			
			ChallengeDto challengeDto = new ChallengeDto();
			// challengeDto.setChallengeWriter((int)req.getSession().getAttribute("memberNo")); -- 회원 기능 구현되면 로그인 페이지에서 세션값 받아올 예정!
			challengeDto.setChallengeWriter(1); // 테스트 값
			// challengeDto.setCategoryNo(Integer.parseInt(req.getParameter("categoryNo"))); -- 카테고리 테이블에서 가져올 예정!
			challengeDto.setCategoryNo(1); // 테스트 값
			challengeDto.setChallengeTitle(req.getParameter("challengeTitle")); // 제목
			challengeDto.setChallengePushPoint(Integer.parseInt(req.getParameter("challengePushPoint"))); // 참가비
			challengeDto.setChallengeStartDate(req.getParameter("challengeStartDate")); // 시작일
			challengeDto.setChallengeEndDate(req.getParameter("challengeEndDate")); // 종료일
			challengeDto.setChallengeContent(req.getParameter("challengeContent")); // 도전글 내용
			
			
			ChallengeDao challengeDao = new ChallengeDao();
			challengeDao.challengeJoin(challengeDto);
			
			resp.sendRedirect("challengeDetail.jsp?challengeNo="+challengeNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}