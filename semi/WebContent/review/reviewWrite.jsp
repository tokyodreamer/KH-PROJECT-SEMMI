<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>


<div class="container-600">

	<div class="row">
		<h2>후기 등록하기</h2>
	</div>

	<div class="row">

		<form action="reviewWrite.kh" method="post">

			<label>별점</label> <select name="reviewStar" id="star">
				<option value="5" selected>★★★★★</option>
				<option value="4">★★★★☆</option>
				<option value="3">★★★☆☆</option>
				<option value="2">★★☆☆☆</option>
				<option value="1">★☆☆☆☆</option>
				<option value="0">☆☆☆☆☆</option>

			</select> <br>
			<br> 소감:
			<textarea name="reviewContent"></textarea>

			<br>
			<br> <input type="submit" value="등록하기">
		
		</form>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>


<%--  <jsp:include page="/template/header.jsp"></jsp:include>  --%>
<!--  <div class="container-600">  -->
<!-- <div class="row"> -->
<!-- 	<h2>후기 게시판</h2>  -->
<!-- 	</div>     -->

<!-- 	<form action="reviewWrite.kh" method="post">  -->
<!-- 	<div class="row">  -->
<!-- 	아이디(외래키 넘버):<input type="text" >  -->
<!-- 	</div>     -->
<!-- 	<div class="row">  -->
<!-- 	평점(String)<input type="text">  -->
<!-- </div>    -->
<!-- <!-- 		평점<select>선택하세요 -->
<!--  --> -->
<!-- <!-- 				<option>★</option> -->
<!--  --> -->
<!-- <!-- 				<option>★★</option> -->
<!--  --> -->
<!-- <!-- 		</select> -->
<!--  --> -->


<!-- <div class="row">  -->
<!-- 	내용<input type="text"> -->
<!-- 	</div> --> -->

<!--    <input type="submit" value="등록하기"> -->
<%--   <h2>세션 값 : <%=session.getAttribute("memberNo") %></h2> --%>
<!-- 	</form>  -->
<!--   </div>  -->
<%--   <jsp:include page="/template/footer.jsp"></jsp:include>  --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
