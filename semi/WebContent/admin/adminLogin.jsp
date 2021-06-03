<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.login_title{
			font-size : 40px;
			font-family: Arial Black,"Times New Roman",Monospace;
			text-align : center;
		}
		
		.login_btn{
		background : black;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
		}
		
		.login_user{
		text-align : center;
		padding: 5px 0px;
		}

</style>
<div class="container-600">

	<div class="row">
		<div class="login_title">LOGIN</div>
		<div class="login_btn login_user">관리자</div>
		<h2>로그인</h2>
		<hr>
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
			<input type="submit" value="LOGIN" class="form-btn login_btn">
		</div>
		<hr>
	</form>
	<% if (request.getParameter("error")!=null) {%>
	<div class="error">
		<h5> 정보가 일치하지 않습니다.</h5>
	</div>
	<% } %>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
