<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/template/header.jsp"></jsp:include>
    
    <script type= "text/javascript">
    $(function()){
    	$("#star").change(function(){
    		alert(this.vlaue);
    	})
    }
    </script>
    <div class = "container-600">
    
   <div clss="row">
   <h2>후기 등록하기</h2>
   </div>
   
   <div clss="row">
   <from action="" method="post">
   
   <label>별점</label>
   <select name="reviewStar" id="star" >
   		<option vlaue="★★★★★" selected></option>
   		<option vlaue="★★★★☆"></option>
   		<option vlaue="★★★☆☆"></option>
   		<option vlaue="★★☆☆☆"></option>
   		<option vlaue="★☆☆☆☆"></option>
   		<option vlaue="☆☆☆☆☆"></option>
   	
   </select>
   <br><br>
   
   소감: <textarea name="reviewContent"></textarea>
   
     <br><br>
   
    <input type="submit" value="등록하기" >
    </div>
    
    </div>
    
     <jsp:include page="/template/footer.jsp"></jsp:include>