<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 실제 context path를 구하는 명령
	// = 템플릿 페이지의 모든 경로는 절대경로로 작성해야 한다
	String root = request.getContextPath();
	
	// 회원 로그인 판정 코드
	// 로그인 : 무슨 값이 얼마여야 하는지 정의
	// - 세션에 memberNo 가 null 이 아니면 로그인 상태로 간주
	// - 세션에 memberNo 가 null 이면 로그아웃 상태로 간주
	Integer memberNo = (Integer) session.getAttribute("memberNo");
	boolean isLogin = memberNo != null; 
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>세미 프로젝트 템플릿(임시)</title>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/test.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/menu.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">
	<style type="text/css">
	</style>
</head>
<body>
	<main>
		<header>
			<div align="right">
				<%if(isLogin) { %>
					<form method="post" action="logout.kh">
						<input type="submit" value="로그아웃">
					</form>
				<%} else { %>
					<a href="memberJoin.jsp">회원가입</a>
					<a href="memberLogin.jsp">로그인</a>
				<%} %>
			
			</div>
			<h1>Challenges</h1>
		</header>
		<nav>
			<ul class="menu">
			<li><a href="#">챌린저스란?</a>
					<ul>
						<li><a href="<%=root%>/item/itemInsert.jsp">챌린저스 소개</a></li>
						<li><a href="<%=root%>/item/itemList.jsp">챌린지 100%활용하기</a></li>
					</ul></li>
				<li><a href="#">마이페이지</a>
					<ul>
						<%if(isLogin) { %>
							<li><a href="<%=root%>/item/itemInsert.jsp">★도전하기★</a></li>
							<li><a href="<%=root%>/member/myInfo.jsp">개인 정보 변경</a></li>
							<li><a href="<%=root%>/member/exit.kh">도전글 내역</a></li>
							<li><a href="<%=root%>/member/exit.kh">후원 내역</a></li>
							<li><a href="#">회원 조회/검색</a></li>
						<%} else { %>
							<li><a href="<%=root%>/member/memberJoin.jsp">회원 가입</a></li>
						<%} %>
					</ul></li>
					
				<li><a href="#">도전 내역</a>
					<ul>
					<%if(isLogin) { %>
						<li><a href="<%=root%>/item/itemInsert.jsp">도전글 목록</a></li>
						<li><a href="<%=root%>/item/itemList.jsp">인증글 목록</a></li>
					<%} %>
					</ul></li>
				
				<li><a href="#">후기</a>
					<ul>
						<%if(isLogin) { %>
							<li><a href="<%=root%>/item/itemInsert.jsp">후기 작성</a></li>
						
						<%} else { %>
							<li><a href="<%=root%>/member/memberJoin.jsp">후기 보러가기</a></li>
						<%} %>
					</ul></li>
				
				<li><a href="#">관리자</a>
					<ul>
						<li><a href="<%=root%>/board/boardWrite.jsp">로그인</a></li>
						<li><a href="<%=root%>/board/boardList.jsp">인증글 목록</a></li>
					</ul></li>
			</ul>
		</nav>
		<section>