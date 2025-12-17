<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>단어 퀴즈</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; padding-bottom: 100px; }
    .quiz-card { background: white; border-radius: 15px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .option-label { display: block; padding: 10px 15px; border: 2px solid #e9ecef; border-radius: 10px; margin-bottom: 8px; cursor: pointer; transition: 0.2s; }
    .option-label:hover { background-color: #f1f3f5; }
    /* 라디오 버튼 숨기고 디자인 커스텀 */
    input[type="radio"] { display: none; }
    input[type="radio"]:checked + .option-label { border-color: #0d6efd; background-color: #e7f1ff; color: #0d6efd; font-weight: bold; }
    
    /* 정답/오답 표시용 스타일 */
    .correct-answer { border-color: #198754 !important; background-color: #d1e7dd !important; color: #0f5132 !important; }
    .wrong-answer { border-color: #dc3545 !important; background-color: #f8d7da !important; color: #842029 !important; }
</style>
</head>
<body>

<div class="container mt-5" style="max-width: 600px;">
    <h2 class="text-center fw-bold mb-4">📝 Day ${day} 퀴즈</h2>

    <form id="quizForm">
        <c:forEach items="${quizList}" var="q" varStatus="status">
            <div class="quiz-card">
                <h4 class="fw-bold mb-3">Q${status.count}. ${q.word.wordSpell}</h4>
                
                <input type="hidden" class="correct-val" value="${q.word.wordMean}">

                <c:forEach items="${q.options}" var="opt">
                    <div>
                        <input type="radio" name="q_${status.index}" id="opt_${status.index}_${opt}" value="${opt}">
                        <label class="option-label" for="opt_${status.index}_${opt}">
                            ${opt}
                        </label>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>

        <button type="button" class="btn btn-primary btn-lg w-100" onclick="gradeQuiz()">채점하기</button>
    </form>
    
    <div class="modal fade" id="resultModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">퀴즈 결과</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body text-center">
            <h1 class="display-4 fw-bold" id="scoreText">0점</h1>
            <p id="resultMessage"></p>
          </div>
          <div class="modal-footer">
            <a href="/" class="btn btn-secondary">메인으로</a>
            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">오답 확인하기</button>
          </div>
        </div>
      </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function gradeQuiz() {
        let totalQuestions = document.querySelectorAll('.quiz-card').length;
        let correctCount = 0;
        
        // 모든 문제를 돌면서 정답 확인
        document.querySelectorAll('.quiz-card').forEach((card, index) => {
            let correctAns = card.querySelector('.correct-val').value; // 숨겨둔 정답
            let checkedRadio = card.querySelector('input[type="radio"]:checked'); // 사용자가 찍은 답
            
            // 1. 정답/오답 시각적 표시 (일단 초기화)
            card.querySelectorAll('.option-label').forEach(lbl => lbl.classList.remove('correct-answer', 'wrong-answer'));

            if (checkedRadio) {
                let userAns = checkedRadio.value;
                let label = checkedRadio.nextElementSibling;

                if (userAns === correctAns) {
                    correctCount++;
                    label.classList.add('correct-answer'); // 정답이면 초록색
                } else {
                    label.classList.add('wrong-answer'); // 틀리면 빨간색
                }
            }
            
            // (선택) 틀렸어도 정답이 뭔지는 알려주기
            // card.querySelectorAll('input[value="'+correctAns+'"] + label').forEach(l => l.classList.add('correct-answer'));
        });

        // 점수 계산
        let score = Math.round((correctCount / totalQuestions) * 100);
        
        // 모달창 띄우기
        document.getElementById("scoreText").innerText = score + "점";
        document.getElementById("resultMessage").innerText = totalQuestions + "문제 중 " + correctCount + "개 맞췄어요!";
        
        new bootstrap.Modal(document.getElementById('resultModal')).show();
        
        const urlParams = new URLSearchParams(window.location.search);
        const level = urlParams.get('level');
        const day = urlParams.get('day');

        // 전송할 데이터
        const quizData = new URLSearchParams();
        quizData.append('level', level);
        quizData.append('day', day);
        quizData.append('score', score);
        
        // 스프링 시큐리티 토큰 (필수!)
        const csrfToken = "${_csrf.token}";

        fetch('/word/saveScore', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-CSRF-TOKEN': csrfToken
            },
            body: quizData
        })
        .then(response => response.text())
        .then(result => {
            console.log("점수 저장 결과: " + result);
        })
        .catch(error => console.error('Error:', error));
    }
</script>

</body>
</html>