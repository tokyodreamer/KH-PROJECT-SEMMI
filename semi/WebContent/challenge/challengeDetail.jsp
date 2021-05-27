<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="semi.challenge.beans.ChallengeListDto"%>
<%@page import="semi.challenge.beans.ChallengeListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));

	ChallengeListDao challengeListDao = new ChallengeListDao();
	
	ChallengeListDto challengeListDto = challengeListDao.getChallenge(challengeNo);
	
	// 목표 : DB에서 가져온 시작일 과 종료일을 확인하여 남은 기간을 실시간으로 계산하고 싶다!
	// 준비 : JDBC 에서 불러온 시작 날짜 값 (문자열)
	String startDate = challengeListDto.getChallengeStartDate(); 
	String endDate = challengeListDto.getChallengeEndDate();
	
	// 1. 문자열 -> 타임 패키지의 인스턴스로 형변환
	SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-900">
	<div class="row">
		<h2>도전글 상세보기</h2>
	</div>
	<div class="row">
		<h4>시작날짜 확인 : <%=startDate %></h4>
	</div>
	<div class="row">
		<label>도전글 번호</label>
		<h2><%=challengeListDto.getChallengeNo() %></h2>
	</div>
	<div class="row text-left">
		<label>도전글 제목</label>
		<h2><%=challengeListDto.getChallengeTitle() %></h2>
	</div>
	<div class="row text-left">
		<!-- 변경 예정 -->
		<label>도전글 작성자</label>
		<h2><%=challengeListDto.getMemberNick()%></h2>
	</div>
	<div class="row text-left">
		<label>참가비</label>
		<h2><%=challengeListDto.getChallengePushPoint() %> 포인트</h2>
	</div>
	<div class="row text-left">
		<label>시작일</label>
		<h2><%=challengeListDto.getChallengeStartDate().substring(0,10) %></h2>
	</div>
	<div class="row text-left">
		<label>종료일</label>
		<h2><%=challengeListDto.getChallengeEndDate().substring(0,10) %></h2>
	</div>
	<!-- 타임 리미트 : 로직 구현 예정 -->
	<!-- 실시간 계산 예정 :  -->
	<div class="row text-left">
		<h2>종료까지 # 일</h2>
	</div>
	<div class="row text-left">
		<label>상금</label>
		<h2><%=challengeListDto.getChallengeReward() %> 포인트</h2>
	</div>
	<div class="row tex-left">
		<label>누적 후원금</label>
		<h2><%=challengeListDto.getChallengeDonate() %> 포인트</h2>
	</div>
	<div class="row text-left">
		<label>도전글 내용</label>
		<h2><%=challengeListDto.getChallengeContent() %></h2>
	</div>
	<div class="row text-left">
		<!-- 자바스크립트 추가 예정 : 세션값과 작성자가 일치하지 않으면 후원하기 버튼 출력 -->
		<a href="<%=request.getContextPath() %>/donate/donateJoin.jsp?challengeNo=<%=challengeNo%>" class="link-btn">후원하기</a>
		<!-- 자바스크립트 추가 예정 : 세션값과 작성자가 일치하면 인증하기 버튼 출력 -->
		<a href="<%=request.getContextPath() %>/auth/authInsert.jsp" class="link-btn">인증하기</a>
		<a href="challengeList.jsp" class="link-btn">목록</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>