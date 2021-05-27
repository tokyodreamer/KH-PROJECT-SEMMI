<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="row text=left">
	<h4>후기 목록</h4>
</div>
<div class="row text=left">
	<div class="float-container">
		<div class="left">작성자 영역</div>
		<div class="right">수정 | 삭제</div>
	</div>
</div>

<div>
	<pre>내용</pre>
</div>

<div>
	<pre>시간</pre>
</div>



<form action="" method="post">
	<!-- 	<input type = "hidden" name ="origin"> -->

	<div class="row">
		<textarea name="content" required></textarea>
	</div>

	<div class="row">
		<input type="submit" value="댓글 작성">
	</div>

</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
