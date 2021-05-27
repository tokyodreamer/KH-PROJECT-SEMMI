<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<%
//  		int memberNo = (int)session.getAttribute("memberNo");
		int memberNo = 1; //임시
		MemberDao memberDao = new MemberDao(); 
		MemberDto memberDto = memberDao.find(memberNo);
	%>
	<%
		int memberPoint= memberDto.getMemberPoint();
	
	%>	

	<div align ="center">
	
	
		<div class="sh_group">
					<h2>챌린저스 프로필</h2>
					<%if(memberPoint <=100000) { %>
					<img src="https://via.placeholder.com/50x50.png?text=B">
					<%} else if(memberPoint <=200000) { %>
					<img src="https://via.placeholder.com/50x50.png?text=S">
					<%} else { %>
					프로필
					<%} %>
					<span>  닉네임 <%=memberDto.getMemberNick()%></span>
					
					<hr>
		</div>
		<div class="sh_group">
					<a href="editMember.jsp">회원정보 수정</a><br>
					<a href="editPw.jsp">비밀번호 변경</a><br>
					<a href="#">회원탈퇴</a>
		</div>
	
	</div>
	<div align ="center">
	
		<div class="sh_group">
					현재 진행중 도전 게시글<br>
					<button>도전게시글 상세 보기</button>
		</div>
		<div class="sh_group">
					현재 후원내역 <br>
					<button>후원내역 상세 보기</button>
		</div>
	</div>		

	<jsp:include page="/template/footer.jsp"></jsp:include>