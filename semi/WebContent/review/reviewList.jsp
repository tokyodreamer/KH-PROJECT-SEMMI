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
    font-size: 15px;
}
#time{
margin-left: 70%;
}
#nick, #star {
	margin: 10px;
}


#content {
border: 1px solid lightgrey;
border-radius: 15px;
	width: 100%;
	height: 150px;
	padding: 30px;
	
}

#textarea{
	resize: none;
	text-align:left;
	overflow:auto;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#delete-btn").click(function(e){
		var a = window.confirm("정말로 삭제하시겠습니까?")
			if(!a){
				e.preventDefault();
			}
	});
</script>


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
		<% for (ReviewListDto reDto : reviewList) { %>
		<div class="row" id="review-box">
			<div class="row">
				<img src="#" alt="profileIMG">
			</div>
			<div class="row">
				<label id="nick">닉네임:</label>
				<span class="sp-nick">
				<%if(reDto.getMemberNick()==null){%>
				 예전 회원
				<%}else{ %>
				<%=reDto.getMemberNick()%>
				<%}%>
				</span>
			</div>
			<div class="row">
				<label id="star"></label>
				<% if (reDto.getReviewStar() == 5) { %>
				<span>★★★★★</span>
				<%} else if (reDto.getReviewStar() == 4) { %>
				<span>★★★★☆</span>
				<%} else if (reDto.getReviewStar() == 3) { %>
				<span>★★★☆☆</span>
				<%} else if (reDto.getReviewStar() == 2) {%>
				<span>★★☆☆☆</span>
				<%} else if (reDto.getReviewStar() == 1) {%>
				<span>★☆☆☆☆</span>
				<%} else if (reDto.getReviewStar() == 0) {%>
				<span>☆☆☆☆☆</span>
				<%}%>
				<span id="time"><%=reDto.getReviewTime()%></span>
			</div>
			<div class="row text-left">
<!-- 			 <textarea  cols="140" rows="10" id="textarea"  readonly> -->
<%-- 				<%=reDto.getReviewContent()%> --%>
<!-- 			</textarea> -->
			<pre id="content"><%=reDto.getReviewContent()%></pre>
			
			</div>

		<% if (request.getSession().getAttribute("memberNo") != null && reDto.getReviewNick() == (int) request.getSession().getAttribute("memberNo")) { %>
			<a class="link-btn" href="<%=request.getContextPath()%>/review/reviewUpdate.jsp?reviewNo=<%=reDto.getReviewNo()%>">수정</a>
			<a class="link-btn" href="<%=request.getContextPath()%>/review/reviewDelete.kh?reviewNo=<%=reDto.getReviewNo()%>" id="delete-btn">삭제</a>
		<%} %>
		<!-- 반복문 종료  -->
		</div>
		<%} %>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>