<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/53a8c415f1.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/sign_up.css" media="(max-width:600px)">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/sign_up.css" media="(min-width:600px)">
<script src="jquery-3.2.1.min.js">
</script>
<script>
$(document).ready(function(){
	
});
</script>
</head>
<body>
	<form method="post" action="JoinAction" class="wrap">
		<div class="sign_up">
            <h2 style='display:inline;'>회원가입</h2>
          
			<div class="register_name">
		        <h4>Name</h4>
				<input type="name" name="userNAME" placeholder="Name">
			</div>
	       	<div class="register_id">
	        	<h4>E-mail</h4>
				<input type="email" name="userID" placeholder="Email">
	      	</div>
	        <div class="register_pw">
	          	<h4>Password</h4>
				<input type="password" name="userPW" placeholder="Password">
			</div>
	            
			<div class="submit">
	           	<input type="submit" value="sign up" class = "submit_btn">
	       	</div>
	       	
        </div>
    </form>
</body>
</html>