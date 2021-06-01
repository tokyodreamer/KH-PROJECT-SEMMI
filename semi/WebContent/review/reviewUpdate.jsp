<%@page import="semi.review.beans.ReviewListDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.review.beans.ReviewListDao"%>
<%@page import="semi.review.beans.ReviewDao"%>
<%@page import="semi.review.beans.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//게시판넘버가 필요함
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));

	//상세보기를 가져오기 위해 dao를 사용해서 get(상세보기)을 불러옴
	// ReviewDao reviewDao = new ReviewDao();
	// ReviewDto reviewDto = reviewDao.get(reviewNo);

	//상세보기 대신에 리뷰게시판목록이 필요함
	ReviewListDao reviewListDao = new ReviewListDao(); 

	// ReviewListDao 에서 수정 버튼에서 가져온 리뷰닉네임을 조건절로 하여 조회문을 하는 메소드를 작성한 후 
	// reviewUpdate.jsp 에 ReviewListDao 에서 조회한 결과값을 출력

 	ReviewListDto reviewListDto = reviewListDao.findReview(reviewNo);
%>
	<jsp:include page="/template/header.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<div class="container-600">
	<div class="row">
		<h2>수정페이지</h2>
	</div>	
	<!-- 		보내야 할 항목(3개), 사용자가 고치는 항목 2개(평점, 내용)) , 히든1개-->
	<form action="reviewUpdate.kh" method="post">
		<div class="row">
			<input type="text" name="reviewNo" value="<%=reviewListDto.getReviewNo()%>">
		</div>
		<div class="row">
			<label>별점</label> 
			<select name="reviewStar" id="star" required>
	            <option value="5" selected>★★★★★</option>
	            <option value="4">★★★★☆</option>
	            <option value="3">★★★☆☆</option>
	            <option value="2">★★☆☆☆</option>
	            <option value="1">★☆☆☆☆</option>
	            <option value="0">☆☆☆☆☆</option>
	           </select>
		</div>
		<div class="row">
			<label>내용</label>
			<textarea name="reviewContent"><%=reviewListDto.getReviewContent() %></textarea>
		</div>
		<div class="row">
			<input type="submit" value="수정">
		</div>
	</form>
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>