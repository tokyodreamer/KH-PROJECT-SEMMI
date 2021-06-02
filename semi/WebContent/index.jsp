<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row">
	<a href="<%=request.getContextPath()%>/intro/intro.jsp">챌린저스 소개</a>
</div>

<div class="row">
	<a href="<%=request.getContextPath()%>/member/memberJoin.jsp">회원가입</a>
</div>

<div class="row">
	<a href="<%=request.getContextPath()%>/review/reviewList.jsp">후기 게시판</a>
</div>

<h2>회원 세션 값 : <%=session.getAttribute("memberNo") %></h2>
<h2>관리자 세션 값 : <%=session.getAttribute("adminNo") %></h2>
<jsp:include page="/template/footer.jsp"></jsp:include>