<%@page import="semi.review.beans.ReviewDto"%>
<%@page import="semi.review.beans.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <!--   리뷰상세보기 페이지는 리뷰게시판넘버가 필요함-->
   
   <%
	   int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
    	//번호를 받은 후 조회를 한다
	   ReviewDao reviewDao= new ReviewDao();
	   ReviewDto reviewDto = reviewDao.get(reviewNo);
   %>
   
   <jsp:include page="/template/header.jsp"></jsp:include>
   
   <p><%=reviewDto.getReviewNo() %></p>
   <p><%=reviewDto.getReviewNick() %></p>
   <p><%=reviewDto.getReviewTime() %></p>
   <p><%=reviewDto.getReviewStar() %></p>
   <p><%=reviewDto.getReviewContent() %></p>
   
   
   
   
   
   
   <jsp:include page="/template/footer.jsp"></jsp:include>