<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>단어 학습</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body { background-color: #f8f9fa; }
    .word-card { cursor: pointer; transition: transform 0.2s; }
    .word-card:hover { transform: scale(1.02); }
    .meaning { display: none; color: #0d6efd; font-weight: bold; } /* 뜻은 처음에 숨김 */
</style>
</head>
<body>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📚 Day ${currentDay} 학습장 <span class="badge bg-secondary fs-6">Level ${currentLevel}</span></h2>
        <a href="/" class="btn btn-outline-secondary">메인으로</a>
    </div>

    <div class="row g-3">
        <c:forEach items="${words}" var="vo">
            <div class="col-md-6">
                <div class="card word-card p-4 text-center shadow-sm" onclick="toggleMeaning(this)">
                    <h3 class="fw-bold mb-0">${vo.wordSpell}</h3>
                    <p class="meaning mt-2 fs-5">${vo.wordMean}</p>
                    <small class="text-muted mt-2">클릭해서 뜻 확인</small>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="text-center mt-5 mb-5">
    <a href="/word/quiz?level=${currentLevel}&day=${currentDay}" class="btn btn-success btn-lg px-5">
        퀴즈 풀러 가기 📝
    </a>
</div>
</div>

<script>
    // 클릭하면 뜻을 보여줬다 숨겼다 하는 함수
    function toggleMeaning(card) {
        let meaning = card.querySelector(".meaning");
        if (meaning.style.display === "block") {
            meaning.style.display = "none";
        } else {
            meaning.style.display = "block";
        }
    }
</script>

</body>
</html>