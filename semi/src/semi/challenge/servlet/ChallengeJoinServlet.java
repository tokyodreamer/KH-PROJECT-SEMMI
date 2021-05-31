package semi.challenge.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;
import semi.challenge.beans.ChallengeDto;
import semi.member.beans.MemberDao;

@WebServlet(urlPatterns = "/challenge/challengeJoin.kh")
public class ChallengeJoinServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ChallengeDao challengeDao = new ChallengeDao();
			
			// 도전글 상세보기 번호 불러오기
			int challengeNo = challengeDao.getSequence();
			
			ChallengeDto challengeDto = new ChallengeDto();
			challengeDto.setChallengeNo(challengeNo); // 시퀀스로 불러온 값 등록
			challengeDto.setChallengeWriter((int)req.getSession().getAttribute("memberNo")); 
			challengeDto.setCategoryNo(Integer.parseInt(req.getParameter("categoryNo"))); 
			challengeDto.setChallengeTitle(req.getParameter("challengeTitle")); // 제목
			challengeDto.setChallengePushPoint(Integer.parseInt(req.getParameter("challengePushPoint"))); // 참가비
			challengeDto.setChallengeStartDate(req.getParameter("challengeStartDate")); // 시작일
			challengeDto.setChallengeEndDate(req.getParameter("challengeEndDate")); // 종료일
			challengeDto.setChallengeContent(req.getParameter("challengeContent")); // 도전글 내용
			
			// 도전글 등록하기 전에 멤버 DB에 포인트가 있는 지 검사
			MemberDao memberDao = new MemberDao();
			memberDao.find((int)req.getSession().getAttribute("memberNo")).getMemberPoint();
			
			// 만일 입력한 참가비가 검사한 체크포인트보다 많으면(참가비가 모자르면..)
			if(memberDao.find((int)req.getSession().getAttribute("memberNo")).getMemberPoint() < Integer.parseInt(req.getParameter("challengePushPoint"))) {
				// 수정 완료 : 도전 목록으로 이동
				resp.sendRedirect(req.getContextPath() + "/challenge/challengeList.jsp");
			} 
			
			// 도전글 등록
			challengeDao.challengeJoin(challengeDto);
			
			// 멤버DB에서 도전글 등록한 해당 회원(=memberNo) 의 포인트 차감(=challengePushPoint)
			memberDao.challengeJoin((int)req.getSession().getAttribute("memberNo"), Integer.parseInt(req.getParameter("challengePushPoint")));
			
			resp.sendRedirect("challengeDetail.jsp?challengeNo="+challengeNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
