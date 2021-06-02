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

<!Doctype HTML>
<html>
<head>
<meta charset="UTF-8">
<style>
h2 {
	text-align: center;
	text-shadow: 5px 5px 3px lightgrey;
}

#review-box {
	border: 1px solid black;
	border-radius: 5px;
	margin: 10px auto;
	padding: 20px;
}

.link-btn {
	background-color: black;
	color: white;
}

#nick, #time, #star {
	font-style: italic;
}

#nick, #star {
	margin: 20px;
}

.sp-nick {
	margin-left: 10px;
}

#content {
	width: 300px;
	height: 150px;
}
</style>
<script>
$(function()){
	$(!reDto.getReviewNick() === (int) request.getSession().getAttribute("memberNo")){
	 		window.alert("본인 글만 수정할 수 있습니다")
	 	} 
	 	else{
	 		window.alert("수정이 완료되었습니다")
	 	}
	 });
	 
$(function()){
	$("#delete-btn").click(function()){
		
		var 
	 	if(!reDto.getReviewNick() == (int) request.getSession().getAttribute("memberNo")){
	 		window.alert("본인 글만 삭제할 수 있습니다")
	 		
	 	} 
	 	else{
	 		window.alert("삭제가 완료되었습니다")
	 	}
	 });
	
});

</script>
</head>

<body>
	<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container-1000">
		<h2>후기</h2>
		<div class="row text-right">
			<%
			if (request.getSession().getAttribute("memberNo") != null) {
			%>
			<a href="reviewWrite.jsp" class="link-btn">후기 작성하러 가기!</a>
			<%
			}
			%>
		</div>

		<%
		for (ReviewListDto reDto : reviewList) {
		%>

		<div class="row" id="review-box">

			<div class="row">
				<img src="#" alt="profileIMG">
			</div>

			<div class="row">
				<label id="nick">닉네임:</label><span class="sp-nick"><%=reDto.getMemberNick()%></span>
			</div>

			<div class="row text-right">
				<!-- 			<label>작성일</label> -->
				<h4 id="time"><%=reDto.getReviewTime()%></h4>

				<h4><%=reDto.getReviewNo()%></h4>
			</div>

			<div class="row">
				<label id="star"></label>
				<%
				if (reDto.getReviewStar() == 5) {
				%>
				<h4>★★★★★</h4>
				<%
				} else if (reDto.getReviewStar() == 4) {
				%>
				<h4>★★★★☆</h4>
				<%
				} else if (reDto.getReviewStar() == 3) {
				%>
				<h4>★★★☆☆</h4>
				<%
				} else if (reDto.getReviewStar() == 2) {
				%>
				<h4>★★☆☆☆</h4>
				<%
				} else if (reDto.getReviewStar() == 1) {
				%>
				<h4>★☆☆☆☆</h4>
				<%
				} else if (reDto.getReviewStar() == 0) {
				%>
				<h4>☆☆☆☆☆</h4>
				<%
				}
				%>
			</div>
			<div class="row">
				<textarea  cols="100" row="50"><%=reDto.getReviewContent()%></textarea>
			</div>

			<div class="row text-right">
				<%
				if (request.getSession().getAttribute("memberNo") != null) {
				%>
				<a class="link-btn" id="edit-btn" href="#">수정</a>
				<%
				}
				%>

				<%
				if (request.getSession().getAttribute("memberNo") != null) {
				%>
				<a class="link-btn" id="delete-btn" href="#">삭제</a>
				<%
				}
				%>

				<!-- 조건절 : 비회원이 아닌 상태일 때(세션에 값이 있을 때) && 작성자와 세션 번호(로그인한 사람)이 일치할 떼 -->
				<%
				if (request.getSession().getAttribute("memberNo") != null
						&& reDto.getReviewNick() == (int) request.getSession().getAttribute("memberNo")) {
				%>
				<div class="row">
					<a class="link-btn"
						href="<%=request.getContextPath()%>/review/reviewUpdate.jsp?reviewNo=<%=reDto.getReviewNo()%>">수정</a>
					<a class="link-btn"
						href="<%=request.getContextPath()%>/review/reviewDelete.kh?reviewNo=<%=reDto.getReviewNo()%>">삭제</a>
					<!-- href : 삭제할 때는 후기 작성자 번호가 필요   -->
				</div>
				<%
				} else {
				%>
				resp.sendError(403);
				<%
				}
				%>

				<%
				}
				%>
			</div>
		</div>
</body>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>