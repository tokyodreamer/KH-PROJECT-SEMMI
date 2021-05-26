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



<a href="<%=request.getContextPath()%>/member/memberLogin.jsp">로그인</a>
<a href="<%=request.getContextPath() %>/member/memberJoin.jsp">회원가입</a>
<!-- 도전글 이동 : 세션 추가되면 삭제 예정-->
<a href="<%=request.getContextPath() %>/challenge/challengeList.jsp">도전글 목록</a>
<h2>세션 값 : <%=session.getAttribute("memberNo") %></h2>
>>>>>>> refs/remotes/origin/main
<jsp:include page="/template/footer.jsp"></jsp:include>