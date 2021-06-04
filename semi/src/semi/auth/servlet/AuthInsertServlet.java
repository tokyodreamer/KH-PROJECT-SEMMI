package semi.auth.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import semi.auth.beans.AuthDao;
import semi.auth.beans.AuthDto;

@WebServlet(urlPatterns = "/auth/authInsert.kh")
public class AuthInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			1. 라이브러리를 이용해서 multipart/form-data 방식의 요청을 해석
//			= 파일 저장할 위치 및 기본설정을 정한다.
			String path = "D:\\auth";//해당 위치에 폴더 생성!!
			int maximumSize = 10 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
//			= 위의 설정값들을 이용해서 해석기를 생성하면 "파일 저장"까지 자동으로 수행해준다
			MultipartRequest mRequest = new MultipartRequest(req, path, maximumSize, encoding, policy);
		
//			해야할 일 : 사용자가 보낸 정보(authTitle,authContent)와 업로드된 파일의 정보를 추출하여 DB에 저장
//			= 기존 파라미터는 동일한 명령으로 수신 가능
//			= 파일 정보는 수신 명령이 다름
			
//			인증 정보 등록
			AuthDto authDto = new AuthDto();
			authDto.setAuthChallengeNo(Integer.parseInt(mRequest.getParameter("authChallengeNo")));
			authDto.setAuthCategoryType(Integer.parseInt(mRequest.getParameter("authCategoryType")));
			authDto.setAuthTitle(mRequest.getParameter("authTitle"));
			authDto.setAuthContent(mRequest.getParameter("authContent"));
			
			AuthDao authDao = new AuthDao();
			int authNo = authDao.getSequence();
			authDto.setAuthNo(authNo);
			
			int memberNo = (int)req.getSession().getAttribute("memberNo");
			authDto.setAuthWriter(memberNo);
			
//			인증글 파일 정보
			File file = mRequest.getFile("authFile");
			authDto.setAuthUploadName(mRequest.getOriginalFileName("authFile"));
			authDto.setAuthSaveName(mRequest.getFilesystemName("authFile"));
			authDto.setAuthContentType(mRequest.getContentType("authFile"));
			authDto.setAuthFileSize(file.length());
			
			authDao.insert(authDto);
			
			//출력
			resp.sendRedirect("authDetail.jsp?authNo="+authNo);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
