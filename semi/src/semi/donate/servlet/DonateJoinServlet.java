package semi.donate.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;
import semi.donate.beans.DonateDao;
import semi.donate.beans.DonateDto;
import semi.member.beans.MemberDao;

@WebServlet(urlPatterns = "/donate/donateJoin.kh")
public class DonateJoinServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			DonateDao donateDao = new DonateDao();
			
			int donateNo = donateDao.getSequence();
			DonateDto donateDto = new DonateDto();
			
			donateDto.setDonateNo(donateNo);
			donateDto.setDonateChallengeNo(Integer.parseInt(req.getParameter("donateChallengeNo")));
			donateDto.setDonateMemberNo((int) req.getSession().getAttribute("memberNo"));
			donateDto.setDonateCategoryNo(Integer.parseInt(req.getParameter("donateCategoryNo")));
			donateDto.setDonatePushPoint(Integer.parseInt(req.getParameter("donatePushPoint")));
			
			// 후원 전 체크 :
			// 후원하기 전에 회원의 보유 포인트가 후원금보다 적으면 후원하기 페이지로 이동
			MemberDao memberDao = new MemberDao();
			
			if(memberDao.find((int) req.getSession().getAttribute("memberNo")).getMemberPoint() < Integer.parseInt(req.getParameter("donatePushPoint"))) {
				resp.sendRedirect("donateJoin.jsp");
			}
			
			// 1. 후원하는 사람이 후원을 하게 되면
			donateDao.donateJoin(donateDto);
			
			// 2. 회원 DB의 후원금 컬럼에서 후원금을 차감하고 
			memberDao.challengeJoin((int) req.getSession().getAttribute("memberNo"), Integer.parseInt(req.getParameter("donatePushPoint")));
			
			// 3. 도전글 DB의 해당 도전글 후원금 컬럼에 후원금을 더해준다
			ChallengeDao challengeDao = new ChallengeDao();
			challengeDao.donateJoin(Integer.parseInt(req.getParameter("donatePushPoint")), Integer.parseInt(req.getParameter("donateChallengeNo")));
			resp.sendRedirect(req.getContextPath() + "/challenge/challengeDetail.jsp?challengeNo=" + Integer.parseInt(req.getParameter("donateChallengeNo")));
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
