package semi.review.servlet;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.review.beans.ReviewDao;
import semi.review.beans.ReviewDto;
@WebServlet(urlPatterns="/review/reviewWrite.kh")
public class ReveiwInsertServlet extends HttpServlet{
	@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	try {
		//준비(reviewDto>아이디 or 닉네임, 내용, 평점)
		req.setCharacterEncoding("UTF-8");
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setReviewStar(req.getParameter("reviewStar"));
		reviewDto.setReviewContent(req.getParameter("reviewContent"));
		
		int memberNo=(int)req.getSession().getAttribute("memberNo");//회원번호 가져오기
		reviewDto.setReviewNick(memberNo);

	
		
		
		
		
		//계산
		ReviewDao reviewDao = new ReviewDao();
//		int reviewNo = reviewDao.getSequence(); 	//게시글 번호  (시퀀스조회)
//		reviewDto.setReviewNo(reviewNo); //추가
		
		
		reviewDao.write(reviewDto);
		
		
		
		//출력(성공하면 목록 화면으로)
		resp.getWriter().println("ok");
//		resp.sendRedirect("reviewDetail.jsp?reviewNo=" +reviewNo);
		
	}

	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
