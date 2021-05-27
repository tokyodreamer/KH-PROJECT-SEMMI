package semi.auth.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;

@WebServlet(urlPatterns="/auth/authDetail.kh")
public class AuthDetailServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int authNo = Integer.parseInt(req.getParameter("audhNo"));
			
			AuthDao authDao = new AuthDao();
			AuthDto authDto = authDao.get(authNo);
			
			
		}
		catch(Exception e) {
			
			
		}
	}
}
