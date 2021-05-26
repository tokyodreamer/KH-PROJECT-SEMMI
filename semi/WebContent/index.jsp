<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<h2>인덱스</h2>


<div class="row">
<a href="<%=request.getContextPath()%>/member/myPage.jsp">마이페이지로 이동</a>
</div>

<div class="row">
<a href="<%=request.getContextPath()%>/member/myChallenge.jsp">나의 도전내역으로 이동</a>
</div>

<div class="row">
기능3
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>