package semi.auth.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;
import semi.challenge.beans.ChallengeDao;

@WebServlet(urlPatterns= "/auth/resultChange.kh")
public class AuthResultChangeServlet extends HttpServlet{

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			AuthDao authDao = new AuthDao();
			AuthDto authDto = new AuthDto();
			
			authDto.setAuthNo(Integer.parseInt(req.getParameter("authNo")));
			authDto.setAuthResult(req.getParameter("authResult"));
			authDto.setAuthReason(req.getParameter("authReason"));
			
			// 결과 처리 여부 (= 성공 여부)
			Boolean result = authDao.changeResult(authDto);
			
			// 도전글의 달성율 변동 메소드
			
			// 필요 준비물 : 도전글 시작일, 도전글 종료일, 도전글 번호 
			
			// 준비물 가져오는 메소드
			int challengeNo = authDao.get(Integer.parseInt(req.getParameter("authNo"))).getAuthChallengeNo();
			
			if(result) {
				resp.sendRedirect("authList.jsp");
			}
			else {
				resp.sendRedirect("authDetail.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
	
	}
