<%@page import="semi.challenge.beans.ChallengeListDto"%>
<%@page import="semi.challenge.beans.ChallengeListDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));	
	int memberNo = (int) session.getAttribute("memberNo");
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(memberNo);
	
	ChallengeListDao challengeListDao = new ChallengeListDao();
	ChallengeListDto challengeListDto = challengeListDao.getChallenge(challengeNo);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<!-- CSS 스타일링 적용 -->
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
	
		$("#donatePoint").blur(function(){
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
					alert("후원금은 참가비의 1% 포인트까지 후원할 수 있습니다");
					e.preventDefault();
					$("#donatePoint").val(<%=challengeListDto.getChallengePushPoint()%>*0.01);
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
<div class="donate-container">
	<div class="row">
		<h2>후원 페이지</h2>
	</div>
	<br>
	<div class="row">
		<span class="donate-label">참가비 : <%=challengeListDto.getChallengePushPoint() %> 포인트</span>
	</div>
	<br>
	<form action="donateJoin.kh?donateChallengeNo=<%=challengeNo%>&donateMemberNo=<%=memberNo%>&donateCategoryNo=<%=challengeListDto.getCategoryNo()%>" class="donate-form" method="post">
		<div class="row">
			<label class="donate-label">후원금 입력</label><br><br>
			<span class="donate-span">포인트 : </span><input type="number" class="donate-input donate-input-underline" name="donatePushPoint"  id="donatePoint" >
			<br><br>
			<span class="donate-checkPoint">후원 가능한 포인트 : <%=memberDto.getMemberPoint()%> 포인트</span>
			<span class="fail-message-01">후원금은 참가비의 1% 포인트까지 후원할 수 있습니다</span>
			<span class="fail-message-02">최소 후원금은 100 포인트 입니다</span>
			<span class="success-message">후원 가능합니다</span>
		</div>
		<div class="row">
			<input type="submit"  class="donate-btn" value="후원하기">
			<button class="donate-btn donate-btn-list" id="list">목록</button>
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>