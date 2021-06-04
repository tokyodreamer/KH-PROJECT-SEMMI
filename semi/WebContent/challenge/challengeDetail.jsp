<%@page import="semi.member.beans.MemberDto"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.auth.beans.AuthDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.auth.beans.AuthDao"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="semi.donate.beans.DonateDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="semi.challenge.beans.ChallengeListDto"%>
<%@page import="semi.challenge.beans.ChallengeListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 



	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));

	ChallengeListDao challengeListDao = new ChallengeListDao();
	
	ChallengeDao challengeDao = new ChallengeDao();
	
	//조회수 증가는 무조건 이루어지는 작업이 아니다.
	//= 조회수는 자신의 글을 읽는 경우에는 늘어나면 안된다
	//		= 현재 회원의 번호를 조회수 증가 기능에 같이 전달하여 조건으로 사용
	//= 한 번 읽었던 글을 또 읽는 경우에는 늘어나면 안된다(세션)
	
	int memberNo = (int)session.getAttribute("memberNo");
	Set<Integer> challengeNoSet;
	if(session.getAttribute("challengeNoSet") != null){//세션에 boardNoSet이라는 이름의 저장소가 있다면 --> 저장소 추출
		challengeNoSet = (Set<Integer>)session.getAttribute("challengeNoSet");
	}
	else{//세션에 boardNoSet이라는 이름의 저장소가 없다면 --> 저장소 생성
		challengeNoSet = new HashSet<>();
	}
	if(challengeNoSet.add(challengeNo)){//challengeNoSet에 현재 도전글번호(challengedNo)가 추가되었다면 --> 처음 읽는 글이라면
		challengeDao.read(challengeNo, memberNo); //조회수 증가
 	//	System.out.println("조회수 증가");
	}
 	//  System.out.println("저장소 : "+challengeNoSet);
	
	//저장소 갱신
	session.setAttribute("challengeNoSet", challengeNoSet);
	
	ChallengeListDto challengeListDto = challengeListDao.getChallenge(challengeNo);
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(memberNo);
	
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
			
			$("#timeLimit").text("종료까지 " + dd + " 일 " + hh + " 시간 " + mm + " 분 ");
			ss--;
		}; 
		
	});
	
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/donateJoin.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 참가비 :
		
		$("#donatePoint").focus(function(){
			$(this).nextAll(".fail-message-01").hide();
			$(this).nextAll(".fail-message-02").hide();
			$(this).nextAll(".success-message").hide();
			$(this).nextAll(".donate-checkPoint").show();
		});
	
		$("#donatePoint").submit(function(){
			$(this).nextAll(".donate-checkPoint").hide();
			
			// 후원금은 참가비의 1%까지만 가능하며 최소 후원 포인트는 100 포인트 이상 (완료)
			if($("#donatePoint").val() > (<%=challengeListDto.getChallengePushPoint()%>*0.01)){
					$(this).nextAll(".donate-checkPoint").hide();
					$(this).nextAll(".success-message").hide();
					$(this).nextAll(".fail-message-02").hide();
					$(this).nextAll(".fail-message-01").show();
					$("#donatePoint").val(<%=challengeListDto.getChallengePushPoint()%>*0.01);
			// 조건절 : 
			} else if($("#donatePoint").val() == "") {
				$(this).nextAll(".donate-checkPoint").hide();
				$(this).nextAll(".success-message").hide();
				$(this).nextAll(".fail-message-01").hide();
				$(this).nextAll(".fail-message-02").show();
				$("#donatePoint").val(100);
			// 조건절 : 
			} else if( $("#donatePoint").val() < 100){
				$(this).nextAll(".donate-checkPoint").hide();
				$(this).nextAll(".success-message").hide();
				$(this).nextAll(".fail-message-01").hide();
				$(this).nextAll(".fail-message-02").show();
				$("#donatePoint").val(100);
			} else {
				$(this).nextAll(".fail-message-01").hide();
				$(this).nextAll(".fail-message-02").hide();
				$(this).nextAll(".donate-checkPoint").hide();
				$(this).nextAll(".success-message").show();
			}
			
		});
		
		$(".donate-form").submit(function(e){
				
				// 후원금이 참가비의 1% 이상이면 이벤트 중지 (완료)
				if($("#donatePoint").val() > (<%=challengeListDto.getChallengePushPoint()%>*0.01)){
					alert("후원은 도전자 <%=challengeListDto.getMemberNick()%>님의 도전 참가비인 <%=challengeListDto.getChallengePushPoint()%>Point의 1%까지 할 수 있습니다.");
					e.preventDefault();
					$("#donatePoint").val(<%=challengeListDto.getChallengePushPoint()%>*0.01);
					$("#donatePoint").focus();
				}
				else if($("#donatePoint").val() < 100){
					alert("최소 후원금은 100Point 입니다");
					e.preventDefault();
					$("#donatePoint").val(100);
					$("#donatePoint").focus();
					}	
		});
		
		// 목록 페이지 이동 (완료)
		$("#list").click(function(e){
			e.preventDefault();
			location.href="<%=request.getContextPath()%>/challenge/challengeList.jsp";
		});
		
	});
</script>
<style>
	.title{
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	
	}
	.content{
	margin-left: auto;
	margin-right: auto;
	min-height:100px;
	font-size:23px;
	width:90%;
	border: 2px dashed black;
	padding:2rem;
	margin-top: 20px;
	border-radius: .7em;
	}
	.title-content{
	margin:none;
	width:55%;
	display:inline-block;
	}
	.description{
	margin-top: 40px;
	margin-right:18%;
	float: right;
	height:200px;
	width:25%;
	display: inline-block;
	border: 1px solid black;
	font-size: 30px;
	border-radius: 1em;
	}
	.description  li{
	list-style: none;
	}
	.leftTime >li {
	}
	.table.authList{
	margin-top: 30px;
	width:50%;
	}
	.table.authList {
	}
	.donatePage{
	margin-top: 30px;
	width:45%;
	border-top: 2px dotted black;
	border-bottom: 2px dotted black;
	text-align: center;
	}
	.donateInfo{
	font-size:18px;
	font-weight: bold;
	padding-top:0.5rem;
	}

</style>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container-1500">
	<div class="title-content"> 
	
	<div class="title"> <%=challengeListDto.getChallengeTitle() %>
	<span style="font-family:cursive; font-size: 20px; position: relative;"> ( 도전자: <%=challengeListDto.getMemberNick()%> )</span>
	</div>
	<div class=" content"> <%=challengeListDto.getChallengeContent() %></div>
</div>


<div class="description">
<ul>
<div class="percent"><li> <span style=" font-size:22px; font-weight:bold;">현재 달성률:&nbsp&nbsp </span> <%=challengeListDto.getChallengePercent() %> %</li></div>
<div class="duration"> <li> <span style="font-size:22px; font-weight:bold;">도전 기간:&nbsp&nbsp</span><%=challengeListDto.getChallengeStartDate().substring(5,10) %>
~ <%=challengeListDto.getChallengeEndDate().substring(5,10) %> </li>
<div class="totalPoint"><li> <span style="font-size:22px; font-weight:bold;"> 누적 후원금: </span> <%=challengeListDto.getChallengeDonate() %> Point</li> </div>

<div class="leftTime"> <li>
		<%if(currentTimeSec > endTimeSec) {%>
		<span style="font-size:22px; font-weight:bold; color:red;">도전기한 만료됨 </span>
		<%} else { %>
		<span id="timeLimit" style="font-size:22px; font-weight: bold; color:blue;"></span>
		<%} %> </li>
</div>
</ul>
</div>

	<div class="donatePage">

	<form action="<%=request.getContextPath()%>/donate/donateJoin.kh?donateChallengeNo=<%=challengeNo%>&donateMemberNo=<%=memberNo%>&donateCategoryNo=<%=challengeListDto.getCategoryNo()%>" class="donate-form" method="post">
		<span class="donateInfo"> "후원자가 되어 <%=challengeListDto.getMemberNick()%>님의 도전을 응원해 주세요."
	&nbsp<a href="#" class="link-btn Info">후원 혜택 알아보기</a></span> 
	<div>
			<span class="donate-span">To. <%=challengeListDto.getMemberNick()%></span>
			<input type="number" class="donate-input donate-input-underline" name="donatePushPoint"  id="donatePoint" >
			<input type="submit"  class="donate-btn" value="후원하기">
			<br>
			<span class="fail-message-01">후원은 도전자 <%=challengeListDto.getMemberNick()%>님의
			도전 참가비인 <%=challengeListDto.getChallengePushPoint()%>Point의 1%까지 할 수 있습니다.</span>
			<span class="fail-message-02">최소 후원금은 100 포인트 입니다</span>
			<span class="donate-checkPoint">후원은 100Point ~ <%=challengeListDto.getChallengePushPoint() *1/100%>Point 사이에서 할 수 있습니다.</span>
			<span class="success-message"> 후원 성공</span>
			</div>
	</form>
	</div>
	
<% 
AuthDao authDao = new AuthDao();
List<AuthDto> authListByChallenge = authDao.listByChallenge(challengeNo);
%>
	<div class="authList">
	<table class="table table-border authlist">
		<thead>
		<tr>
			<th colspan="4" style="font-size:22px"> 인증</th>
				
		</tr>
		</thead>
		<tbody>
		
	<%for(AuthDto authDto : authListByChallenge){ %>
			<tr>
  			<th style=" width:120px; height:120px"> <img src="<%=request.getContextPath()%>/auth/authDetail.kh?authNo=<%=authDto.getAuthNo()%>" width="100%;" height="100%;"></th>
			<th style="font-size:22px; width:200px"> <%=authDto.getAuthTitle() %> <br>(
				<%=authDto.getAuthTimeLine() %>
				)</th>
				<td style="width:270px;"> <%=authDto.getAuthContent() %></td>
				<th>
				<%
				String authResult;
				String color;
				if(authDto.getAuthResult().equals("N")){
					authResult = "승인 대기 중";
					color = "green";
				}
				else if(authDto.getAuthResult().equals("S")){
					authResult = "인증 승인 됨";
					color = "blue";
				}
				else{
					authResult = "인증 실패";
					color = "red";
				}
				
				%>
				<span style="color:<%=color %>"><%=authResult%></span> <hr>
				<%=authDto.getAuthReason() %> </th>
			
			</tr>
 			<%} %> 
 			<%int listSize = authListByChallenge.size();
 			%>
 			
 			
			<%if(listSize==0){ %>
			<tr>
				<th>아직 도전자 <%=challengeListDto.getMemberNick()%>님이 올리신 인증글이 없습니다. 
				</th>
			</tr>
			<%} %>
		</tbody>
	
	</table>
	</div>
	
<jsp:include page="/reply/reply.jsp?challengeNo=<%=challengeNo %>"></jsp:include>

	<div class="row text-left">
		<!-- 도전 기한이 남았을 때 && 도전글 작성자가 자신의 도전글 페이지에 있을 때 인증하기 버튼 출력 -->
		<%if(currentTimeSec < endTimeSec && challengeListDto.getMemberNo() == (int) request.getSession().getAttribute("memberNo")) {%>
			<a href="<%=request.getContextPath() %>/auth/authInsert.jsp?challengeNo=<%=challengeListDto.getChallengeNo()%>&categoryNo=<%=challengeListDto.getCategoryNo()%>" class="ex-btn">인증하기</a>
		<!-- 도전 기한이 남았을 때 && 로그인한 회원이 해당 도전글에 후원했던 내역이 없으면 후원하기 버튼 출력  -->
		<%}else if(System.currentTimeMillis() < endDateParsed.getTime() && checkDonateMember != (int) request.getSession().getAttribute("memberNo"))  {%>
			<a href="<%=request.getContextPath() %>/donate/donateJoin.jsp?challengeNo=<%=challengeNo%>" class="ex-btn">후원하기</a>
		<!-- 도전 기한이 남았을 때 && 로그인한 회원이 후원한 내역이 있다면 이미 후원하였다는 문구 출력 -->
		<%} else  if(System.currentTimeMillis() < endDateParsed.getTime() && checkDonateMember == (int) request.getSession().getAttribute("memberNo"))  {%>
			<a>이미 후원하였습니다<a>
		<%} %>
		<!-- 도전 기한이 만료되었다면 몰고 리스트만 출력 -->
		
	</div>
	<button class="donate-btn donate-btn-list" id="list">목록</button>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>