<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    body { background-color: #f8f9fa; }
    .stat-box { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); height: 100%; }
</style>
</head>
<body>

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/">🏠 메인(대시보드)으로</a>
        </div>
    </nav>

    <div class="container">
        <div class="text-center mb-5">
            <h1 class="fw-bold mb-3"><i class="fa-solid fa-chart-line text-primary"></i> 나의 학습 분석</h1>
            <p class="text-muted">전체 성취도와 레벨별 약점을 분석합니다.</p>
        </div>

        <div class="row g-4">
            
            <div class="col-md-7">
                <div class="stat-box p-4">
                    <h4 class="mb-4 fw-bold text-secondary">📊 레벨별 정답 수 (막대)</h4>
                    <div style="height: 300px;">
                        <canvas id="levelBarChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="stat-box p-4 text-center">
                    <h4 class="mb-4 fw-bold text-secondary">🎯 전체 정확도 (원형)</h4>
                    <div style="max-height: 250px; max-width: 250px; margin: 0 auto;">
                        <canvas id="accuracyChart"></canvas>
                    </div>
                    <div class="mt-4">
                        <h5 class="fw-bold">평균 점수: <span class="text-primary">${stats.accuracyRate}점</span></h5>
                        <p class="text-muted small">총 ${stats.totalWords}개의 Day를 학습했습니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        
        // --- 데이터 준비 (JSP 데이터를 JS 변수로 변환) ---
        const total = ${stats.totalWords};
        const correct = ${stats.correctWords};
        
        // 레벨별 데이터 배열 초기화 (초급, 중급, 고급)
        let levelLabels = ['초급', '중급', '고급'];
        let levelData = [0, 0, 0]; // 기본값 0

        // JSTL로 서버 데이터를 JS 배열에 넣기
        <c:forEach items="${levelStats}" var="ls">
            // level이 1이면 index 0, 2면 1...
            if(${ls.level} >= 1 && ${ls.level} <= 3) {
                levelData[${ls.level} - 1] = ${ls.correctCount};
            }
        </c:forEach>

        // --- 1. 막대 차트 그리기 (레벨별) ---
        new Chart(document.getElementById('levelBarChart'), {
            type: 'bar',
            data: {
                labels: levelLabels,
                datasets: [{
                    label: '만점(100점) 횟수',
                    data: levelData,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)', // 초급 (민트)
                        'rgba(54, 162, 235, 0.6)', // 중급 (파랑)
                        'rgba(255, 206, 86, 0.6)'  // 고급 (노랑)
                    ],
                    borderColor: [
                        'rgb(75, 192, 192)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 206, 86)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // 높이 조절 허용
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 } // 정수로만 표시
                    }
                }
            }
        });

        // --- 2. 원형 차트 그리기 (전체) ---
        if (total > 0) {
            new Chart(document.getElementById('accuracyChart'), {
                type: 'doughnut',
                data: {
                    labels: ['정답(만점)', '오답(미달)'],
                    datasets: [{
                        data: [correct, total - correct],
                        backgroundColor: ['#198754', '#e9ecef'],
                        hoverOffset: 4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'bottom' }
                    }
                }
            });
        } else {
            // 데이터 없을 때 빈 원 그리기 방지
            document.getElementById('accuracyChart').parentElement.innerHTML = 
                '<div class="py-5 text-muted">아직 데이터가 없습니다.</div>';
        }
    });
</script>

</body>
</html>