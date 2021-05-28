<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>
    <div class="container-600">
		<div class="row">
		<h2>후기 게시판</h2>
		</div>    
    
    	<form action="reviewWrite.kh" method="post">
		<div class="row">
		아이디(외래키 넘버):<input type="text" >
		</div>    

		<div class="row">
		평점(String)<input type="text">
		
		</div>    
<!-- 		평점<select>선택하세요 -->
<!-- 				<option>★</option> -->
<!-- 				<option>★★</option> -->
<!-- 		</select> -->

		
		<div class="row">
		내용<input type="text">
		</div>

    <input type="submit" value="등록하기">
    <h2>세션 값 : <%=session.getAttribute("memberNo") %></h2>
    	</form>
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>