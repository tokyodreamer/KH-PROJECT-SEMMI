package semi.reply.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.reply.beans.ReplyDao;
import semi.reply.beans.ReplyDto;

@WebServlet(urlPatterns = "/reply/replyEdit.kh")
public class ReplyEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//준비 : 파라미터(게시글번호, 댓글내용, 댓글번호) + 세션(회원번호)
			req.setCharacterEncoding("UTF-8");
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReplyNo(Integer.parseInt(req.getParameter("replyNo")));
			replyDto.setReplyOrigin(Integer.parseInt(req.getParameter("replyOrigin")));
			replyDto.setReplyContent(req.getParameter("replyContent"));
			
			int memberNo = (int)req.getSession().getAttribute("memberNo");
			replyDto.setReplyWriter(memberNo);
			
			//처리
			ReplyDao replyDao = new ReplyDao();
			replyDao.edit(replyDto);
			
			//출력 : 상세페이지로 복귀
			resp.sendRedirect(req.getContextPath()+"/challenge/challengeDetail.jsp?challengeNo="+replyDto.getReplyOrigin());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
