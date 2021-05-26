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
	<div class="row text-left">
		<label>도전글 작성자</label>
		<h2><%=challengeDto.getChallengeWriter() %></h2>
	</div>
	<div class="row text-left">
		<label>참가비</label>
		<h2><%=challengeDto.getChallengePushPoint() %> 포인트</h2>
	</div>
	<div class="row text-left">
		<label>시작일</label>
		<h2><%=challengeDto.getChallengeStartDate().substring(0,10) %></h2>
	</div>
	<div class="row text-left">
		<label>종료일</label>
		<h2><%=challengeDto.getChallengeEndDate().substring(0,10) %></h2>
	</div>
	<div class="row text-left">
		<label>상금</label>
		<h2><%=challengeDto.getChallengeReward() %> 포인트</h2>
	</div>
	<div class="row text-left">
		<label>도전글 내용</label>
		<h2><%=challengeDto.getChallengeContent() %></h2>
	</div>
	<div class="row text-left">
		<!-- 자바스크립트 추가 예정 : 세션값과 작성자가 일치하지 않으면 후원하기 버튼 출력 -->
		<a href="#" class="link-btn">후원하기</a>
		<!-- 자바스크립트 추가 예정 : 세션값과 작성자가 일치하면 인증하기 버튼 출력 -->
		<a href="#" class="link-btn">인증하기</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>