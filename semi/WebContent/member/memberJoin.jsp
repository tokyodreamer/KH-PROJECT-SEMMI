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
  		<div class="login_title">회원 가입 입력</div>
    </div>
    
<!--     회원가입에 필요한 세부내역 입력 -->
    <form action="memberJoin.kh" method="post">
    
    <div class="row text-left login_btn">
		    <label for="id-input">아이디를 입력하세요</label>
		    <input type="text" name="memberId" id="id-input"  
		    class="form-input form-input-underline"  required placeholder="8~20자 이내의 영문소문자, 숫자">
    </div>
    
    <div class="row text-left login_btn">
		   <label for="pw-input">비밀번호를 입력하세요</label>
		   <input type="password" name="memberPw" id="pw-input" class="form-input form-input-underline"
		   required placeholder="8자-16자 이내의 영문 소문자, 숫자, 특수문자">
    </div>
    
    <div class="row text-left login_btn">
			<label for="pw-reInput">비밀번호 재확인</label>
			<input type="password" class="form-input form-input-underline" id="pw-reInput"
						placeholder="동일한 비밀번호를 한번 더 입력">
	</div>
    
    <div class="row text-left login_btn">
		    <label for="nick-input">닉네임을 입력하세요</label>
		    <input type="text" name="memberNick" id="nick-input" class="form-input form-input-underline"
		    required placeholder="한글1~10글자, 영문 대소문자 2~20글자, 숫자 가능">
    </div>
    
    <div class="row text-left login_btn">
		    <label for="email-input">이메일 주소를 입력하세요</label>
		    <input type="email" name="memberEmail" id="email-input" 
		    required class="form-input form-input-underline">
    </div>
    
    <div class="row">
   			<input type="submit" value="가입하기" class="form-btn regist_btn">
    
    </div>
    
    
    
    </form>
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>