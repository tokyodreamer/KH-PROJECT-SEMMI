<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
//  function con(){
// 	 //회원가입 버튼을 누르면 회원가입페이지로 이동한다
// 	var btn = document.querySelector(".pop-btn");
// 	if(btn.value=="표시"){
// 		btn.type ="text";
// 	}

//  }

</script>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.login_btn{
		background : black;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
		
		
	}
	.login_user{
		text-align : center;
		padding-top: 10px;
	}
	.login_title{
		
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
	}
	.login_div {
		font-size : 17px;
		color : silver;
	}
	.login_id {
		margin-left : 20px;
	}
	.login_pw {
		margin-right : px;
	}
</style>
<div class="container-600">
	<div class="row">
		
		<div>
			<div class="login_title">LOGIN</div>
			<div class="login_btn login_user">회원</div>
		<input type="button" value="관리자" class="form-btn" onclick="location.href='<%=request.getContextPath()%>/admin/adminLogin.jsp'">
		<h2>로그인</h2>
		<hr>
		</div>
		
		<form action="memberLogin.kh" method="post">

			<div class="row">
				<input type="text" name="memberId" placeholder="아이디 또는 이메일"
					class="form-input">
			</div>

			<div class="row">
				<input type="password" name="memberPw" placeholder="비밀번호"
				id="input-pw" class="form-input">
				
<!-- 			<button id="input-pw-btn" class="pop-btn" onclick="con();">표시</button> -->

			</div>

			<div class="row">
				<input type="submit" value="LOGIN"
					class="form-btn login_btn">
			</div>
			<hr>
			<br>
			
		</form>
		<div class="row left" style="margin : auto">
			<div class="login_div left"onclick="location.href='memberJoin.jsp'" style="cursor:pointer;">
				회원가입 &nbsp;|&nbsp;&nbsp;</div>
			<div class="login_div left loign_id" onclick="location.href='idSearch.jsp'">아이디 찾기</div>
			<div class="login_div right" onclick="location.href='<%=request.getContextPath()%>'">&nbsp;&nbsp;챌린저스 홈</div>
			<div class="login_div right login_pw" onclick="location.href='pwSearch.jsp'"> 비밀번호 찾기&nbsp;&nbsp;|</div>
			<div class="wall"></div>
				
				
		</div>	<%
		if (request.getParameter("error") != null) {
		%>
		<div class="row">
			<h5 class="error">정보가 일치하지 않습니다</h5>
		</div>
		<%
		}
		%>
	</div>
		



</div>
<jsp:include page="/template/footer.jsp"></jsp:include>