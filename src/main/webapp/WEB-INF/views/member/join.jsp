<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
    .container { width: 300px; margin: 100px auto; padding: 20px; border: 1px solid #ccc; }
    input { width: 100%; padding: 10px; margin-bottom: 10px; box-sizing: border-box; }
    button { padding: 10px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    button:hover { opacity: 0.9; }
    .error { color: red; margin-bottom: 10px; }
</style>
</head>
<body>

<div class="container">
    <h2>회원가입</h2>

    <!-- 서버에서 넘어온 에러 메시지 출력 -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    
    <form action="/member/join" method="post">
    
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        
        <label>아이디</label>
        <div style="display: flex; gap: 5px;">
            <input type="text" id="userId" name="userId" placeholder="아이디 입력" required style="flex:1;">
            <button type="button" onclick="checkId()">중복확인</button>
        </div>

        <div id="idCheckResult" style="color:red; margin-bottom:10px;"></div>
        
        <label>비밀번호</label>
        <div style="font-size:12px; color:#666; margin-top:-8px; margin-bottom:5px;">
            8자 이상이며 특수문자를 1개 이상 포함해야 합니다.
        </div>
        <input type="password" name="userPw" placeholder="비밀번호 입력" required>
        
        <label>이름</label>
        <input type="text" name="userName" placeholder="이름 입력" required>
        
        <label>이메일</label>
        <input type="email" name="userEmail" placeholder="이메일 입력" required>
        
        <button type="submit" style="width:100%;">가입하기</button>

        <!-- 🔥 메인으로 돌아가기 -->
        <button type="button" onclick="location.href='/'"
                style="width:100%; margin-top:10px; background-color:#555;">
            메인으로 돌아가기
        </button>
    </form>
</div>

<script>
function checkId() {
    let userId = document.getElementById("userId").value;

    if (userId.trim() === "") {
        alert("아이디를 입력하세요!");
        return;
    }

    fetch("/member/checkId?userId=" + userId)
        .then(res => res.text())
        .then(result => {
            if (result === "OK") {
                document.getElementById("idCheckResult").style.color = "green";
                document.getElementById("idCheckResult").innerText = "사용 가능한 아이디입니다.";
            } else {
                document.getElementById("idCheckResult").style.color = "red";
                document.getElementById("idCheckResult").innerText = "이미 존재하는 아이디입니다.";
            }
        });
}
</script>

</body>
</html>
