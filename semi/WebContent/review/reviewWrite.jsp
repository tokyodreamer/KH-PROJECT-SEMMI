<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
.title{
text-align:center;
font-size: 20px;
font-weight: bold;
}
.score{
font-size: 40px;
color:red;
}
.link-btn.loginlogout{
background-color: black;
color:white;
font-size: 20px;
}
.container-600{
text-align: center;
}
.form-input{
font-size: 30px;
}
</style>
<h2>후기등록</h2>
<div class="container-600">


	<div class="row">

		<form action="reviewWrite.kh" method="post">

			<label class="title">도전은 어떠셨나요</label> 
			<br><br>
			<select name="reviewStar" id="star" class="score">
				<option value="5" selected>★★★★★</option>
				<option value="4">★★★★☆</option>
				<option value="3">★★★☆☆</option>
				<option value="2">★★☆☆☆</option>
				<option value="1">★☆☆☆☆</option>
				<option value="0">☆☆☆☆☆</option>
			</select><br>
			<br>
			<label class="title"> 소감을 남겨주세요</label>
			<br><br>
			<textarea name="reviewContent" class="form-input"></textarea>

			<br><br>
			<br> <input type="submit" value="등록하기" class="link-btn loginlogout ">
		
		</form>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>