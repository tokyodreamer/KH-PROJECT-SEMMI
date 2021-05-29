<%@page import="semi.challenge.beans.ChallengeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	ChallengeDao challengeDao = new ChallengeDao();
 	
 	int checkMemberPoint = challengeDao.checkMemberPoint((int) request.getSession().getAttribute("memberNo"));
 %>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		//제이쿼리 구현 예정 : ~ 2021.05.30 까지
		
		// 등록시점 제어
		
		// 시작일 : 현재 날짜보다 지난 날짜는 비활성화 (완료)
			$("#startDate").attr('min', new Date().toISOString().substring(0, 10));
		
		// 검사 스크립트
		$(".join-form").submit(function(){
			
			// 1. 참가비 검사
			if($("#pushPoint").val() > <%= checkMemberPoint %>) {
				window.alert("참가비 부족");
			} 
			
			
			// 2-1. 참가 등록일 검사 : 현재 날짜를 기준점으로 입력한 시작일이 더 작다면 (= 현재 날짜 이전부터 등록일을 하려 하면)
				
			// 2-2. 참가 종료일 검사 : 현재 날짜를 기준점으로 입력한 종료일이 더 작다면 (= 현재 날짜 이전부터 종료일을 하려 하면)
			
			// 2-3. 시작일과 종료일 검사 I : 시작일이 종료일 이후에 입력이 된다면 (= 시작일보다 종료일이 더 크다면 / ex. 21-05-28 ~ 21.05.27 (X) )
			
			// 2-4. 시작일과 종료일 검사 II : 종료일이 시작일 이전에 입력이 된다면 (= 시작일보다 종료일이 더 크다면 / ex. 21-05-28 ~ 21.05.27 (X) )
			
		});
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
		<div class="selectbox">
			<select id="ex_select" name="categoryNo">
				<option selected>참가종목 선택</option>
				<option value="1">운동</option>
				<option value="2">공부</option>
			</select>
		</div>
		<div class="row text-left">
			<label for="pushPoint">참가비</label>
			<input type="number" class="form-input" name="challengePushPoint" id="pushPoint" required>
		</div>
		<div class="row text-left">
			<label for="startDate">시작일</label>
			<input type="date" class="form-input" name="challengeStartDate" id="startDate"  min="" required >
		</div>
		<div class="row text-left">
			<label for="endDate">종료일</label>
			<input type="date" class="form-input" name="challengeEndDate" id="endDate" required>
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