<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<style>
	.edit_btn{
		background : grey;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
	}
	.login_title{
		background : black;
		color : white;
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
	}
	
	</style>
	
		<div class="container-400">
	
			<div class="row">
				<div class="login_title">비밀번호 변경</div>
			</div>
			
			<form action="editPw.kh" method="post">
				<div class="row">
					<input type="password" name="nowPw" placeholder="현재 비밀번호" required
							class="form-input form-input-underline">
				</div>
				<div class="row">
					<input type="password" name="newPw" placeholder="변경할 비밀번호" required
							class="form-input form-input-underline">
				</div>
				<div class="row">
					<input type="submit" value="변경하기" class="form-btn edit_btn">
				</div>
				
				<!-- 오류인 상황에는 오류 메세지를 추가해준다 -->
				<%if(request.getParameter("error") != null){ %>
				<div class="row">
					<h5 class="error">정보가 일치하지 않습니다</h5>
				</div>
				<%} %>
			</form>
		</div>
		

	<jsp:include page="/template/footer.jsp"></jsp:include>