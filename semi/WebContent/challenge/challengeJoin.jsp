<%@page import="semi.member.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	MemberDao memberDao = new MemberDao();
 	
 	int checkMemberPoint = memberDao.find((int) request.getSession().getAttribute("memberNo")).getMemberPoint();
 %>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	/* 참가비 실패 메세지 (완료) */
	.fail-message {
		display: none;
		color: red;
		font-size: 20px;
		font-weight: bold;
	}
	
	.fail-message.fail-message-01 {
		display: none;
		color: red;
		font-size: 20px;
		font-weight: bold;
	}
	
	.fail-message.fail-message-02 {
		display: none;
		color: red;
		font-size: 20px;
		font-weight: bold;
	}
	
	.fail-message.fail-message-03 {
		display: none;
		color: red;
		font-size: 20px;
		font-weight: bold;
	}
	
	/* 참가비 성공 메세지 (완료)  */
	.success-message {
		display: none;
		color: green;
		font-size: 20px;
		font-weight: bold;
	}
	
	/*도전하기 입력 칸 (완료)*/
	.join-input {
		width: 100%;
		padding: 1rem;
		outline: none;
	}

	.join-input.join-input-underline {
		border: none;
		font-size: 20px;
		font-weight:bold;
	}
	
	.join-input.join-input-underline:focus {
		border-bottom: 3px solid black;
		border-bottom-color: black;
	}
	
	/*참가비 입력 칸 (완료) */
	.join-point {
		width: 70%;
		padding: 1rem;
		outline: none;
	}

	.join-point.join-point-underline {
		border: none;
		font-size: 20px;
		font-weight:bold;
	}
	
	.join-point.join-point-underline:focus {
		border-bottom: 3px solid black;
		border-bottom-color: black;
	}
	.join-input.join-input-inline {
		width: auto;
	}
	
	/* 참가비 안내 칸 (완료)*/
	.join-span {
		font-size: 20px;
		font-weight: bold;
	}
	
	/* 도전하기 내용 */
	.join-textarea {
		resize:none;
		border: none;
		border-bottom: 3px solid black;
		border-bottom-color: black;
		font-size: 20px;
		font-weight: bold;
	}
	
	/* 도전하기 라벨 (완료) */
	.join-label {
		font-size: 25px;
		font-weight:bold;
	}
		
	/* 도전하기 버튼 (완료)*/
	.join-btn {
		margin-top: 20px;
		margin-left:15%;
		width: 30%;
		border: none;
		background-color: black;
		color: white;
		height: 50px;
		font-size: 20px;
		font-weight: bold;
	}
	
	/* 도전하기 버튼 : HOVER (완료)*/
	.join-btn:hover {
		background-color: rgb(46, 163, 79);
		color: white;
	}
	
	/* 목록 버튼 (완료) */
	.join-btn.join-btn-list {
		margin-left: 10%;
		width: 30%;
		background-color: white;
		color: black;
		border: 1px solid black;
		height: 50px;
		font-size: 20px;
		font-weight: bold;
	}
	
	/* 목록 버튼 : HOVER (완료) */
	.join-btn.join-btn-list:hover {
		background-color: lightgrey;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 제이쿼리 구현 예정 : ~ 2021.05.30 까지 (1차 완료 / 2차 : 06.03 ~06.04 전체 테스트 시 확인 예정)
		
		// 등록시점 제어
		
		// 시작일 : 현재 날짜보다 지난 날짜는 비활성화 (완료)
		$("#startDate").attr('min', new Date().toISOString().substring(0, 10));
		
		// 시작일 : 현재 날짜에서 일주일 이내만 선택 가능 (완료)
		$("#startDate").attr('max', new Date(Date.parse(new Date()) + 7 * 1000 * 60 * 60 * 24).toISOString().substring(0, 10));
		
		// 종료일 : 
		$("#endDate").on("focus", function(){
			// 제어 : 시작일이 입력되어 있지 않다면 메세지 출력 (완료)
			if($("#startDate").val() == ""){
				$(this).nextAll(".fail-message-04").show();
				$("#startDate").focus();
			} else {
				$(this).nextAll(".fail-message-04").hide();
			}
			
			// 종료일 : 시작일을 기준으로 지난 날짜는 비활성화 (완료)
			$("#endDate").attr('min', $("#startDate").val());
			
			// 종료일 : 시작일을 기준으로 100일까지 선택 가능 (완료) : 회의 필요!
			$("#endDate").attr('max', new Date(Date.parse($("#startDate").val()) + 100 * 1000 * 60 * 60 * 24).toISOString().substring(0, 10));
		});
		
		// 참가비 : 
		$("#pushPoint").on("blur", function(){
			// 제어 : 최소 1만 포인트 부터 입력 가능 (완료)
			if($(this).val() < 10000) {
				$(this).nextAll(".success-message").hide();
				$(this).nextAll(".fail-message-02").hide();
				$(this).nextAll(".fail-message-03").hide();
				$(this).nextAll(".fail-message-01").show();
				$("#pushPoint").val(10000);
				$("#pushPoint").focus();
			} 
			// 제어 : 보유 포인트가 20만 포인트 이하인 회원이 보유 포인트보다 많은 참가비를 입력하였을 때 안내 (완료)
			else if($(this).val() > <%=checkMemberPoint%> && <%=checkMemberPoint%> < 200000){
				$(this).nextAll(".success-message").hide();
				$(this).nextAll(".fail-message-01").hide();
				$(this).nextAll(".fail-message-03").hide();
				$(this).nextAll(".fail-message-02").show();
				$("#pushPoint").val(<%=checkMemberPoint%>);
				$("#pushPoint").focus();
			}
			// 제어 : 최대 20만 포인트 까지 입력 가능 (완료)
			else if($(this).val() > 200000){
				$(this).nextAll(".success-message").hide();
				$(this).nextAll(".fail-message-01").hide();
				$(this).nextAll(".fail-message-02").hide();
				$(this).nextAll(".fail-message-03").show();
				$("#pushPoint").val(200000);
				$("#pushPoint").focus();
			} else {
				$(this).nextAll(".fail-message").hide();
				$(this).nextAll(".success-message").show();
			}
		});
		
		// 서블릿으로 넘어가기 전에 검사 (완료)
		$(".join-form").submit(function(e){
				// 종료일이 시작일보다 빠르면 서블릿 전송 취소 (완료)
				if(new Date($("#endDate").val()) < new Date($("#startDate").val())) {
					window.alert("참가종료 날짜를 다시 선택해 주세요");
					e.preventDefault();
					$("#endDate").focus();
				}
				
		});
		
		// Q : 시작일 외에 다른 항목을 입력하거나 커서를 이동한 상태에서도 종료일은 계속 시작일을 향하고 있어야 하는데 ? (미처리)
		
		// 목록 페이지 이동 (완료)
		$("#list").click(function(e){
			e.preventDefault();
			location.href="<%=request.getContextPath()%>/challenge/challengeList.jsp";
		});
		
	});
</script>
<div class="container-600">
	<div class="row">
		<h2>도전글 작성 게시판 (임시 템플릿)</h2>
	</div>
	<form action="challengeJoin.kh" method="post" class="join-form">
		<div class="row text-left">
			<label for="title" class="join-label">제목</label><br><br>
			<input type="text" class="join-input join-input-underline" name="challengeTitle" placeholder="도전글 제목" id="title" required>
		</div>
		<br>
		<div class="row ">
			<label for="category" class="join-label">유형</label><br><br>
			<select id="category" name="categoryNo" required>
				<option selected>유형 선택</option>
				<option value="1">운동</option>
				<option value="2">공부</option>
			</select>
		</div>
		<br>
		<div class="row text-left">
			<label for="startDate" class="join-label">시작일</label><br><br>
			<input type="date" class="form-input" name="challengeStartDate" id="startDate"  required>
		</div>
		<br>
		<div class="row text-left">
			<label for="endDate" class="join-label">종료일</label><br><br>
			<input type="date" class="form-input" name="challengeEndDate" id="endDate" required>
			<span class="fail-message">시작일을 먼저 입력해 주세요</span>
		</div>
		<br>
		<div class="row text-left">
			<label for="pushPoint" class="join-label">참가비</label><br><br>
			<span class="join-span">포인트 : </span><input type="number" class="join-point join-point-underline" name="challengePushPoint" id="pushPoint"  required>
			<br>
			<span class="fail-message fail-message-01">참가비는 10000 포인트 부터 가능합니다</span>
			<span class="fail-message fail-message-02">등록할 수 있는 참가비는 <%=checkMemberPoint%> 포인트 입니다</span>
			<span class="fail-message fail-message-03">참가비는 최대 200000 포인트까지 가능합니다</span>
			<span class="success-message">참가 가능합니다</span>
		</div>
		<br>
		<div class="row text-left">
			<label for="content" class="join-label">도전글 내용</label><br><br>
			<textarea name="challengeContent"  rows="7"  cols="100%"  id="content" class="join-textarea" required></textarea>
		</div>
		<br>
		<div class="row">
			<input type="submit" class="join-btn"  value="도전하기" >
			<button class="join-btn join-btn-list" id="list">목록</button>
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>