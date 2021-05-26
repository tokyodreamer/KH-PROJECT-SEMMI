<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<div>
		<h2>비밀번호 확인</h2>
	</div>
	<div>
		<form action="" method="post">
			<div>비밀번호 확인 : <input type="password" name="nowPw" placeholder="현재 비밀번호" required></div>
			<div><input type="submit" value="확인"></div>
		</form>
	</div>
	
	<jsp:include page="/template/footer.jsp"></jsp:include>