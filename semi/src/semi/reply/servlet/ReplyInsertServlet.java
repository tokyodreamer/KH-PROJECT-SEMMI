package semi.reply.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.challenge.beans.ChallengeDao;
import semi.reply.beans.ReplyDao;
import semi.reply.beans.ReplyDto;

@WebServlet(urlPatterns = "/reply/replyInsert.kh")
public class ReplyInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//준비 : 파라미터(댓글내용, 원본글번호) , 세션(회원번호)
			req.setCharacterEncoding("UTF-8");
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReplyContent(req.getParameter("replyContent"));
			replyDto.setReplyOrigin(Integer.parseInt(req.getParameter("replyOrigin")));
			
			int memberNo = (int)req.getSession().getAttribute("memberNo");
			replyDto.setReplyWriter(memberNo);
			
			//댓글 등록
			ReplyDao replyDao = new ReplyDao();
			replyDao.insert(replyDto);
			//댓글 개수 갱신
			ChallengeDao challengeDao = new ChallengeDao();
			challengeDao.refreshChallengeReply(replyDto.getReplyOrigin());
			
			//출력 : 상세페이지로 복귀
			resp.sendRedirect(req.getContextPath()+"/challenge/challengeDetail.jsp?challengeNo="+replyDto.getReplyOrigin());
			
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		
		}
	
	
	}
	
	
	
}
