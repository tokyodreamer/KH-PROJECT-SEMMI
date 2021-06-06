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

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;
import semi.member.beans.MemberDao;
import semi.member.beans.MemberDto;

@WebFilter(urlPatterns = {
		"/auth/authDelete.kh"	
})
public class AuthCheckFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {
			req.setCharacterEncoding("UTF-8");
			Integer memberNo = (Integer)req.getSession().getAttribute("memberNo");
			Integer adminNo = (Integer)req.getSession().getAttribute("adminNo");
			int authNo = Integer.parseInt(req.getParameter("authNo"));
			
			AuthDao authDao = new AuthDao();
			AuthDto authDto = authDao.get(authNo);
			
			if(adminNo != null) {//관리자
				chain.doFilter(request, response);
			}
			else if (memberNo == authDto.getAuthWriter()) {//본인이라면
				chain.doFilter(request, response);
			}
			else {//둘다 아니라면
				resp.sendError(403);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	}
}
