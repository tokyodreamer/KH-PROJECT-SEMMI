<%@page import="semi.auth.beans.AuthListDto"%>
<%@page import="semi.auth.beans.AuthListDao"%>
<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.auth.beans.AuthDto"%>
<%@page import="semi.auth.beans.AuthDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
int authNo = Integer.parseInt(request.getParameter("authNo"));
//AuthDao authDao = new AuthDao();
//AuthDto authDto = authDao.get(authNo);

//추가 : 관리자만 인증 처리여부를 수정할 수 있도록 권한 부여(2021/06/01 작성 자 : 박민웅)
Integer adminNo = (Integer)session.getAttribute("adminNo");
System.out.println(adminNo);

Integer memberNo = (Integer)session.getAttribute("memberNo");
System.out.println(memberNo);


//수정 member_nick까지 입력을 위해
AuthListDao authListDao = new AuthListDao();
AuthListDto authListDto = authListDao.get(authNo);

ChallengeDao challengeDao = new ChallengeDao();
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
	.table {
	border-collapse: collapse;
	border-top: 0.5px solid rgb(51,51,51);
	}
	
	#form-list th {
		border-bottom: 1px solid #ddd;
		background-color: rgb(242, 245, 249);
		font-weight: normal;
		font-size: 14px;
	}
	#form-list td{
		border-bottom: 1px solid #ddd;
	}

	.form-input {
	border: 1px solid #ddd;
	margin-bottom: 10px;
	margin-top:10px;
	}	
</style>

<script>
	$(function(){
		$(".delete-btn").click(function(e){
			var choice = confirm("삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});
</script>


<div class="container-600">
	<div class="row">
		<h2>인증글 상세 보기</h2>
	</div>
	<div class="row">
		<img src="authDetail.kh?authNo=<%=authNo%>" width="100%" height="400">
	</div>

<div class="row">
	<table class="table" id="form-list">
		<tbody>
			<tr>
				<th width="25%">인증 번호</th>
				<td><%=authListDto.getAuthNo()%></td>
			</tr>
			
			<tr>
				<th>인증 제목</th>
				<td><%=authListDto.getAuthTitle()%></td>
			</tr>
			
			<tr>
				<th>작 성 자</th>
				<td><%=authListDto.getMemberNick()%></td>
				<%-- 작성자 아이디: <%=memberDto.getMemberId()%> --%>
			</tr>
			
			<tr>
				<th>인증 내용</th>
				<td>
					<pre><%=authListDto.getAuthContent()%></pre>
				</td>
			</tr>
			
			<tr>
				<th>인증 날짜</th>
				<td><%=authListDto.getAuthTimeLine()%></td>
			</tr>
	
			<tr>
			
		<form action="resultChange.kh" method="post">
			<input type="hidden" value=<%=authNo %> name=authNo>
				<th>인증 처리 여부</th>
				<td>
				<%if(authListDto.getAuthResult().equals("N")){%>
				<span style="font-weight: bold;">승인 대기중</span>
				<%} else if(authListDto.getAuthResult().equals("D")){%>
				<span style="font-weight: bold; color: red;">승인 거절</span>
				<%} else {%>
				<span style="font-weight: bold; color: blue;">승인 완료</span>
				<%} %>
				
				<%if(adminNo != null){ %>
				<label style="color:blue"> <input value="S" type="radio" name="authResult" required>인증 승인 O </label>
				<label style="color:red"> <input value="D" type="radio" name="authResult" required>인증 거절 X </label> <br>
				<%} %>
				</td>
			</tr>
			
			<tr>
				<th>인증 처리 사유</th>
				<td><%=authListDto.getAuthReason()%></td>	
			</tr>
			
		</tbody>
	</table>
</div>
		<%if(adminNo != null){%>
		<div class="row">
			인증 처리 사유
			<input type="text" name="authReason" value="<%=authListDto.getAuthReason()%>" class="form-input" required >
			<input type="submit" value="인증 처리 사유 등록" class="form-btn form-btn-positive">
		</div>
		<%} %>
</form>
	
	<div class="row">
		 <!-- 본인 및 관리자에게만 글 삭제가 가능하도록 설정 -->
		<%if(adminNo != null || memberNo == authListDto.getAuthWriter()) { %>
		<a href="<%=request.getContextPath()%>/auth/authDelete.kh?authNo=<%=authNo %>" class="ex-btn delete-btn">삭제</a>
		<%} %>
		<a href="authList.jsp" class="ex-btn">목록</a>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>