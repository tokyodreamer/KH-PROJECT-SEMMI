<%@page import="semi.review.beans.ReviewDao"%>
<%@page import="semi.review.beans.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//게시판넘버가 필요함
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	//상세보기를 가져오기 위해 dao를 사용해서 get(상세보기)을 불러옴
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.get(reviewNo);
%>






	<jsp:include page="/template/header.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(function(){
			
			$("select[name=reviewStar]").val("<%=reviewDto.getReviewStar()%>");
		});
	
	
	</script>
	
	<div class="container-600">
	<div class="row">
		<h2>수정페이지</h2>
	</div>	
		
<!-- 		보내야 할 항목(3개), 사용자가 고치는 항목 2개(평점, 내용)) , 히든1개-->
		
	<form action="reviewUpdate.kh" method="post">


		<div class="row">
		<input type="hidden" name="reviewNo" value="<%=reviewDto.getReviewNo()%>">
		</div>

		<div class="row">
		<label>별점</label> 
		<select name="reviewStar" id="star" value="<%=reviewDto.getReviewStar() %>">
            <option value="5" selected>★★★★★</option>
            <option value="4">★★★★☆</option>
            <option value="3">★★★☆☆</option>
            <option value="2">★★☆☆☆</option>
            <option value="1">★☆☆☆☆</option>
            <option value="0">☆☆☆☆☆</option>
		</div>

	<div class="row">
	내용: <textarea name="reviewContent"><%=reviewDto.getReviewContent() %></textarea>
	</div>

	<div class="row">
	<input type="submit" value="수정">
	</div>

	
	
		</form>
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>