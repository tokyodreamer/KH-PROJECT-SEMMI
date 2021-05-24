<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page="/template/header.jsp"></jsp:include>
    
    
    <div class="container-600">

    <div class="row">
    <h2>회원 가입 입력</h2>
    </div>
    
<!--     회원가입에 필요한 세부내역 입력 -->
    <form action="memberJoin.kh" method="post">
    
    <div class="row text-left">
		    <label for="id-input">아이디를 입력하세요</label>
		    <input type="text" name="memberId" id="id-input"  
		    class="form-input form-input-underline"  required placeholder="8~20자 이내의 영문소문자, 숫자">
    </div>
    
    <div class="row text-left">
		   <label for="pw-input">비밀번호를 입력하세요</label>
		   <input type="password" name="memberPw" id="pw-input" class="form-input form-input-underline"
		   required placeholder="8자-16자 이내의 영문 소문자, 숫자, 특수문자">
    </div>
    
    <div class="row text-left">
			<label for="pw-reInput">비밀번호 재확인</label>
			<input type="password" class="form-input form-input-underline" id="pw-reInput"
						placeholder="동일한 비밀번호를 한번 더 입력">
	</div>
    
    <div class="row text-left">
		    <label for="nick-input">닉네임을 입력하세요</label>
		    <input type="text" name="memberNick" id="nick-input" class="form-input form-input-underline"
		    required placeholder="한글1~10글자, 영문 대소문자 2~20글자, 숫자 가능">
    </div>
    
    <div class="row text-left">
		    <label for="email-input">이메일 주소를 입력하세요</label>
		    <input type="email" name="memberEmail" id="email-input" 
		    required class="form-input form-input-underline">
    </div>
    
    <div class="row">
   			<input type="submit" value="가입하기" class="form-btn form-btn-positive">
    
    </div>
    
    
    
    </form>
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>