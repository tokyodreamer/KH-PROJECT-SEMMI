<%@page import="semi.member.beans.MemberDto"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.challenge.beans.ChallengeListDto"%>
<%@page import="semi.challenge.beans.ChallengeListDao"%>
<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int memberNo = (int)session.getAttribute("memberNo");
	ChallengeDao challengeDao = new ChallengeDao();
	List<ChallengeDto> challengeList;
	challengeList = challengeDao.myList(memberNo);
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
						<th>번호</th>
						<th width="100px">작성자</th>
<!-- 						<th width="100px">카테고리</th> -->
						<th>제목</th>
						<th>참가비</th>
						<th width="10%">도전 시작일</th>
						<th width="10%">도전 종료일</th>
						<th>달성률</th>
						<th>상금</th>
						<th>누적후원금</th>
						
					</tr>
			</thead>
			
			<tbody>
					<%for(ChallengeDto challengeDto : challengeList){ %>
					<tr>
						<td><%=challengeDto.getChallengeNo() %></td>
						<td><%=challengeDto.getChallengeWriter() %></td>
<%-- 						<td><%=challengeDto.getCategoryNo() %></td> --%>
			
						<td class="abc" onClick="location.href='#'">
						
							<!-- 제목을 누르면 상세보기 페이지로 이동 -->
							<a href="#">
							<%=challengeDto.getChallengeTitle() %></a>
						</td>
						<td><%=challengeDto.getChallengePushPoint() %>원</td>
						<td><%=challengeDto.getChallengeStartDate().substring(0,10) %></td>
						<td><%=challengeDto.getChallengeEndDate().substring(0,10) %></td>
						<td><%=challengeDto.getChallengePercent() %>%</td>
						<td><%=challengeDto.getChallengeReward() %>원</td>
						<td><%=challengeDto.getChallengeDonate() %>원</td>
					</tr>
					<%} %>
			</tbody>
		</table>
		
	</div>
	
	<div class="bb">
	
		<div class="abcd right" onclick="location.href='myPage.jsp'">마이페이지</div>
		<div class="abcd right" onclick="location.href='#'">도전게시글</div>
		<div class="wall"></div>
	
	</div>
	
	
	

	

<jsp:include page="/template/footer.jsp"></jsp:include>