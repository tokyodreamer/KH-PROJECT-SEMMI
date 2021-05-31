<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="semi.donate.beans.DonateDao"%>
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
	
	ChallengeDao challengeDao = new ChallengeDao();
	
	int memberNo = (int)session.getAttribute("memberNo");
	Set<Integer> challengeNoSet;
	if(session.getAttribute("challengeNoSet") != null){
		challengeNoSet = (Set<Integer>)session.getAttribute("challengeNoSet");
	}
	else {
		challengeNoSet = new HashSet<>();
	}
	
	if(challengeNoSet.add(challengeNo)){
		challengeDao.read(challengeNo, memberNo);
		System.out.println("조회수 증가");
	}
	
	System.out.println("저장소 : "+challengeNoSet);
	
	//저장소 갱신
	session.setAttribute("challengeNoSet", challengeNoSet);
	
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
	
	// 해당 도전글의 후원한 기록이 있는 지 확인하는 메소드 호출
	DonateDao donateDao = new DonateDao();
	
	// 도전 기록이 있는 지 확인된 회원번호
	int checkDonateMember = donateDao.checkDonate(challengeNo);
	
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 자바에서 가져온 타임리미트 기간
		var timeLimitMills = <%=timeLimitMills %>;
		
		setInterval(PrintTime, 1000);
		
		// 카운트다운 출력 : 
		// 실시간으로 초 단위가 사라지게끔 출력 (미구현 : 현재 새로고침을 통해 타임리미트 확인은 가능 // 05.30에 구현 실패 - > 강사님께 여쭤보기!)
		function PrintTime(){
			var dd = parseInt(timeLimitMills/1000/60/60/24);
			var hh = parseInt(timeLimitMills/1000/60/60%24);
			var mm = parseInt(timeLimitMills/1000/60%60);
			var ss = parseInt(timeLimitMills/1000%60);
			
			if(ss === 0) {
				mm--;
				ss = 60;
			} else if(mm === 0) {
				hh--;
				mm = 60;
			} else if(hh === 0){
				dd--;
				hh = 24;
			}
			
			$("#timeLimit").text("종료까지 " + dd + " 일 " + hh + " 시간 " + mm + " 분 " + "남았습니다");
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
		<div id="timeLimit" class="row"></div>
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
		<!-- 도전 기한이 남았을 때 && 도전글 작성자가 자신의 도전글 페이지에 있을 때 인증하기 버튼 출력 -->
		<%if(currentTimeSec < endTimeSec && challengeListDto.getMemberNo() == (int) request.getSession().getAttribute("memberNo")) {%>
			<a href="<%=request.getContextPath() %>/auth/authInsert.jsp?challengeNo=<%=challengeListDto.getChallengeNo()%>&categoryNo=<%=challengeListDto.getCategoryNo()%>" class="ex-btn">인증하기</a>
		<!-- 도전 기한이 남았을 때 && 로그인한 회원이 해당 도전글에 후원했던 내역이 없으면 후원하기 버튼 출력  -->
		<%}else if(System.currentTimeMillis() < endDateParsed.getTime() && checkDonateMember != (int) request.getSession().getAttribute("memberNo"))  {%>
			<a href="<%=request.getContextPath() %>/donate/donateJoin.jsp?challengeNo=<%=challengeNo%>" class="ex-btn">후원하기</a>
		<!-- 도전 기한이 남았을 때 && 로그인한 회원이 후원한 내역이 있다면 이미 후원하였다는 문구 출력 -->
		<%} else  if(System.currentTimeMillis() < endDateParsed.getTime() && checkDonateMember == (int) request.getSession().getAttribute("memberNo"))  {%>
			<h4>이미 후원하였습니다</h4>
		<%} %>
		<!-- 도전 기한이 만료되었다면 몰고 리스트만 출력 -->
		<a href="challengeList.jsp" class="ex-btn">목록</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>