<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>
    
    <style>
    
    .login_btn{
		background : grey;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
	}
	.login_user{
		text-align : center;
		padding-top: 10px;
	}
	.login_title{
		background : black;
		color : white;
		font-size : 40px;
		font-family: Arial Black,"Times New Roman",Monospace;
		text-align : center;
	}
	.login_div {
		font-size : 17px;
		color : silver;
	}
	.login_id {
		margin-left : 20px;
	}
	.login_pw {
		margin-right : px;
	}
	.regist_btn{
		background : black;
		color : white;
		font-size : 25px;
		font-family: arial black,"Times New Roman", Sans-serif;
	}
    
    </style>
    
    <div class="container-600">

    <div class="row">
  		<div class="login_title">이메일 인증</div>
  		<h3>이메일 인증후 이메일에 전송된 링크로 회원가입해주세요.</h3>
    </div>
    

    <form action="emailCheck.kh" method="post">
    
    
    <div class="row text-left login_btn">
		    <label for="email-input">이메일 주소를 입력하세요</label>
		    <input type="email" name="memberEmail" id="email-input" 
		    required class="form-input form-input-underline">
    </div>
    

    
    <div class="row">
   			<input type="submit" value="인증하기" class="form-btn regist_btn">
    
    </div>
    
    
    
    </form>
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>