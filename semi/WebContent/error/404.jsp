<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800">
	<div class="row">
		<h2>잘못된 주소를 입력하셨습니다</h2>
	</div>
	<div class="row">
		<img alt="" src="<%=request.getContextPath()%>/image/404.jpg" width="100%" height="450">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>