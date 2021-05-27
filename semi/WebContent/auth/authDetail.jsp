<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.auth.beans.AuthDto"%>
<%@page import="semi.auth.beans.AuthDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
int authNo = Integer.parseInt(request.getParameter("authNo"));
System.out.println(authNo);
AuthDao authDao = new AuthDao();
AuthDto authDto = authDao.get(authNo);

MemberDao memberDao = new MemberDao();

%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800 ">
	<div class="row">
		<h2>인증글 상세보기</h2>
	</div>
	
	<div class="row">
		<table class="table ">
			<thead>
				<tr>
					<th> 인증 번호 </th>
					<th> 작성자 번호 </th>
					<th> 작성자 아이디</th>
					<th> 인증 제목 </th>
					<th> 인증 내용</th>
					<th> 인증 날짜 </th>
				</tr>
			</thead>
			<tbody>
				<tr> 
					<th> <%=authDto.getAuthNo() %> </th>
					<th> <%=authDto.getAuthWriter() %> </th>
					<%
					MemberDto memberDto = memberDao.find((int)authDto.getAuthWriter());
					
					%>
					<th><%=authDto.getAuthTitle() %> </th>
					<th> a</th>
					<th> <%=authDto.getAuthTimeLine() %> </th>
					<th><%= authDto.getAuthResult() %>  </th>
				</tr>
		
			</tbody>
		</table>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>
//페이지 구현