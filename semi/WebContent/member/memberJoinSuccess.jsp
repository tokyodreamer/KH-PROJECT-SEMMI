<%@page import="semi.member.beans.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDto memberDto= new MemberDto();
%>




    <jsp:include page="/template/header.jsp"></jsp:include>

<style>
.joinMsg{
		
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
	}

.welcomeMsg{
font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
		font-weight: bolder;
}
.login_btn{
		background : black;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
	}
.home-link{
background : white;
		color : black;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
		text-align: center;
}


</style>
	<div class="container-600">
		<div class="row">
		
			<div class="joinMsg">Challengers(가제)	</div>
			<br><br><br>
			<div class="welcomeMsg">"<%=(String)request.getSession().getAttribute("nick")%>" 님 회원가입을 축하드립니다</div>
		</div>
		
					<br><br>
		
	<form action="memberLogin.kh" method="post">
	
		<div class="row home-link">
			<a href="<%=request.getContextPath() %>/index.jsp" class="form-btn home-link">챌린저스 홈</a>
		</div>
		
		<br>
		
		<div>
			<input type="submit" value="LOGIN"	class="form-btn login_btn">
		</div>
		
<!-- 		<a href="memberLogin.jsp" class="link-btn">로그인하기</a> -->
		</div>
	</form>
	
	
	
	</div>






    <jsp:include page="/template/footer.jsp"></jsp:include>