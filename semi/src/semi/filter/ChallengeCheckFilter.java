package semi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;
import semi.challenge.beans.ChallengeDto;
import semi.member.beans.MemberDao;
import semi.member.beans.MemberDto;

@WebFilter(urlPatterns = {
		"/challenge/challengeDelete.kh"
})
public class ChallengeCheckFilter implements Filter {
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		try {
			req.setCharacterEncoding("UTF-8");
			Integer memberNo = (Integer)req.getSession().getAttribute("memberNo");
			Integer adminNo = (Integer)req.getSession().getAttribute("adminNo");
			int challengeNo = Integer.parseInt(req.getParameter("challengeNo"));
			
			
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(memberNo);
			
			ChallengeDao challengeDao = new ChallengeDao();
			ChallengeDto challengeDto = challengeDao.getChallenge(challengeNo);
			
			if(adminNo != null) {//관리자
				chain.doFilter(request, response);
			}
			else if (memberNo == challengeDto.getChallengeWriter()) {//본인이라면
				chain.doFilter(request, response);
			}
			else {//본인 or 관리자 아니라면
				resp.sendError(403);//Forbidden, 권한없음
			}
		
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		
		}
		
	}
}
