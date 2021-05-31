<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<%
 		int memberNo = (int)session.getAttribute("memberNo"); 
		MemberDao memberDao = new MemberDao(); 
		MemberDto memberDto = memberDao.find(memberNo);
 	%> 
	
<%--테스트용 	<% --%>
<!-- // 		int memberNo = 1; -->
<!-- // 		MemberDao memberDao = new MemberDao(); -->
<!-- // 		MemberDto memberDto = memberDao.find(memberNo); -->
<%-- 	%> --%>
	
	<div class="container-400">
		<div class="row">
			<h2 align="center">회원 정보 변경</h2>
		</div>
		
		<form action="editMember.kh" method="post">
			<div class="row text-left">
				<label>닉네임</label>
				<input type="text" name="memberNick" required class="form-input form-input-underline"
								value="<%=memberDto.getMemberNick()%>">
			</div>
			
			<div class="row text-left">
				<label>이메일</label>
				<input type="text" name="memberEmail" class="form-input form-input-underline"
								value="<%=memberDto.getMemberEmail()%>">
			</div>
			<div class="row text-left">
				<label>현재 비밀번호</label>
				<input type="password" name="memberPw" required class="form-input form-input-underline">
			</div>
			<!-- 오류인 상황에는 오류 메세지를 추가해준다 -->
			<%if(request.getParameter("error") != null){ %>
			<div class="row">
				<h5 class="error">정보가 일치하지 않습니다</h5>
			</div>
			<%} %>
			<div class="row">
				<input type="submit" value="수정하기" class="form-btn form-btn-negative">
			</div>
		</form>
		
<!-- 		<form action="memberExit.kh" method="post"> -->
<!-- 			<div class="row"> -->
<!-- 				<input type="submit" value="탈퇴하기" class="form-btn form-btn-negative"> -->
<!-- 			</div> -->
		
<!-- 		</form> -->
		
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>