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
System.out.println(authNo);
AuthDao authDao = new AuthDao();
AuthDto authDto = authDao.get(authNo);

MemberDao memberDao = new MemberDao();
ChallengeDao challengeDao = new ChallengeDao();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-600">
	
	<div class="link-btn"> <a href="authList.jsp"> 인증 리스트로 돌아가기</a> </div>
	<div class="row" > 인증 번호: <%=authDto.getAuthNo()%> </div>
	<div class="row" > 인증 제목: <%=authDto.getAuthTitle()%> </div>
	 
	 
	<div class="row"> 작성자 번호: <%=authDto.getAuthWriter()%> </div>
	<div class="row"> 작성자 아이디: 
	<% MemberDto memberDto = memberDao.find((int)authDto.getAuthNo());%>
	<%=memberDto.getMemberId() %>
	</div>
	
	
	<div class="row"> 인증 내용:  <%=authDto.getAuthContent()%></div>
	<div class="row">  인증 날짜: <%=authDto.getAuthTimeLine()%></div>
	<form action="authResultChange.kh" method="post">
	<div class="row"> 인증 처리 여부:  <%=authDto.getAuthResult()%>
		<label style="color:blue"> <input type="radio" name="authResult" required>인증 인정O: </label>
		<label style="color:red"> <input type="radio" name="authResult" required> 인증 불인정X: </label> <br>
	</div>
	<div class="row"in>
	인증 처리 사유: 
	<input type="text" name="authReason" value="<%=authDto.getAuthReason()%>" style="width:100%;" class="form-input" required >
	<input type="submit" value="인증 처리 여뷰 + 이유 저장" class="form-btn ">
	</div>
	</form>

	<% 
	ChallengeDto challengeDto = challengeDao.getChallenge((int)authDto.getAuthNo());
	%>
		private int challengeNo;
	private int challengeWriter; // FK : memberNo
	private int categoryNo; // FK : categoryNo -> categoryType
	private String challengeTitle;
	private int challengePushPoint;
	private String challengeStartDate;
	private String challengeEndDate;
	private int challengePercent;
	private int challengeReward;
	private int challengeDonate;
	private String challengeContent;
	
	<div class="row">
	계시글 제목: <%=challengeDto.getChallengeTitle() %>
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	<div class="row">
	계시글 제목: 
	</div>
	

</div>




<jsp:include page="/template/footer.jsp"></jsp:include>