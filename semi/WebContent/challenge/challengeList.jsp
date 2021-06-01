<%@page import="semi.challenge.beans.ChallengeListDto"%>
<%@page import="semi.challenge.beans.ChallengeListDao"%>
<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
//	1. 검색창에 required 를 설정한 경우(required 설정여부 확인할것!!!!!)
//	boolean isSearch = type != null && keyword != null;

//	2. 검색창에 required를 설정하지 않는 경우(공백을 목록으로 처리)
	boolean isSearch = type != null && keyword != null && !keyword.trim().equals("");
	
	/////////////////////////////////////////////////////////////////////////////
	//	페이지 번호를 이용한 계산 과정
	/////////////////////////////////////////////////////////////////////////////
	//(1) 페이지 번호는 있을 수도, 없을 수도 있다.
	//	- 있으면 해당 페이지 번호에 맞게 조회, 없으면 1페이지를 조회
	int pageNo;//현재 페이지 번호
	try{
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
			if(pageNo < 1){
				throw new Exception();
			}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 10;//기본값 10개
	}

//	(2) rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	ChallengeListDao challengeListDao = new ChallengeListDao();
	List<ChallengeListDto> challengeList;

	if(isSearch){
		challengeList = challengeListDao.search(type, keyword, startRow, endRow);
	}
	else{
		challengeList = challengeListDao.list(startRow, endRow);
	}
	
	/////////////////////////////////////////////////////////////////////
	// 페이지 네비게이션 영역 계산
	/////////////////////////////////////////////////////////////////////
	// = 하단에 표시되는 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정
	// = 하단 네비게이션 숫자는 startBlock 부터 endBlock 까지 출력
	// = (주의사항) 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리
	//	목록조회 자바코드(검색, 목록)	
	//	ChallengeDao challengeDao = new ChallengeDao();
	int count;
	if(isSearch){
		count = challengeListDao.getCount(type, keyword);
	}
	else{
		count = challengeListDao.getCount();
	}
	
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
// 	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>

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
	
	.subt-btn {
		display: inline-block;
		width: 56px;
    	height: 40px;
    	background-color: black;
   		border: 0;	
   		color: #fff;
   		margin-left: -6px;
   		position: relative; 
   		top: 1px;
   		cursor: pointer;
	}
	.write-btn {
	text-decoration: none;
	width : 100px;
	background-color: black;
	font-size: 15px;
	display: inline-block;
	text-align: center;
	border-radius:10px;
	color:#fff;
    padding: 10px 0;
	margin: 4px;
	cursor: pointer;
	}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


<%if(isSearch){ %>
<script>
	//서버에서 수신한 type과 keyword에 해당하는 값들을 각각의 입력창에 설정하여 유지되는것처럼 보이도록 구현
	$(function(){
		$("select[name=type]").val("<%=type%>");
		$("input[name=keyword]").val("<%=keyword%>");
	});
</script>
<%} %>

<script>
	//페이지 네비게이션에 있는 a태그를 누르면 전송하는 것이 아니라 form 내부에 값을 설정한 뒤 form을 전송
	//= 검색어, 검색분류, 페이지번호, 페이지크기까지 한 번에 전송해야 화면이 유지되기 때문
	$(function(){
		$(".pagination > a").click(function(){
			//주인공 == a태그
			var pageNo = $(this).text();
			if(pageNo == "<이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}	
			else if(pageNo == "다음>"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
			else{//숫자 링크
				$("input[name=pageNo]").val(pageNo);
				$(".search-form").submit();//강제 submit 발생
			}
		});
	});
</script>
	
	<div class="row">
		<h2>전체 도전글 보기</h2>
	</div>
	<div class="float-container">
		<div class="left" style="font-size:20x;">
			<span style="font-weight: bold; margin-right: -3px;"><%=count%></span>
			개의 글
		</div>
	</div>
<!-- <h3>pageNo = <%=pageNo%>, startRow = <%=startRow %>, endRow = <%=endRow %> </h3> -->
	<div class="row">
		<table class="table table-hover table-head">
			<thead>
					<tr>
						<th>번호</th>
						<th width="100px">작성자</th>
						<th width="100px">카테고리</th>
						<th>제목</th>
						<th>참가비</th>
						<th width="10%">도전 시작일</th>
						<th width="10%">도전 종료일</th>
						<th>달성률</th>
						<th>상금</th>
						<th width="10%">누적후원금</th>
						<th>조회수</th>
						<!-- <th>도전글내용</th> -->
					</tr>
			</thead>
			
			<tbody class = "text-center table-head">
					<%for(ChallengeListDto challengeListDto : challengeList){ %>
					<tr>
						<td><%=challengeListDto.getChallengeNo() %></td>
						<td><%=challengeListDto.getMemberNick() %></td>
						<td><%=challengeListDto.getCategorytype() %></td>
						<td class = "text-left text-deco">
							<!-- 제목을 누르면 상세보기 페이지로 이동 -->
							<a href="challengeDetail.jsp?challengeNo=<%=challengeListDto.getChallengeNo()%>">
							<%=challengeListDto.getChallengeTitle() %></a>
						</td>
						<td><%=challengeListDto.getChallengePushPoint() %>원</td>
						<td><%=challengeListDto.getChallengeStartDate().substring(0,10) %></td>
						<td><%=challengeListDto.getChallengeEndDate().substring(0,10) %></td>
						<td><%=challengeListDto.getChallengePercent() %>%</td>
						<td><%=challengeListDto.getChallengeReward() %>원</td>
						<td><%=challengeListDto.getChallengeDonate() %>원</td>
						<td><%=challengeListDto.getChallengeRead() %></td>
					</tr>
					<%} %>
			</tbody>
		</table>
	</div>
	
	<div class="row text-right">

		<a href="challengeJoin.jsp" class="write-btn">글쓰기</a>

		<a href="challengeJoin.jsp" class="ex-btn">글쓰기</a>

	</div>
	
<div class="row">
<!-- 페이지 네이게이션 자리 -->
	<div class="pagination text-center">
	
			<%if(startBlock > 1){ %>
			<a class="move-link">&lt;이전</a>
			<%} %>
			
			<%for(int i = startBlock; i <= endBlock; i++){ %>
				<%if(i == pageNo){%>
					<a class="on"><%=i %></a>
				<%}else{ %>
					<a><%=i %></a>
				<%} %>
			<%} %>
			
			<%if(endBlock < lastBlock){ %>
			<a class="move-link">다음&gt;</a>
			<%} %>
		
	</div>
</div>	
	
	
	<div class="row text-center">
	
		<!-- 검색화면 구현 -->
		<form class="search-form" action="challengeList.jsp" method="get">
			<input type="hidden" name="pageNo">
		
			<select name="type" style="height: 40px; padding : 0px 10px;">
				<option value="challenge_title">제목만</option>
				<option value="category_type">카테고리</option>
				<option value="member_nick">글작성자</option>
			</select>
		
			<input type="text" name="keyword" placeholder="검색어" style="height: 40px; padding : 0px 10px;">
		
			<input type="submit" value="검색" class="subt-btn">
		
		</form>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>