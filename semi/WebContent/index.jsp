<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>


<div class="row">
<a href="<%=request.getContextPath()%>/member/myPage.jsp">챌린저스 소개</a>
</div>
<br><br>

<div class="row">
<a href="<%=request.getContextPath()%>/member/myChallenge.jsp">회원가입</a>
</div>
<br><br>

<div class="row">
리뷰
</div>
<br><br>

<h2>세션 값 : <%=session.getAttribute("memberNo") %></h2>



<jsp:include page="/template/footer.jsp"></jsp:include>