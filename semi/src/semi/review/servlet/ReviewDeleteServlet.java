package semi.review.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.review.beans.ReviewDao;

@WebServlet(urlPatterns="/review/reviewDelete.kh")
public class ReviewDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	 //##Delete는 a 태그로 넘어오기때문에 post 보단 doget 방식을 주로 사용한다.
		try {
			//준비:게시글번호를 통해 삭제가 이루어진다.
			int reviewNo = Integer.parseInt(req.getParameter("reviewNo"));
			
			
			//처리
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.delete(reviewNo);
			//=리뷰no값이 정말 지워졌는지 확인하고 싶으면 boolean을 쓰자
			//boolean result = reviewDao.delete(reviewNo)
			
			//출력: 삭제가 완료되면 리뷰게시판목록으로 리다이렉트
			resp.sendRedirect("reviewList.jsp");
			
			
			
		}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}

}
