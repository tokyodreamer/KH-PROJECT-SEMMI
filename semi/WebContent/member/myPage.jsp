<%@page import="semi.challenge.beans.ChallengeDto"%>
<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@page import="semi.member.beans.MemberDao"%>
<%@page import="semi.member.beans.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<jsp:include page="/template/header.jsp"></jsp:include>
	
	<%
		Integer memberNo = (Integer)session.getAttribute("memberNo");
		MemberDao memberDao = new MemberDao(); 
		MemberDto memberDto = memberDao.find(memberNo);
		int memberPoint= memberDto.getMemberPoint();
		int writerCheck;
		String writerTitle;
		try{
			
			ChallengeDao challengeDao = new ChallengeDao();
			ChallengeDto challengeDto = challengeDao.find(memberNo);
			writerCheck= challengeDto.getChallengeWriter();
			writerTitle= challengeDto.getChallengeTitle();
			
		}catch(Exception e){
			writerCheck = 0;
			writerTitle = "";
		}
	%>	
	<style>
		.myPage_div{
			width: 800px;
			margin : auto;
		}
		.myPage_box{
			min-height : 200px;
			width : 40%;
			margin: 20px 20px;
			border: 1px solid orange;
			border-radius: 2px;
			background : ivory;
		}
		.left{
			float : left;
		
		}
		.right{
			float : right;
		}
		.wall{
			clear : both;
		}
		.first_box{
			width : 45%;
		}
		.member_exit{
			text-align : right;
		}
		.member_exit:hover{
			background : silver;
			color : red;
		}

		
		.second_box{
			display : inline-block;
			width : 45%;
			height : 130px;
			margin-left : 10px;
			font-size : 30px;
		}
		.second_box:hover{
			background : yellow;
			color : blue;
		}
		.h4_in1{
			text-align : center;
			margin-top : 12px;
			margin-bottom : 12px;
		}
		.h4_in2{
			text-align : center;
			margin-top : 34px;
			margin-bottom : 34px;
			
		}
		.third_box{
			text-align : right;
		}
		.third_box:hover{
			background : yellow;
			color : blue;
		}

	</style>
	<div class="myPage_div">
	
		<!-- 첫번째 상자 -->
		<div class="myPage_box left">
			<h3>챌린저스 프로필</h3>
			<div class="first_box left">
					
				<%if(memberPoint <=100000) { %>
				<img src="https://via.placeholder.com/100x50.png?text=B" >
				<%} else if(memberPoint <=200000) { %>
				<img src="https://via.placeholder.com/100x100.png?text=S" >
				<%} else { %>
				프로필
				<%} %>
			</div>
			<div class="first_box right">
				<div>닉네임 <%=memberDto.getMemberNick()%></div>
				<hr>
				<div>포인트 <%=memberDto.getMemberPoint() %> </div>
			 </div>
			<div class="wall"></div>
				
					
			<div class="member_exit" onclick="location.href='#'" style="cursor:pointer;">회원탈퇴</div>
			
		</div>
		
		<!-- 두번째 상자 -->
		<div class="myPage_box left">
			<h3>회원정보 변경</h3>
			<div class="second_box" onclick="location.href='editMember.jsp'" style="cursor:pointer;">
				회원정보 수정
			</div>
			<div class="second_box" onclick="location.href='editPw.jsp'" style="cursor:pointer;">
				비밀번호 변경
			</div>
		</div>
 
 
		<!-- 세번째 상자 -->
		<div class="myPage_box left">
			<h3>내 챌린저스 도전</h3>
			<div>
			
			<%if(writerCheck == memberNo) { %><br>
				<h4 class="h4_in1">현재 작성중 도전글 존재</h4>
				<div class="third_box">도전중 게시글 제목 : <a href="#"><%=writerTitle %></a></div>				
				<div class="third_box"onclick="location.href='myChallenge.jsp'" style="cursor:pointer;">
					내 챌린저스 목록
				</div>
				<div class="third_box"onclick="location.href='#'" style="cursor:pointer;">
					전체 챌린저스 목록
				</div>
			<%} else { %>
				<h4 class="h4_in2">현재 작성중인 도전글이 없습니다.</h4>
				<div class="third_box"onclick="location.href='myChallenge.jsp'" style="cursor:pointer;">
					내 챌린저스 목록
				</div>
				<div class="third_box"onclick="location.href='#'" style="cursor:pointer;">
					전체 챌린저스 목록
				</div>
			<%} %>
			
			
			</div>
		</div>
		<!-- 흠 -->
		<!-- 네번째 상자 -->
		<div class="myPage_box left">
			<h3>내 후원</h3>
			<div>
				<h4 style="text-align:center">현재 후원중 게시글 수 : </h4>
				<div class="third_box"onclick="location.href='#'" style="cursor:pointer;">
					<h4>내 후원 목록 바로 가기</h4>
				</div>
			
			</div>

		</div>
		<div class="wall"></div>
	</div>		

	<jsp:include page="/template/footer.jsp"></jsp:include>