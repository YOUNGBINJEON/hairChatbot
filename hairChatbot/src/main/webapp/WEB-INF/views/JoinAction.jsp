<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class ="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPW"/>
<jsp:setProperty name="user" property="userNAME"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js">
</script>
<script>
$(document).ready(function(){
	
});
</script>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPW() == null || user.getUserNAME() == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('필수사항을 입력하지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'login'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>