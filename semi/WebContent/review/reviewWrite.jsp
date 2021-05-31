<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
.container-1000{
border: 1px solid lightgrey;
padding: 20px;
border-radius: 5px;
}
h2{
text-align: center;
text-shadow: 5px 5px 3px lightgrey;
}

#btn{
text-align: center;
border:none;
}
</style>
<div class="container-1000" >

	<div class="row">
		<h2>후기 작성하기</h2>
	</div>

	<div class="row">

		<form action="reviewWrite.kh" method="post">

			<label>별점 선택하기:</label> <select name="reviewStar" id="star">
				<option value="5" selected>★★★★★</option>
				<option value="4">★★★★☆</option>
				<option value="3">★★★☆☆</option>
				<option value="2">★★☆☆☆</option>
				<option value="1">★☆☆☆☆</option>
				<option value="0">☆☆☆☆☆</option>

			</select> <br>
			<br> 사용하신 후 소감:
			<textarea name="reviewContent"></textarea>

			<br>
			<br> <input type="submit" value="등록하기" id="btn">
		
		</form>
	</div>

</div>


<jsp:include page="/template/footer.jsp"></jsp:include>


