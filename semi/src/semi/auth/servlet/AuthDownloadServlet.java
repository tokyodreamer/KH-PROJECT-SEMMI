package semi.auth.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;

@WebServlet(urlPatterns = "/auth/authDetail.kh")
public class AuthDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			1. 준비물 수신(authNo)
			int authNo = Integer.parseInt(req.getParameter("authNo"));
			
//			2. authNo를 이용하여 인증 파일 관련 정보를 불러온다
			AuthDao authDao = new AuthDao();
			AuthDto authDto = authDao.getByAuthNo(authNo);
			
//			3. authDto의 정보를 토대로 사용자에게 알려줄 내용들을 설정한다(HttpHeader설정)
//			= Content-Type : 사용자에게 보낼 데이터의 형태
//			= Content-Encoding : 사용자에게 보낼 데이터의 인코딩 방식
//			= Content-Length : 사용자에게 보낼 데이터의 크기
//			= Content-Disposition : 사용자에게 보낼 데이터의 이름(attachment가 붙으면 다운로드가 수행)
//			= 파일명에 유니코드나 특수문자가 있는 경우 정상적으로 전송되지 않는다
//			= java.net.URLEncoder라는 클래스의 encode 명령을 사용하여 분해 후 전송
			
			String fileName = URLEncoder.encode(authDto.getAuthUploadName(), "UTF-8");
			resp.setHeader("Content-Type", authDto.getAuthContentType());
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(authDto.getAuthFileSize()));
			resp.setHeader("Content-Disposition", "filename=\""+fileName+"\"");
			
//			4. 파일 정보를 불러와서 사용자에게 전송(File 입력 후 네트워크 출력)
			File dir = new File("C:\\Users\\yongh\\Pictures\\semi");
			File target = new File(dir, authDto.getAuthSaveName());
			
			byte[] buffer = new byte[1024];
			FileInputStream in = new FileInputStream(target);
			
			while(true){
				int size = in.read(buffer);
				if(size == -1) break;
				resp.getOutputStream().write(buffer, 0, size);
			}
			
			in.close();
			
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
	
	}
}
