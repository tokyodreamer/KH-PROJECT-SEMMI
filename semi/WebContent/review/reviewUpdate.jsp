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
	<style>
.title{
	text-align:center;
	font-size: 20px;
	font-weight: bold;
}
.score{
font-size: 40px;
color:red;
}
.link-btn.loginlogout{
background-color: black;
color:white;
font-size: 20px;
}
.link-btn.cancle{
	display: inline-block;
	padding: 0.75rem;
	padding-left: 4rem;
	padding-right:4rem;
	border: 2px solid black ;
	text-decoration: none;
	border-radius: 1.5rem;
	margin-left:25px;
	margin-right:25px;
	background-color: white;
	color:black;
	font-size: 20px;
}
.container-600{
text-align: center;
}
.form-input{
font-size: 30px;
}
	
	
	
	</style>
	
	
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<h2>수정페이지</h2>
	<div class="container-600">
	<div class="row">
	</div>	
	<!-- 		보내야 할 항목(3개), 사용자가 고치는 항목 2개(평점, 내용)) , 히든1개-->
	<form action="reviewUpdate.kh" method="post">
		
		<div class="row">
			<input type="hidden" name="reviewNo" value="<%=reviewListDto.getReviewNo()%>">
		</div>
		
		<div class="row">
			<label class="title">도전은 어떠셨나요</label> 
				<br><br>
			<select name="reviewStar" id="star" required  class="score">
	            <option value="5" selected>★★★★★</option>
	            <option value="4">★★★★☆</option>
	            <option value="3">★★★☆☆</option>
	            <option value="2">★★☆☆☆</option>
	            <option value="1">★☆☆☆☆</option>
	            <option value="0">☆☆☆☆☆</option>
	           </select>
		</div>
		
			<br>
		<div class="row">
			<label class="title"> 소감을 남겨주세요</label>
			<br><br>
			<textarea name="reviewContent" class="form-input"><%=reviewListDto.getReviewContent() %></textarea>
		</div>
		
		<div class="row">
		<br><br>
			<input type="submit" value="수정하기" class="link-btn loginlogout">
			<a href="reviewList.jsp" class="link-btn cancle">목록으로</a>
		</div>
		
	</form>
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>