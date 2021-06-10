<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/index.css">
	<div class="index-container-float">
		<div class="index-explain">
			<div class="index-explain-title">
				더 챌린지란?
			</div>
			<div class="index-explain-content-01">
				자신의 의지보다 반드시 해내야 되는 환경에 주목하여
			</div>
			<div class="index-explain-content-02">
				스스로 돈을 걸어 도전하거나 후원을 통해 도전해 나가는
			</div>
			<div class="index-explain-content-03">
				목표달성 웹사이트 <span>더 챌린지</span> 입니다
			</div>
		</div>
		<div class="index-image">
			<img alt="도전" src="<%=request.getContextPath()%>/image/challenge.jpg" class="index-image-challenge">
		</div>
	</div>
	<div class="index-auth-title">인증 기준</div>
	<div class="index-auth-container">
		<div class="index-auth-float-left">
			<div class="index-auth-image-title">공부</div>
			<img class="index-auth-image-content" src="<%=request.getContextPath()%>/image/study.jpg" alt="공부">
		</div>
		<div class="index-auth-float-right">
			<div class="index-auth-explain-title">인증 기준</div>
			<div class="index-auth-explain-content-01">
				필수 인증 기준 : 하루 1회 사진 등록
			</div>
			<div class="index-auth-explain-content-02">
				업데이트 예정
			</div>
		</div>
	</div> 
	<div class="index-auth-container">
		<div class="index-auth-float-left">
			<div class="index-auth-explain-title">인증 기준</div>
			<div class="index-auth-explain-content-01">
				필수 인증 기준 : 하루 1회 사진 등록
			</div>
			<div class="index-auth-explain-content-02">
				업데이트 예정
			</div>
		</div>
		<div class="index-auth-float-right">
			<div class="index-auth-image-title">운동</div>
			<img class="index-auth-image-content" alt="운동" src="<%=request.getContextPath()%>/image/exercise.jpg">
		</div>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>