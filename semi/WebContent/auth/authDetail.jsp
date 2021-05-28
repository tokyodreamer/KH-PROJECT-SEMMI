<%@page import="semi.auth.beans.AuthListDto"%>
<%@page import="semi.auth.beans.AuthListDao"%>
<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.auth.beans.AuthDto"%>
<%@page import="semi.auth.beans.AuthDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
int authNo = Integer.parseInt(request.getParameter("authNo"));
//AuthDao authDao = new AuthDao();
//AuthDto authDto = authDao.get(authNo);

//수정 member_nick까지 입력을 위해
AuthListDao authListDao = new AuthListDao();
AuthListDto authListDto = authListDao.get(authNo);

ChallengeDao challengeDao = new ChallengeDao();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">
	
	<div class="link-btn"> <a href="authList.jsp"> 인증 리스트로 돌아가기</a> </div>
	<div class="row">
		<img src="authDetail.kh?authNo=<%=authNo%>" width="100%" height="400">
	</div>
	<div class="row" > 인증 번호: <%=authListDto.getAuthNo()%> </div>
	<div class="row" > 인증 제목: <%=authListDto.getAuthTitle()%> </div>
	 
	 
	<div class="row"> 작성자: <%=authListDto.getMemberNick()%> </div>
<%-- 	<div class="row"> 작성자 아이디: <%=memberDto.getMemberId() %></div> --%>
	
	
	<div class="row"> 인증 내용:  <%=authListDto.getAuthContent()%></div>
	<div class="row">  인증 날짜: <%=authListDto.getAuthTimeLine()%></div>
	<form action="resultChange.kh" method="post">
	<div class="row"> 인증 처리 여부:  <%=authListDto.getAuthResult()%>
		<input type="hidden" value=<%=authNo %> name=authNo>
		<label style="color:blue"> <input value="S" type="radio" name="authResult" required>인증 인정O: </label>
		<label style="color:red"> <input value="D" type="radio" name="authResult" required> 인증 불인정X: </label> <br>
	</div>
	<div class="row">
	인증 처리 사유: 
	<input type="text" name="authReason" value="<%=authListDto.getAuthReason()%>" style="width:100%;" class="form-input" required >
	<input type="submit" value="인증 처리 여뷰 + 이유 저장" class="form-btn ">
	</div>
	</form>

</div>
<jsp:include page="/template/footer.jsp"></jsp:include>