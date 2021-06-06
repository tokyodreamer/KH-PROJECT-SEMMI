<%@page import="semi.donate.beans.DonateDto"%>
<%@page import="semi.donate.beans.DonateDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@page import="semi.member.beans.MemberDao"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int memberNo = (int)session.getAttribute("memberNo");
	DonateDao donateDao = new DonateDao();
	List<DonateDto> donateList;
	donateList = donateDao.myList(memberNo);
%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<style>
	.text-deco > a{
		text-decoration: none;
		color: black;
	}
	
	.text-deco > a:hover {
		text-decoration: underline;	
	}
	.table {
	border-collapse: collapse;
	border-top: 0.5px solid rgb(51,51,51);
	}
	
	.table th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
	}
	
	.table th, .table td {
      padding: 10px;
      border-bottom: 1px solid #ddd;
    }
	
	.table.table-hover > tbody > tr:hover {
	background-color:rgb(242,242,242);
	}
	

	

	
	.abcd{
		background:black;
		color:white;
		width:100px;
		height:40px;
		text-aling :center;
		margin-left : 10px;
	}
	.abc:hover{
		background : ivory;
	}
	.abcd:hover{
		background : grey;
	}
	.left{
		float : left;
	}
	.right{
		float : right;
	}
	.wall {
		clear : both;
	}
	.bb{
		text-align : center;
	}
</style>



	<div class="row">
		<h2>도전글 목록</h2>
	</div>
	<div class="row">
		<table class="table table-border">
			<thead>
					<tr>
						<th>후원번호</th>
						<th width="100px">챌린지번호</th>
						<th>내번호</th>
						<th>내 후원금</th>
					</tr>
			</thead>
			
			<tbody>
					<%for(DonateDto donateDto : donateList){ %>
					<tr>
						<td><%=donateDto.getDonateNo() %></td>
						<td><%=donateDto.getDonateChallengeNo() %></td>
						<td><%=donateDto.getDonateMemberNo() %></td>
						<td><%=donateDto.getDonatePushPoint() %>포인트</td>
						
					</tr>
					<%} %>
			</tbody>
		</table>
		
	</div>
	
	<div class="bb">
	
		<div class="abcd right" onclick="location.href='myPage.jsp'">마이페이지</div>
		<div class="abcd right" onclick="location.href='#'">후원하러가기</div>
		<div class="wall"></div>
	
	</div>
	
	
	

	

<jsp:include page="/template/footer.jsp"></jsp:include>