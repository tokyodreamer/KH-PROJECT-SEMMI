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
	
	int adminNo = (Integer)session.getAttribute("adminNo");
	
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
	
	//(2) rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	AuthListDao authListDao = new AuthListDao();
	List<AuthListDto> authList = authListDao.list(startRow, endRow);
	
	/////////////////////////////////////////////////////////////////////
	// 페이지 네비게이션 영역 계산
	/////////////////////////////////////////////////////////////////////
	// = 하단에 표시되는 숫자 링크의 범위를 페이지번호를 기준으로 계산하여 설정
	// = 하단 네비게이션 숫자는 startBlock 부터 endBlock 까지 출력
	// = (주의사항) 게시글 개수를 구해서 마지막 블록 번호를 넘어가지 않도록 처리
	//	목록조회 자바코드(검색, 목록)	
	//	ChallengeDao challengeDao = new ChallengeDao();
	int count = authListDao.getCount();
	
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
	endBlock = lastBlock;//범위를 수정
		}

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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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

		<!-- 검색화면 구현 -->
		<form class="search-form" action="authList.jsp" method="get">
			<input type="hidden" name="pageNo">
		</form>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>