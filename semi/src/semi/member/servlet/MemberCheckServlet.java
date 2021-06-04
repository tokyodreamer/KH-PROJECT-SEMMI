package semi.member.servlet;

import java.io.IOException;
import java.util.Properties;


import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet(urlPatterns="/member/emailCheck.kh")
public class MemberCheckServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String host = "smtp.gmail.com";
		String subject = "Challengers 이메일 인증";
		String user ="semi210604@gmail.com";
		String password="!semi040621";
		String to_email=req.getParameter("memberEmail");
	
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.debug", "true");
		
		String temp = "http://localhost:8080/semi/member/memberJoin.jsp?member_email="+to_email;
       
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user,password);
			}
		});
		try {
			
			MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(user,"Challengers"));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
            
            //메일 제목
            msg.setSubject(subject);
            //메일 내용
            msg.setText("인증되었습니다 회원가입은 링크를 눌러주세요 :"+temp);
            
            Transport.send(msg);
            System.out.println("이메일 전송");
            
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
