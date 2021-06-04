<%@page import="semi.reply.beans.ReplyListDto"%>
<%@page import="semi.reply.beans.ReplyListDao"%>
<%@page import="java.util.List"%>
<%@page import="semi.reply.beans.ReplyDto"%>
<%@page import="semi.reply.beans.ReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));
	int memberNo = (int)session.getAttribute("memberNo");
	String root = request.getContextPath();
	
	//- 기존 방식 : 회원 닉네임을 불러올 수 없음
	//ReplyDao replyDao = new ReplyDao();
	//List<ReplyDto> replyList = replyDao.list(challengeNo);
	
	//- 변경 방식 : 회원 닉네임을 join 을 통해 불러옴
	ReplyListDao replyListDao = new ReplyListDao();
	List<ReplyListDto> replyList = replyListDao.list(challengeNo);

%>
	<style>
	
	textarea.form-input {
	resize: vertical;
	min-height: 100px; /*수치는 자유롭게 설정*/
	height: 100px; /*수치는 자유롭게 설정*/
	max-height: 500px; /*수치는 자유롭게 설정*/
	}	
	
	.form-btn.form-btn-normal:hover {
	background-color: rgba(3, 199, 90, 0.12);
	color:#009f47;
	border: 1px solid gray;
	font-weight: bold;
	cursor: pointer;
	}
	
	.reply-display{
	padding-left:10px; 
	}
	
	#list-time{
	font-size:12px; 
	color: #979797;
	}
	
	#list-nick{
	font-size:14px; 
	font-weight: bold;
	}
	
	#list-content{
	margin: 2px 0px; 
	font-size:14px;
	}
	
	.reply-list{
	margin-left: 5%;
	}
	
	#board_reply{
	width:80%; 
	margin-left:5%; 
	margin-top:20px;
	}
	.reply-edit-btn{
	text-decoration: underline; 
	cursor: pointer; 
	color:blue;
	}
	
	.reply-delete-btn{
	padding-right: 20px;
	}
	</style>
	
	
	<script>
	$(function(){
		$(".reply-delete-btn").click(function(e){
			var choice = confirm("댓글을 삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}		
		});
		
		$(".check-insert").submit(function(){
			alert("댓글이 등록되었습니다.");	
		});
	});
	
	//목표 : 수정버튼을 누르면 댓글 수정영역을 표시, 작성 취소를 누르면 댓글 수정영역을 숨김
	$(function(){
		
		$(".reply-edit-area").hide();//처음에 모든 수정 영역을 숨김
		
		$(".reply-edit-btn").click(function(){
			//표시 영역 : 수정 버튼(this) 기준으로 위로 두번 뒤로 한번 이동하면 나온다
			//수정 영역 : 수정 버튼(this) 기준으로 위로 두번 뒤로 두번 이동하면 나온다
			$(this).parent().parent().next().hide();
			$(this).parent().parent().next().next().show();
		});
		
		$(".reply-edit-cancel-btn").click(function(){
			//표시 영역 : 수정취소 버튼(this) 기준으로 위로 두번 앞으로 한번 이동하면 나온다
			//수정 영역 : 수정취소 버튼(this) 기준으로 위로 두번 이동하면 나온다
			$(this).parent().parent().prev().show();
			$(this).parent().parent().hide();
		});
	});
	
	</script>

		<!-- 
		댓글 목록 영역
	 -->
<div class="container-1500" ">
	<div class="row text-left reply-list">
		<h3>댓글</h3>
	</div>
	<div id="board_reply">

	<hr>
	<%for(ReplyListDto replyListDto : replyList) { %>
	<div class="row text-left">
		<div class="float-container">
			<div class="left reply-display" id="list-nick"><%=replyListDto.getMemberNick()%></div>
			<!-- 
				수정과 삭제 메뉴는 "본인 글"에만 표시되어야 한다
				= 본인글 : 댓글작성자번호(replyDto.getReplyWriter()) == 로그인된 회원번호(memberNo) 
			-->
			<%if(replyListDto.getReplyWriter() == memberNo){ %>
			<div class="right">
				<a class="reply-edit-btn">수정</a> 
				<a class="reply-delete-btn" href="<%=root%>/reply/replyDelete.kh?replyNo=<%=replyListDto.getReplyNo()%>&replyOrigin=<%=challengeNo%>">삭제</a>
			</div>
			<%} %>
		</div>
		<!-- 화면 표시 댓글 -->
		<div class="reply-display-area reply-display">
			<pre id="list-content"><%=replyListDto.getReplyContent()%></pre>
		</div>
		<!-- 
			댓글 수정 영역 : 게시글번호(hidden), 댓글번호(hidden), 댓글내용(textarea)
			= 이 영역은 "나의 댓글" 일 경우에만 출력되어야 한다.
			= 나의 댓글 판정 : 회원번호(memberNo) == 댓글작성자번호(replyDto.getReplyWriter()) 
		-->
		<%if(memberNo == replyListDto.getReplyWriter()){ %>
		<div class="reply-edit-area">
			<form action="<%=root%>/reply/replyEdit.kh" method="post" class="check-insert">
				<input type="hidden" name="replyNo" value="<%=replyListDto.getReplyNo()%>">
				<input type="hidden" name="replyOrigin" value="<%=replyListDto.getReplyOrigin()%>">
				
				<textarea name="replyContent" required><%=replyListDto.getReplyContent()%></textarea>
				<input type="submit" value="댓글 수정">		
				<input type="button" value="작성 취소" class="reply-edit-cancel-btn">		
			</form>
		</div>
		<%} %>
		<div class= "reply-display" id="list-time"><%=replyListDto.getReplyTime().toLocaleString()%></div>
		<hr>
	</div>
	<%} %>
	
	
		<!-- 
			댓글 작성 영역 : 게시글번호(replyOrigin), 댓글내용(replyContent)로 전송
		 -->
	<form action="<%=root%>/reply/replyInsert.kh" method="post" class="check-insert">
		<input type="hidden" name="replyOrigin" value="<%=challengeNo%>">
		
		<div class="row">
			<textarea name="replyContent" placeholder="댓글을 남겨보세요" class="form-input" required></textarea>
		</div>
		<div class="row">
			<input type="submit" value="댓글 작성" class="form-btn form-btn-normal">
		</div>
	</form>
</div>
</div>