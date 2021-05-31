<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>
    <div class="container-600">
		<div class="row">
		<h2>후기 게시판</h2>
		</div>    
    
		<div class="row">
		아이디(외래키):<span></span>
		</div>    

		<div class="row">
		도전명
		</div>    

		
		<div class="row">
		내용<textarea></textarea>
		</div>

    <input type="submit" value="등록하기">
    
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>