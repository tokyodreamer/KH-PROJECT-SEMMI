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

<div class="container-600">
	<div class="row">
		<h2><%=challengeListDto.getChallengeTitle() %> : 후원하기 페이지</h2>
	</div>
	<div class="row">
		<h4>참가비 : <%=challengeListDto.getChallengePushPoint() %> 포인트</h4>
	</div>
	<div class="row">
		<h4><%=memberDto.getMemberNick()%> 님의  후원 가능한 포인트 : <%=memberDto.getMemberPoint()	%> 포인트</h4>
	</div>
	<form action="donateJoin.kh?donateChallengeNo=<%=challengeNo%>&donateMemberNo=<%=memberNo%>&donateCategoryNo=<%=challengeListDto.getCategoryNo()%>" method="post">
		<div class="row">
			<label>후원금 입력</label>
			<input type="number" class="form-input form-input-underline" name="donatePushPoint" placeholder="후원금은 최대 참가비의 1%만 가능합니다">
		</div>
		<div class="row">
			<input type="submit"  class="form-btn form-btn-positive" value="후원하기">
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>