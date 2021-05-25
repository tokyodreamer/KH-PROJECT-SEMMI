<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));

	ChallengeDao challengeDao = new ChallengeDao();
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-900">
	<div class="row">
		<h2>도전글 상세보기</h2>
	</div>
	<div class="row">
	
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>