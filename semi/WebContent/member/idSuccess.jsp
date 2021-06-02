<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	<%
		String id = (String)request.getSession().getAttribute("id");
	%>
	<script>
		alert("고객님의 아이디는<%=id%>입니다.");
		location="memberLogin.jsp";
	</script>

	<jsp:include page="/template/footer.jsp"></jsp:include>