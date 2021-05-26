<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<h2>인덱스</h2>
<a href="<%=request.getContextPath()%>/member/memberLogin.jsp">로그인</a>
<!-- 도전글 이동 : 세션 추가되면 삭제 예정-->
<a href="<%=request.getContextPath() %>/challenge/challengeList.jsp">도전글 목록</a>
<h2>세션 값 : <%=session.getAttribute("memberNo") %></h2>
<jsp:include page="/template/footer.jsp"></jsp:include>