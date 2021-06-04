<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    	<jsp:include page="/template/header.jsp"></jsp:include>

<style>
.exitMsg{
		
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
	}

.byeMsg{
font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
		font-weight: bolder;
}
.link-btn.cancle{
	display: inline-block;
	padding: 0.75rem;
	padding-left: 4rem;
	padding-right:4rem;
	border: 2px solid black ;
	text-decoration: none;
	border-radius: 1.5rem;
	margin-left:25px;
	margin-right:25px;
	background-color: white;
	color:black;
	font-size: 20px;
	text-align: center;
}
</style>


		<div class="container-600">
			<div class="row">
			
			<div class="exitMsg">탈퇴가 완료되었습니다	</div>
			<br><br><br>
				<div class="byeMsg">그동안 이용해주셔서 감사합니다</div>
			</div>

			<br><br>
			<div class="row text-center">
				<a href="<%=request.getContextPath() %>/index.jsp" class="link-btn cancle">메인으로</a>
			</div>



		</div>
    	<jsp:include page="/template/footer.jsp"></jsp:include>