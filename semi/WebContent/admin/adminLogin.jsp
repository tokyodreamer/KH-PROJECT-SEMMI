<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h1>관리자 로그인</h1>
	</div>

	<form action="adminLogin.kh" method="post">
		<div class="row">
			<label> 아이디 </label> <input type="text" name="adminId" required
				class="form-input">
		</div>
		<div class="row">
			<label> 비밀번호 </label> <input type="password" name="adminPw" required
				class="form-input">
		</div>
		<div class="row">
			<input type="submit" value="로그인" class="btn-input">
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
