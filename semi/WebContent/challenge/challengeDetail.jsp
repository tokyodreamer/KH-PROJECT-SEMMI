<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));

	ChallengeDao challengeDao = new ChallengeDao();
	ChallengeDto challengeDto = challengeDao.getChallenge(challengeNo);
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-900">
	<div class="row">
		<h2>도전글 상세보기</h2>
	</div>
	<div class="row">
		<h2><%=challengeDto.getChallengeNo() %></h2>
	</div>
	<div class="row text-left">
		<label>도전글 제목</label>
		<h2><%=challengeDto.getChallengeTitle() %></h2>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>