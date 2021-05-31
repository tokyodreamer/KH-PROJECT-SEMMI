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
#content{
border: 1px solid lightgray;
padding: 10px;
}

h2{
text-align: center;
text-shadow: 5px 5px 3px lightgrey;
}

#review-box{
border: 1px solid black;
margin:10px auto;
padding: 20px;
}

.link-btn{
background-color: black;
color: white;
}

#nick,#time{
font-style:italic;
}

.sp-nick{
margin-left: 10px;
}
</style>
</head>

		
	
<body>
<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container-1000" id="container" >
	
	<div class="row text-right">
<h2>후기</h2> 
		<%if(request.getSession().getAttribute("memberNo")!=null){ %>
		<a href="reviewWrite.jsp" class="link-btn">후기 작성하러 가기!</a>
		<%} %>
	</div>

	<%for(ReviewListDto reDto : reviewList){ %>
	<div class="" id="review-box">
		<div class="row">
			<label id="nick" >닉네임:</label><span class="sp-nick"><%= reDto.getMemberNick()%></span>
		</div>
		<div class="row">
<!-- 			<label>작성일</label> -->
			<h4 id="time"><%= reDto.getReviewTime() %></h4>
		</div>
		<div class="row">
<!-- 			<label>평점</label> -->
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
		<div class="row" id="content">
			<h4><%= reDto.getReviewContent() %></h4>
		</div>
		<div class="row text-right">
			<%if(request.getSession().getAttribute("memberNo")!=null){ %>
			<a class="link-btn" href ="#">수정</a>
			<%} %>
		
			<%if(request.getSession().getAttribute("memberNo")!=null){ %>
			<a class="link-btn" href="#">삭제</a> 
			<%} %>
		</div>
		
	</div>
	<%} %>
</div>
</body>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>
