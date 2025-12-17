<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>영단어 훈련 플랫폼</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; }
        .hero-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 3rem 0; margin-bottom: 2rem; border-radius: 0 0 20px 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); transition: transform 0.2s, box-shadow 0.2s; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .progress { height: 10px; border-radius: 5px; background-color: #e9ecef; }
        .btn-study { border-radius: 50px; font-weight: bold; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/"><i class="fa-solid fa-graduation-cap"></i> 영단어 플랫폼</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <c:if test="${pageContext.request.userPrincipal != null}">
                        <li class="nav-item"><a class="nav-link" href="/rank/list"><i class="fa-solid fa-trophy text-warning"></i> 랭킹</a></li>
                        <li class="nav-item"><a class="nav-link" href="/mypage/dashboard"><i class="fa-solid fa-chart-line"></i> 마이페이지</a></li>
                        <li class="nav-item">
                            <form action="/customLogout" method="post" class="d-inline">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit" class="btn btn-outline-light btn-sm ms-2 rounded-pill px-3">로그아웃</button>
                            </form>
                        </li>
                    </c:if>
                    <c:if test="${pageContext.request.userPrincipal == null}">
                        <li class="nav-item"><a class="nav-link" href="/customLogin">로그인</a></li>
                        <li class="nav-item"><a class="btn btn-primary btn-sm ms-2 rounded-pill px-3" href="/member/join">회원가입</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="hero-section text-center">
        <div class="container">
            <c:if test="${pageContext.request.userPrincipal != null}">
                <h1 class="display-5 fw-bold mb-3">반갑습니다, ${pageContext.request.userPrincipal.name}님! 👋</h1>
                <p class="lead opacity-75">오늘도 목표를 향해 달려볼까요?</p>
            </c:if>
            <c:if test="${pageContext.request.userPrincipal == null}">
                <h1 class="display-5 fw-bold mb-3">영단어 완전 정복! 🚀</h1>
                <p class="lead opacity-75">로그인하고 나만의 맞춤 단어장을 만들어보세요.</p>
            </c:if>
        </div>
    </div>

    <div class="container mb-5">
        
        <div class="row justify-content-center mb-5">
            <div class="col-md-6 col-lg-4">
                <label class="form-label fw-bold text-secondary">학습 난이도 선택</label>
                <select class="form-select form-select-lg shadow-sm border-primary" id="levelSelect" onchange="changeLevel()">
                    <option value="1" selected>🌱 초급 (Beginner)</option>
                    <option value="2">🌿 중급 (Intermediate)</option>
                    <option value="3">🌳 고급 (Advanced)</option>
                </select>
            </div>
        </div>

        <div class="row g-4" id="dayListContainer">

            <c:forEach items="${days}" var="d">
                <div class="col-md-4 col-sm-6 col-lg-3">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h5 class="card-title fw-bold fs-4">Day ${d.day}</h5>
                                
                                <c:if test="${d.score ge 100}">
                                    <i class="fa-solid fa-crown text-warning fa-2x"></i>
                                </c:if>
                                <c:if test="${d.score lt 100}">
                                    <i class="fa-solid fa-bookmark text-muted opacity-25 fa-2x"></i>
                                </c:if>
                            </div>
                            
                            <p class="card-text text-muted flex-grow-1">오늘의 필수 영단어 학습</p>
                            
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <span class="small text-secondary fw-bold">진도율</span>
                                <span class="badge ${d.score == 100 ? 'bg-success' : 'bg-light text-dark border'}">
                                    ${d.score}%
                                </span>
                            </div>
                            <div class="progress mb-4">
                                <div class="progress-bar ${d.score == 100 ? 'bg-success' : 'bg-primary'}" 
                                     role="progressbar" 
                                     style="width: ${d.score}%"></div>
                            </div>
                            
                            <a href="/word/study?level=${currentLevel}&day=${d.day}" class="btn btn-outline-primary w-100 btn-study">
    <i class="fa-solid fa-book-open me-1"></i> 
    ${d.score > 0 ? '복습하기' : '학습하기'}
</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty days}">
                <div class="col-12 text-center py-5">
                    <div class="text-muted mb-3"><i class="fa-regular fa-folder-open fa-3x"></i></div>
                    <h4 class="text-secondary">등록된 학습 데이터가 없습니다.</h4>
                    <p class="text-muted">로그인을 하시거나, 관리자에게 문의해주세요.</p>
                </div>
            </c:if>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // 1. 페이지 열릴 때 드롭박스 값 유지하기
        window.onload = function() {
            let currentLevel = "${currentLevel}";
            if(currentLevel) {
                document.getElementById("levelSelect").value = currentLevel;
            }
        }

        // 2. 레벨 바꾸면 페이지 이동하기 (여기가 중요!)
        function changeLevel() {
            let level = document.getElementById("levelSelect").value;
            // 알림창(alert) 말고 진짜 이동!
            location.href = "/?level=" + level;
        }
    </script>
</body>
</html>