<%@page import="semi.auth.beans.AuthListDto"%>
<%@page import="semi.auth.beans.AuthListDao"%>
<%@page import="java.util.List"%>
<%@page import="semi.auth.beans.AuthDto"%>
<%@page import="semi.auth.beans.AuthDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//AuthDao authDao = new AuthDao();
//List<AuthDto> authList = authDao.list();

//수정 member_nick까지 입력을 위해
AuthListDao authListDao = new AuthListDao();
List<AuthListDto> authList = authListDao.list();

int adminNo = (Integer)session.getAttribute("adminNo");
%>
<style>

.table.table-hover-title > thead > tr,		
.table.table-hover-title > tbody > tr:hover > #th-title {
	background-color:rgb(231, 241, 253);
}

table.authList th a{
display: block;
width:100%;
height:100%;
color:black;
text-decoration: none;
}


</style>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-800 ">
	<div class="row">
		<h2>인증 테이블</h2>
	</div>
	
	<div class="row">
		<table class="table table-hover-title authList">
			<thead>
				<tr>
					<th> 인증 번호 </th>
					<th> 인증 제목 </th>
					<th> 작성자 </th>
					<th> 인증 날짜 </th>
					<th> 인증 결과 </th>
				</tr>
			</thead>
			
			<tbody>
			<% for (AuthListDto authListDto : authList ) {%>
				<tr> 
					<th> <%=authListDto.getAuthNo() %> </th>
					<th id="th-title"> <a href="authDetail.jsp?authNo=<%=(int)authListDto.getAuthNo()%>"><%=authListDto.getAuthTitle() %> </a></th>
					<th> <%=authListDto.getMemberNick() %> </th>
					<th> <%=authListDto.getAuthTimeLine() %> </th>
					<th><%= authListDto.getAuthResult() %>  </th>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>
//페이지 구현
