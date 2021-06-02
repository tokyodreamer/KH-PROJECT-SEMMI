package semi.review.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.review.beans.ReviewDao;
import semi.review.beans.ReviewDto;

@WebServlet(urlPatterns = "/review/reviewUpdate.kh")
public class ReviewUpdateServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			// 준비
			// 1.UTF-8 인코딩, 파라미터(번호, 평점,내용) + 세션(회원번호, 본인글)//reviewDto
			req.setCharacterEncoding("UTF-8");
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(Integer.parseInt(req.getParameter("reviewNo")));
			reviewDto.setReviewStar(Integer.parseInt(req.getParameter("reviewStar")));
			reviewDto.setReviewContent(req.getParameter("reviewContent"));
			reviewDto.setReviewNick((int) req.getSession().getAttribute("memberNo")); // 세션번호


			// 처리
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.edit(reviewDto);

			// 출력(리뷰넘버 자리에는 dto.get~을 넣으면 원래 번호로 돌아간다)
			resp.sendRedirect("reviewList.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}