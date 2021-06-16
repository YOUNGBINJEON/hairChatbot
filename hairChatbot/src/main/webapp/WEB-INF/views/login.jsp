<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/53a8c415f1.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/login.css" media="(max-width:600px)">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/login.css" media="(min-width:600px)">

<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
	
});
</script>
</head>
<body>
    <form method="post" action="LoginAction" class="wrap">
        <div class="login">
          <img class="logo_img" src='<%=request.getContextPath()%>/resources/imgs/logo3.png' /><h2 style='display:inline;'></h2>
            <div class="login_sns">
            <li><a href=""><i class="fab fa-instagram"></i></a></li>
            <li><a href=""><i class="fab fa-facebook-f"></i></a></li>
            <li><a href=""><i class="fab fa-twitter"></i></a></li>
            </div>

	            <div class="login_id">
	                <h4>E-mail</h4>
	                <input type="email" name="userID"  placeholder="Email">
	            </div>
	            <div class="login_pw">
	                <h4>Password</h4>
	                <input type="password" name="userPW" placeholder="Password">
	            </div>
	            
	            <div class="login_etc">
	                <div class="checkbox">
	                	<input type="checkbox" name="" id=""> Remember Me?
	                </div>
	                <div class="forgot_pw">
	                	<a href="signup">JOIN</a>
	           		</div>
	            </div>
	            
	            <div class="submit">
	                <input type="submit" value="LOG IN" class = "submit_btn">
	                
	            </div>
        </div>
    </form>
</body>
</html>