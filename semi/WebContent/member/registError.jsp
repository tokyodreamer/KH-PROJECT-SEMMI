<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	<%
		String email = (String)request.getSession().getAttribute("email");
 	%> 
		<script>
			alert("동일한 아이디가 존재합니다.");
			location="memberJoin.jsp?member_email=<%=email%>";
		</script>
		
		

	<jsp:include page="/template/footer.jsp"></jsp:include>