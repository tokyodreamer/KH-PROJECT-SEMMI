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
<style>
.donate-form {
}
.donate-input {
	width: 100%;
	padding: 1rem;
	outline: none;
}

.donate-input.donate-input-underline {
	border: none;
	border-bottom: 3px solid black;
	font-size: 20px;
	font-weight:bold;
}

.donate-input.donate-input-underline:focus {
	border-bottom-color: black;
}

.donate-input.donate-input-inline {
	width: auto;
}

/* 후원 라벨 */
.donate-label {
	font-size: 20px;
	font-weight:bold;
}

/* 후원 에러 메세지 : */
.fail-message {
	display: none;
	color: red;
	font-size: 20px;
	font-weight: bold;
}

.success-message {
	display: none;
	color: green;
	font-size: 20px;
	font-weight: bold;
}
/* 후원하기 버튼 (완료)*/
.donate-btn {
	margin-top: 20px;
	width: 30%;
	border: none;
	background-color: black;
	color: white;
	height: 50px;
	font-size: 20px;
	font-weight: bold;
}

/* 후원하기 버튼 : HOVER (완료)*/
.donate-btn:hover {
	background-color: rgb(46, 163, 79);
	color: white;
}

/* 목록 버튼 (완료) */
.donate-btn.donate-btn-list {
	margin-left: 10%;
	width: 30%;
	background-color: white;
	color: black;
	border: 1px solid black;
	height: 50px;
	font-size: 20px;
	font-weight: bold;
}

/* 목록 버튼 : HOVER (완료) */
.donate-btn.donate-btn-list:hover {
	background-color: lightgrey;
}

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 참가비 :
		$("#donatePoint").blur(function(){
			
			// 후원금은 참가비의 1%만 가능 (완료)
			if($("#donatePoint").val() > (<%=challengeListDto.getChallengePushPoint()%>*0.01)){
					$(this).nextAll(".fail-message").show();
					$("#donatePoint").val(<%=challengeListDto.getChallengePushPoint()%>*0.01);
					$("#donatePoint").focus();
			} else {
				$(this).nextAll(".fail-message").hide();
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
		
		$("#list").click(function(e){
			e.preventDefault();
			location.href="<%=request.getContextPath()%>/challenge/challengeList.jsp";
		})
	});
</script>
<div class="container-600">
	<div class="row">
		<h2>후원 페이지</h2>
	</div>
	<br>
	<div class="row">
		<h2>참가비 : <%=challengeListDto.getChallengePushPoint() %> 포인트</h2>
	</div>
	<br>
	<div class="row">
		<h2>후원 가능한 포인트 : <%=memberDto.getMemberPoint()%> 포인트</h2>
	</div>
	<br>
	<form action="donateJoin.kh?donateChallengeNo=<%=challengeNo%>&donateMemberNo=<%=memberNo%>&donateCategoryNo=<%=challengeListDto.getCategoryNo()%>" class="donate-form" method="post">
		<div class="row">
			<label class="donate-label">후원금 입력</label>
			<input type="number" class="donate-input donate-input-underline" name="donatePushPoint"  id="donatePoint">
			<br><br>
			<span class="fail-message">후원금은 참가비의 1% 포인트까지 후원할 수 있습니다</span>
			<span class="success-message">후원 가능합니다</span>
		</div>
		<div class="row">
			<input type="submit"  class="donate-btn" value="후원하기">
			<button class="donate-btn donate-btn-list" id="list">목록</button>
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>