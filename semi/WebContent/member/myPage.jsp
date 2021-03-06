<%@page import="semi.donate.beans.DonateDto"%>
<%@page import="semi.donate.beans.DonateDao"%>
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
		int count;
		
		try{
			
			ChallengeDao challengeDao = new ChallengeDao();
			ChallengeDto challengeDto = challengeDao.find(memberNo);
			writerCheck= challengeDto.getChallengeWriter();
			writerTitle= challengeDto.getChallengeTitle();
			DonateDao donateDao = new DonateDao();
			DonateDto donateDto = new DonateDto();
			
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
	
		<!-- ????????? ?????? -->
		<div class="myPage_box left">
			<h3>???????????? ?????????</h3>
		
			<div class="first_box left">
					
				<%if(memberPoint <=200000) { %>
				<img src="<%=request.getContextPath() %>/image/bronze.png" style="width:100px; height:100px;" >
				<%} else if(memberPoint <=400000) { %>
				<img src="<%=request.getContextPath() %>/image/silver.JPG" style="width:100px; height:100px;" >
				<%} else if(memberPoint <=600000) { %>
				<img src="https://via.placeholder.com/100x100.png?text=G" >
				<%} else { %>
				<img src="https://via.placeholder.com/100x100.png?text=P" >
				<%} %>
			</div>
			<div class="first_box right">
				<div>????????? <%=memberDto.getMemberNick()%></div>
				<hr>
				<div>????????? <%=memberDto.getMemberPoint() %> </div>
			 </div>
			<div class="wall"></div>
				
					
			<div class="member_exit" onclick="location.href='memberExit.kh'" style="cursor:pointer;">????????????</div>
			
		</div>
		
		<!-- ????????? ?????? -->
		<div class="myPage_box left">
			<h3>???????????? ??????</h3>
			<div class="second_box" onclick="location.href='editMember.jsp'" style="cursor:pointer;">
				???????????? ??????
			</div>
			<div class="second_box" onclick="location.href='editPw.jsp'" style="cursor:pointer;">
				???????????? ??????
			</div>
		</div>
 
 
		<!-- ????????? ?????? -->
		<div class="myPage_box left">
			<h3>??? ???????????? ??????</h3>
			<div>
			
			<%if(writerCheck == memberNo) { %><br>
				<h4 class="h4_in1">?????? ????????? ????????? ??????</h4>
				<div class="third_box">????????? ????????? ?????? : <a href="#"><%=writerTitle %></a></div>				
				<div class="third_box"onclick="location.href='myChallenge.jsp'" style="cursor:pointer;">
					??? ???????????? ??????
				</div>
				<div class="third_box"onclick="location.href='#'" style="cursor:pointer;">
					?????? ???????????? ??????
				</div>
			<%} else { %>
				<h4 class="h4_in2">?????? ???????????? ???????????? ????????????.</h4>
				<div class="third_box"onclick="location.href='myChallenge.jsp'" style="cursor:pointer;">
					??? ???????????? ??????
				</div>
				<div class="third_box"onclick="location.href='#'" style="cursor:pointer;">
					?????? ???????????? ??????
				</div>
			<%} %>
			
			
			</div>
		</div>
		<!-- ??? -->
		<!-- ????????? ?????? -->
		<div class="myPage_box left">
			<h3>??? ??????</h3>
			<div>
				<h4 style="text-align:center">?????? ????????? ????????? ??? : </h4>
				<div class="third_box"onclick="location.href='myDonate.jsp'" style="cursor:pointer;">
					<h4>??? ?????? ?????? ?????? ??????</h4>
				</div>
			
			</div>

		</div>
		<div class="wall"></div>
	</div>		

	<jsp:include page="/template/footer.jsp"></jsp:include>