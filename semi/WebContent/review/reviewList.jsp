<%@page import="semi.review.beans.ReviewListDto"%>
<%@page import="semi.review.beans.ReviewListDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
	<style>
	.container{
	border: 1px soild black;
	}
	#review-box{
	border: 1px soild black;
	}
	</style>
	</head>
<body>

<%
	// 리스트 목록 불러오기 
	ReviewListDao reListDao = new ReviewListDao(); 
	List<ReviewListDto> reviewList = reListDao.list();
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<h2 color: red;>후기</h2>
<!-- 예시 -->
<div class="container-1000">
	<div class="row text-right">
		<%if(request.getSession().getAttribute("memberNo")!=null){ %>
		<a href="reviewWrite.jsp" class="link-btn">후기 작성하러 가기</a>
		<%} %>
	</div>

	<%for(ReviewListDto reDto : reviewList){ %>
	<div class="" id="review-box">
		<div class="row">
			<label>닉네임</label>
			<h4><%= reDto.getMemberNick()%></h4>
		</div>
		<div class="row">
			<label>작성일</label>
			<h4><%= reDto.getReviewTime() %></h4>
		</div>
		<div class="row">
			<label>평점</label>
			<%if(reDto.getReviewStar() == 5) {%>
			<h4>★★★★★</h4>
			<%} else if(reDto.getReviewStar() == 4) {%>
			<h4>★★★★☆</h4>
			<%} else if(reDto.getReviewStar() == 3) {%>
			<h4>★★★☆☆</h4>
			<%} else if(reDto.getReviewStar() == 2) {%>
			<h4>★★☆☆☆</h4>
			<%} else if(reDto.getReviewStar() == 1) {%>
			<h4>★☆☆☆☆</h4>
			<%} else if(reDto.getReviewStar() == 0 ) {%>
			<h4>☆☆☆☆☆</h4>
			<%} %>
		</div>
		<div class="row">
			<label>내용</label>
			<h4><%= reDto.getReviewContent() %></h4>
		</div>
		<div class="row">
			<!-- 작성한 사람이 로그인한 사람하고 동일하면 삭제 버튼 보여주기 (if) -->
			<a class="link-btn" href="#">삭제</a> <!-- href : 삭제할 때는 후기 작성자 번호가 필요   -->
		</div>
	</div>
	<%} %>
</div>
</body>
</html>


<jsp:include page="/template/footer.jsp"></jsp:include>