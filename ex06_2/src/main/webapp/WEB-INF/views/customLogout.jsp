<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
    body { font-family: 'Arial', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #f0f2f5; }
    .login-box { width: 360px; padding: 40px; background: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); text-align: center; }
    h2 { margin-bottom: 30px; color: #333; }
    input { width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; }
    button:hover { background-color: #0056b3; }
    .error { color: red; margin-bottom: 15px; font-size: 14px; }
    .logout { color: blue; margin-bottom: 15px; font-size: 14px; }
</style>
</head>
<body>

<div class="login-box">
    <h2>로그인</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty logout}">
        <div class="logout">${logout}</div>
    </c:if>

    <form method='post' action="/login">
        
        <input type="text" name='username' placeholder="아이디를 입력하세요" required>
        
        <input type="password" name='password' placeholder="비밀번호를 입력하세요" required>
        
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        
        <button type="submit">로그인</button>
    </form>
    
    <div style="margin-top: 20px;">
        <a href="/member/join" style="text-decoration: none; color: #666;">회원가입 하러가기</a>
    </div>
</div>

</body>
</html>