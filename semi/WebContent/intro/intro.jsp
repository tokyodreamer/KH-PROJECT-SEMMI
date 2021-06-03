<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>

<style>
.joinMsg{
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
		font-weight: bolder;
	}

</style>


	<div class="container-600">
		<div class="row text-center">
		<div class="joinMsg">챌린저스를 소개합니다! </div>
		</div>

<br>

	<div class="row text-center">
		<img src="<%=request.getContextPath()%>/image/Can.png" class="intro" >
	</div>
		
		
	</div>
    <jsp:include page="/template/footer.jsp"></jsp:include>