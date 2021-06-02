<%@page import="semi.review.beans.ReviewListDto"%>
<%@page import="semi.review.beans.ReviewListDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 리스트 목록 불러오기 
	ReviewListDao reListDao = new ReviewListDao(); 
	List<ReviewListDto> reviewList = reListDao.list();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<h2>후기 목록페이지</h2>
<!-- 예시 -->
<div class="contaier-600">
	<div class="row text-right">
		<%if(request.getSession().getAttribute("memberNo")!=null){ %>
			<a href="reviewWrite.jsp" class="link-btn">후기 작성하러 가기</a>
		<%} %>
	</div>
	<%for(ReviewListDto reDto : reviewList){ %>
	<div class="" id="review-box">
		<div class="row">
			<h4><%=reDto.getReviewNo() %></h4>
		</div>
		<div class="row">
			<label>닉네임</label>
			<%if(reDto.getMemberNick() == null) {%>
				<h4>탈퇴 회원</h4>
			<%} else { %>
				<%= reDto.getMemberNick()%>
			<%} %>
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
		<!-- 조건절 : 비회원이 아닌 상태일 때(세션에 값이 있을 때) && 작성자와 세션 번호(로그인한 사람)이 일치할 떼 -->
		<%if(request.getSession().getAttribute("memberNo") != null && reDto.getReviewNick() == (int) request.getSession().getAttribute("memberNo")) {%>
		<div class="row">
			<a class="link-btn" href="<%=request.getContextPath()%>/review/reviewUpdate.jsp?reviewNo=<%=reDto.getReviewNo()%>">수정</a>
			<a class="link-btn" href="<%=request.getContextPath()%>/review/reviewDelete.kh?reviewNo=<%=reDto.getReviewNo()%>">삭제</a> <!-- href : 삭제할 때는 후기 작성자 번호가 필요   -->
		</div>
		<%}%>
	</div>
	<%} %>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>
