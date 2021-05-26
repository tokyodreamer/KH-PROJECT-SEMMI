<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<div class="container-600">
	<div class="row">
		<input type="button" value="관리자" class="form-btn">
		<h2>로그인</h2>
		<hr>
		</div>
		
		<form action="memberLogin.kh" method="post">

			<div class="row">
				<input type="text" name="memberId" placeholder="Username"
					class="form-input">
			</div>

			<div class="row">
				<input type="password" name="memberPw" placeholder="Pw"
					class="form-input">
			</div>

			<div class="row">
				<input type="submit" value="Login"
					class="form-btn">
			</div>
			
			<div class="row">
				<input type="text" value="아직 계정이 없으신가요?" id="goJoin">
<!-- 				<input type="button" value="회원가입" id="find"> -->
				<a href ="memberJoin.jsp">회원가입</a>
				
			</div>
		</form>
		

	</div>	<%
	if (request.getParameter("error") != null) {
	%>
	<div class="row">
		<h5 class="error">정보가 일치하지 않습니다</h5>
	</div>
	<%
	}
	%>
		<div class="row">
				<input type="button" value="challenges 란?" id="notify-btn">
				<a href ="#"></a>
		</div>		
		<div class="row">
				<input type="button" value="아이디/ 비밀번호 찾기" id="find">
				<a href ="#"></a>
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>