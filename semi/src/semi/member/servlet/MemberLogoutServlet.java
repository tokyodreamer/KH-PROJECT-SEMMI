package semi.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

@WebServlet(urlPatterns = "/member/memberLogout.kh")
public class MemberLogoutServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.getSession().removeAttribute("memberNo");
		resp.sendRedirect(req.getContextPath());
		
	} catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
