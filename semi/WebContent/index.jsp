<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>


<div class="row">

<a href="<%=request.getContextPath()%>/member/myPage.jsp">챌린저스란?</a>

<a href="<%=request.getContextPath()%>/member/myPage.jsp">챌린저스 소개</a>
</div>
<br><br>

<div class="row">
<a href="<%=request.getContextPath()%>/member/myChallenge.jsp">회원가입</a>
</div>
<br><br>

<div class="row">
<a href="<%=request.getContextPath()%>/member/myChallenge.jsp">후기보러가기</a>

</div>
<br><br>


<%-- <a href="<%=request.getContextPath()%>/member/memberLogin.jsp">로그인</a> --%>
<%-- <a href="<%=request.getContextPath() %>/member/memberJoin.jsp">회원가입</a> --%>
<!-- <!-- 도전글 이동 : 세션 추가되면 삭제 예정--> -->
<%-- <a href="<%=request.getContextPath() %>/challenge/challengeList.jsp">도전글 목록</a> --%>
<%-- <h2>세션 값 : <%=session.getAttribute("memberNo") %></h2> --%>
<!-- >>>>>>> refs/remotes/origin/main -->
<h2>세션 값 : <%=session.getAttribute("memberNo") %></h2>


<jsp:include page="/template/footer.jsp"></jsp:include>