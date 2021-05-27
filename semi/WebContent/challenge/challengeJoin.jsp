<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		  var selectTarget = $('.selectbox select');
	
		 selectTarget.on('blur', function(){
		   $(this).parent().removeClass('focus');
		 });
	
		  selectTarget.change(function(){
		    var select_name = $(this).children('option:selected').text();
	
		  $(this).siblings('label').text(select_name);
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
			<label for="ex_select">참가종목 선택</label>
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
			<input type="date" class="form-input" name="challengeStartDate" id="startDate" required>
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