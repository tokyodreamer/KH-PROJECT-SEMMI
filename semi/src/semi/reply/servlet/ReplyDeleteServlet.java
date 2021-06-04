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

@WebServlet(urlPatterns = "/reply/replyDelete.kh")
public class ReplyDeleteServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 파라미터(댓글번호, 원본글번호), 새션(회원번호)
			req.setCharacterEncoding("UTF-8");
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReplyNo(Integer.parseInt(req.getParameter("replyNo")));
			replyDto.setReplyOrigin(Integer.parseInt(req.getParameter("replyOrigin")));
			
			int memberNo = (int)req.getSession().getAttribute("memberNo");
			replyDto.setReplyWriter(memberNo);
			
			//댓글 삭제
			ReplyDao replyDao = new ReplyDao();
			replyDao.delete(replyDto);
			
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
