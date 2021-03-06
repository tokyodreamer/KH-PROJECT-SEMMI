<%@page import="semi.member.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	MemberDao memberDao = new MemberDao();
 	
 	int checkMemberPoint = memberDao.find((int) request.getSession().getAttribute("memberNo")).getMemberPoint();
 %>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.success-message, .fail-message {
			display: none;
	}
	.success-message {
			color: green;
	}
	.fail-message {
			color: red;
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
				$(this).nextAll(".fail-message-01").show();
				$("#pushPoint").val(10000);
				$("#pushPoint").focus();
			} 
			// 제어 : 보유 포인트가 20만 포인트 이하인 회원이 보유 포인트보다 많은 참가비를 입력하였을 때 안내 (완료)
			else if($(this).val() > <%=checkMemberPoint%> && <%=checkMemberPoint%> < 200000){
				$(this).nextAll(".fail-message-02").show();
				$("#pushPoint").val(<%=checkMemberPoint%>);
				$("#pushPoint").focus();
			}
			// 제어 : 최대 20만 포인트 까지 입력 가능 (완료)
			else if($(this).val() > 200000){
				$(this).nextAll(".fail-message-03").show();
				$("#pushPoint").val(200000);
				$("#pushPoint").focus();
			} else {
				$(this).nextAll(".fail-message").hide();
			}
			
			
		});
		
		// 서블릿으로 넘어가기 전에 검사 (완료)
		$(".join-form").submit(function(e){
				
				// 유형이 옵션 내 값과 다르게 입력되었을 경우 서블릿 전송 취소 (완료)
				/* if(parseInt() !== 1 || $("#category").val() !== 2) {
					window.alert("선택 유형이 올바르지 않습니다");
					e.preventDefault();
					$("#category").focus();
				} */
					
				// 종료일이 시작일보다 빠르면 서블릿 전송 취소 (완료)
				if(new Date($("#endDate").val()) < new Date($("#startDate").val())) {
					window.alert("참가종료 날짜를 다시 선택해 주세요");
					e.preventDefault();
					$("#endDate").focus();
				}
		});
		
		// Q : 시작일 외에 다른 항목을 입력하거나 커서를 이동한 상태에서도 종료일은 계속 시작일을 향하고 있어야 하는데 ? (미처리)
		
	});
</script>
<div class="container-600">
	<div class="row">
		<h2>도전글 작성 게시판 (임시 템플릿)</h2>
	</div>
	<form action="challengeJoin.kh" method="post" class="join-form">
		<div class="row text-left">
			<label for="title">제목</label>
			<input type="text" class="form-input" name="challengeTitle" placeholder="도전글 제목" id="title" required>
		</div>
		<div class="row ">
			<label for="category">유형</label>
			<select id="category" name="categoryNo" required>
				<option selected>유형 선택</option>
				<option value="1">운동</option>
				<option value="2">공부</option>
			</select>
		</div>
		<div class="row text-left">
			<label for="startDate">시작일</label>
			<input type="date" class="form-input" name="challengeStartDate" id="startDate"  required>
		</div>
		<div class="row text-left">
			<label for="endDate">종료일</label>
			<input type="date" class="form-input" name="challengeEndDate" id="endDate" required>
			<span class="fail-message fail-message-04">시작일을 먼저 입력해 주세요</span>
		</div>
		<div class="row text-left">
			<label for="pushPoint">참가비</label>
			<input type="number" class="form-input" name="challengePushPoint" id="pushPoint"  required>
			<span class="fail-message fail-message-01">참가비는 10000 포인트 부터 가능합니다</span>
			<span class="fail-message fail-message-02">등록할 수 있는 참가비는 <%=checkMemberPoint%> 포인트 입니다</span>
			<span class="fail-message fail-message-03">참가비는 최대 200000 포인트까지 가능합니다</span>
		</div>
		<div class="row text-left">
			<label>도전글 내용</label>
			<textarea name="challengeContent" rows="" cols="" id="content" required></textarea>
		</div>
		<div class="row">
			<input type="submit" class="form-btn form-btn-positive"  value="도전하기" >
		</div>
		<div class="row">
			<input type="reset"  class="form-btn form-btn-negative"  value="초기화">
		</div>
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>