<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<%
		String pw = (String)request.getSession().getAttribute("pw");
	%>
		<script>
			alert("고객님의 비밀번호는<%=pw%>입니다.");
			location="memberLogin.jsp";
		</script>
		
		

	<jsp:include page="/template/footer.jsp"></jsp:include>