<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>인증글 작성</h2>
	</div>
	
	<form action="authInsert.kh" method="post" enctype="multipart/form-data">
			<input type="text" name="authChallengeNo" value="<%=challengeNo%>">
			<input type="text" name="authCategoryType" value="<%=categoryNo%>">
		<div class="row">
			<label>인증 제목</label>
			<input type="text" class="form-input" name="authTitle" placeholder="인증글 제목"required>
		</div>
		
		<div class="row">
			<label>인증 내용</label>
			<textarea class="form-input" rows="" cols="" name="authContent" required></textarea>
		</div>
		
		<div class="row">
			<label>인증 사진</label>
			<input type="file" name="authFile" accept=".png, .jpg, .gif" required>
		</div>
		
		<div class="row">
			<input type="submit" value="등록" class="form-btn form-btn-positive">
		</div>	
			
		<div>
			<input type="reset" value="초기화" class="form-btn form-btn-negative">
		</div>
	
	
	</form>
</div>
	



<jsp:include page="/template/footer.jsp"></jsp:include>
