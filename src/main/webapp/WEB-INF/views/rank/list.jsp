<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명예의 전당</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body { background-color: #f8f9fa; padding-bottom: 100px; /* 하단 바 공간 확보 */ }
    .rank-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); background: white; }
    .rank-icon { font-size: 1.5rem; }
    .gold { color: #FFD700; text-shadow: 0 0 5px rgba(255, 215, 0, 0.5); }
    .silver { color: #C0C0C0; text-shadow: 0 0 5px rgba(192, 192, 192, 0.5); }
    .bronze { color: #CD7F32; text-shadow: 0 0 5px rgba(205, 127, 50, 0.5); }
    .table td, .table th { vertical-align: middle; }
    
    /* ★ 내 랭킹 고정 바 스타일 ★ */
    .my-rank-bar {
        position: fixed; bottom: 0; left: 0; width: 100%;
        background-color: #343a40; color: white;
        padding: 15px 0; box-shadow: 0 -5px 15px rgba(0,0,0,0.1);
        z-index: 1000;
    }
    .my-rank-highlight { font-weight: bold; color: #ffc107; }
</style>
</head>
<body>

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="/">🏠 메인으로</a>
        </div>
    </nav>

    <div class="container">
        <div class="text-center mb-5">
            <h1 class="fw-bold"><i class="fa-solid fa-trophy text-warning"></i> 명예의 전당</h1>
            <p class="text-muted">TOP 10 랭커와 나의 순위를 확인하세요!</p>
        </div>

        <ul class="nav nav-pills justify-content-center mb-4">
            <li class="nav-item"><a class="nav-link ${currentLevel == 1 ? 'active' : ''}" href="/rank/list?level=1">초급</a></li>
            <li class="nav-item"><a class="nav-link ${currentLevel == 2 ? 'active' : ''}" href="/rank/list?level=2">중급</a></li>
            <li class="nav-item"><a class="nav-link ${currentLevel == 3 ? 'active' : ''}" href="/rank/list?level=3">고급</a></li>
        </ul>

        <div class="rank-card p-4">
            <table class="table table-hover text-center">
                <thead class="table-light">
                    <tr>
                        <th style="width: 100px;">순위</th>
                        <th>이름</th>
                        <th>총점</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="myRank" value="0" />
                    <c:set var="myScore" value="0" />
                    
                    <c:forEach items="${rankList}" var="rank" varStatus="status">
                        
                        <c:if test="${rank.userId eq myId}">
                            <c:set var="myRank" value="${status.count}" />
                            <c:set var="myScore" value="${rank.totalScore}" />
                        </c:if>

                        <c:if test="${status.count le 10}">
                            <tr class="${rank.userId eq myId ? 'table-warning' : ''}"> <td class="fw-bold fs-5">
                                    <c:choose>
                                        <c:when test="${status.count == 1}"><i class="fa-solid fa-medal gold rank-icon"></i></c:when>
                                        <c:when test="${status.count == 2}"><i class="fa-solid fa-medal silver rank-icon"></i></c:when>
                                        <c:when test="${status.count == 3}"><i class="fa-solid fa-medal bronze rank-icon"></i></c:when>
                                        <c:otherwise>${status.count}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-bold">${rank.userName} 
                                    <c:if test="${rank.userId eq myId}"><span class="badge bg-danger ms-1">ME</span></c:if>
                                </td>
                                <td><span class="badge bg-primary rounded-pill">${rank.totalScore}점</span></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${empty rankList}">
                        <tr><td colspan="3" class="py-5 text-muted">데이터가 없습니다.</td></tr>
                    </c:if>
                    
                    <c:if test="${rankList.size() > 10}">
                        <tr>
                            <td colspan="3" class="text-muted fw-bold py-3">. . .</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${myRank > 0}">
        <div class="my-rank-bar">
            <div class="container d-flex justify-content-between align-items-center">
                <div class="fs-5">
                    <span class="badge bg-warning text-dark me-2">내 순위</span>
                    <span class="my-rank-highlight">${myRank}위</span>
                </div>
                <div class="fs-5">
                    <span class="text-light me-2">총점</span>
                    <span class="fw-bold">${myScore}점</span>
                </div>
                <div>
                    <a href="/" class="btn btn-sm btn-outline-light">학습하러 가기</a>
                </div>
            </div>
        </div>
    </c:if>
    
    <c:if test="${myRank == 0}">
        <div class="my-rank-bar">
            <div class="container text-center">
                <span class="text-light me-3">아직 랭킹 기록이 없습니다.</span>
                <a href="/" class="btn btn-sm btn-warning">지금 도전하기</a>
            </div>
        </div>
    </c:if>

</body>
</html>