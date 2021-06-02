<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int challengeNo = Integer.parseInt(request.getParameter("challengeNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/challengeJoin.css">
<style>
	.table {
	border-collapse: collapse;
	border-top: 0.5px solid rgb(51,51,51);
	}
	
	#write-frm th {
		border-bottom: 1px solid #ddd;
		background-color: rgb(242, 245, 249);
		font-weight: normal;
		font-size: 14px;
	}
	#write-frm td{
		border-bottom: 1px solid #ddd;
	}
	
	.form-input {
	border: 1px solid #ddd;
	margin-bottom: 10px;
	margin-top:10px;
	}
	
.filebox label {
  display: inline-block;
  padding: .3em .75em;
  color: #fff;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #5cb85c;
  cursor: pointer;
  border: 1px solid #4cae4c;
  border-radius: .25em;
  -webkit-transition: background-color 0.2s;
  transition: background-color 0.2s;
}

.filebox label:hover {
  background-color: #6ed36e;
}

.filebox label:active {
  background-color: #367c36;
}

.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}

	.join-btn{
		cursor: pointer;
	}



</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
			$("input[name=authFile]").change(function() {
				var txt = $(this).val();
				$("#fileName").val(txt);
			});	

// 			새로고침 or 뒤로가기 or 나가기 버튼 클릭시 경고창 이벤트			
//			var checkload = true;
//			$("input[type=submit]").click(function() {
//					checkload = false;
//			});
//			$(window).on("beforeunload", function() {
//				if(checkload == true) return "정말로 나가시겠습니까?";
//			});

//			등록 완료 메세지..			
//			$("#testfrm").submit(function(){
//				alert("등록되었습니다");
//			});


	});

</script>

<div class="container-800">
	<div class="row">
		<h2>인증글 작성</h2>
	</div>
	
	<form action="authInsert.kh" method="post" enctype="multipart/form-data" id="testfrm">
			<input type="hidden" name="authChallengeNo" value="<%=challengeNo%>">
			<input type="hidden" name="authCategoryType" value="<%=categoryNo%>">
	
<div class="row">
		<table class="table"  id="write-frm">
			<tbody>
			<tr>		
				<th><label>인증 제목</label></th>
				<td><input type="text" class="form-input" name="authTitle" placeholder="제목을 입력하세요" required></td>
			</tr>
			<tr>
			
			<th><label>인증 내용</label></th>
			<td><textarea class="form-input" rows="" cols="" name="authContent"  placeholder="내용을 입력하세요" required></textarea></td>
			</tr>
			
			<tr>
				<th><label>인증 사진</label></th>
				<td class = "filebox">
					<input type=text" id="fileName" disabled="disabled" style="padding: 2px; width: 30%;">
					<label for="upload">업로드</label>
					<input type="file" name="authFile" accept=".png, .jpg, .gif"  id = "upload" required>
				</td>
			</tr>
			</tbody>
	</table>
</div>
	
		<div class="row">
			<input type="submit" value="등록" class="form-btn form-btn-positive">
		</div>	
			
		<div class="row">
			<input type="reset" value="초기화" class="form-btn form-btn-negative">
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
