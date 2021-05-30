<%@page import="semi.review.beans.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

받아와야 할 항목들: 후기 게시판 넘버, 사용자 아이디,시간은(수정시간), 평점, 후기내용
수정해햐 할 항목들: 평점, 후기내용
히든 항목: 후기 게시판 넘버


	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<div class="container-600">
	<div class="row">
		<h2>수정페이지</h2>
	</div>	
		
	<form action="수정페이지" method="post">


		<div class="row">
		번호:<input type="text" name="reviewNo" value="">
		</div>


		<div class="row">
		평점:<select name="reviewStar">
   		<option value="">선택하세요</option>
   		<option >★★★★★</option>
   		<option >★★★★☆</option>
   		<option >★★★☆☆</option>
   		<option >★★☆☆☆</option>
   		<option >★☆☆☆☆</option>
   		<option >☆☆☆☆☆</option>
		</select>
		</div>

	<div class="row">
	내용: <textarea name="reviewContent"></textarea>
	</div>

	<div class="row">
	<input type="submit" value="수정">
	</div>

	
	
		</form>
	</div>
	<jsp:include page="/template/footer.jsp"></jsp:include>