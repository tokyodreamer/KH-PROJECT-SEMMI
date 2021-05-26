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
					<button>로그아웃</button>
				<%} else { %>
					<button>회원가입</button>
					<button>로그인</button>
				<%} %>
			
			</div>
			<h1>세미 프로젝트 (임시)</h1>
		</header>
		<nav>
			<ul class="menu">
				<li><a href="#">주 메뉴 01</a>
					<ul>
						<%if(isLogin) { %>
							<li><a href="<%=root%>/member/logout.kh">로그아웃</a></li>
							<li><a href="<%=root%>/member/myInfo.jsp">내 정보 보기</a></li>
							<li><a href="<%=root%>/member/exit.kh">회원 탈퇴</a></li>
							<li><a href="#">회원 조회/검색</a></li>
						<%} else { %>
							<li><a href="<%=root%>/member/memberJoin.jsp">회원 가입</a></li>
							<li><a href="<%=root%>/member/memberLogin.jsp">로그인</a></li>
						<%} %>
					</ul></li>
				<li><a href="#">주 메뉴 02</a>
					<ul>
						<li><a href="<%=root%>/item/itemInsert.jsp">아이템 등록</a></li>
						<li><a href="<%=root%>/item/itemList.jsp">아이템 목록</a></li>
					</ul></li>
					<%if(isLogin) { %>
				<li><a href="#">부 메뉴 01</a>
					<ul>
						<li><a href="<%=root%>/product/productInsert.jsp">상품 등록</a></li>
						<li><a href="<%=root%>/product/productList.jsp">상품 목록</a></li>
						<li><a href="<%=root%>/product/productRank.jsp">상품 검색(1)</a></li>
						<li><a href="<%=root%>/product/productSearch.jsp">상품 검색(2)</a></li>
					</ul></li>
					<%} %>
				<li><a href="#">부 메뉴 02</a>
					<ul>
						<li><a href="<%=root%>/board/boardWrite.jsp">게시글 작성</a></li>
						<li><a href="<%=root%>/board/boardList.jsp">게시글 목록</a></li>
					</ul></li>
			</ul>
		</nav>
		<section>