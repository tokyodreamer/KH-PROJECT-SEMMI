<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
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
	
	// 1. 문자열 -> 타임 패키지의 인스턴스로 형변환 (일단 밀리세컨으로 변환)
	SimpleDateFormat  format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	format.setTimeZone(TimeZone.getTimeZone("UTC"));
	Date startDateParsed = format.parse(startDate);
	Date endDateParsed = format.parse(endDate);
	
	// * : 현재 날짜, 종료일 밀리 세컨 뽑아오기 (조건문 활용 예정 : 도전 기한 만료 체크용도)
	long currentTimeSec = System.currentTimeMillis()/1000;
	long endTimeSec = endDateParsed.getTime()/1000;
	
	// 2. 타임리미트 : 현재시간 - 종료일
	long timeLimitMills = endDateParsed.getTime() -  System.currentTimeMillis();
	long timeLimitDay = timeLimitMills/1000/60/60/24;
	long timeLimitHour = timeLimitMills/1000/60/60%24;
	long timeLimitMin = timeLimitMills/1000/60%60;
	long timeLimitSec = timeLimitMills/1000%60;
	
	// 3. 구현
	// - 타임 리미트 실시간 체크 : 종료일이 현재시간보다 크다면 (도전글 기한이 유효하다는 의미!)
	// - 남은 기간이 실시간으로 초단위로 업데이트 되게끔(? 시간이 줄어들게..)
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		<%-- var dd = <%=timeLimitDay%>;
		var hh = <%=timeLimitHour%>;
		var mm = <%=timeLimitMin%>;
		var ss = <%=timeLimitSec%>; --%>
		
		var timeLimitMills = <%=timeLimitMills%>;
		
		setInterval(PrintTime, 1000);
		
		function PrintTime(){
			var dd = parseInt(timeLimitMills/1000/60/60/24);
			var hh = parseInt(timeLimitMills/1000/60/60%24);
			var mm = parseInt(timeLimitMills/1000/60%60);
			var ss = parseInt(timeLimitMills/1000%60);
			
			document.getElementById("timeLimit").innerHTML = "종료까지" + dd + "일" + hh + "시간" + mm + "분" + ss + "초 남았습니다";
			ss--;
		};
		
		
	});
</script>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container-900">
	<div class="row">
		<h2>도전글 상세보기</h2>
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
		<label>도전글 기한</label><br>
		<%if(currentTimeSec > endTimeSec) {%>
		<h2>도전기한 만료</h2>
		<%} else { %>
		<span id="timeLimit"></span>
		<%} %>
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
		<%if(currentTimeSec < endTimeSec) {%>
		<a href="<%=request.getContextPath() %>/donate/donateJoin.jsp?challengeNo=<%=challengeNo%>" class="link-btn">후원하기</a>
		<a href="<%=request.getContextPath() %>/auth/authInsert.jsp?challengeNo=<%=challengeListDto.getChallengeNo()%>&categoryNo=<%=challengeListDto.getCategoryNo()%>" class="link-btn">인증하기</a>
		<%} %>
		<!-- 자바스크립트 추가 예정 : 세션값과 작성자가 일치하면 인증하기 버튼 출력 -->
		<a href="challengeList.jsp" class="link-btn">목록</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>