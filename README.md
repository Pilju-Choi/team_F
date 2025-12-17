# F조 영단어 학습 플랫폼 
누구나 쉽고 안전하게. 수준별 맞춤 영단어를 학습하고 퀴즈로 실력을 점검하는 웹 서비스입니다.

## 1. 프로젝트 소개
F조 영단어 학습 플랫폼은 사용자의 영어 실력(난이도)에 맞춰 체계적으로 단어를 암기할 수 있도록 돕습니다. 단순한 암기를 넘어, 
Spring Security를 적용하여 개인정보를 안전하게 보호하며, 퀴즈와 랭킹 시스템을 통해 학습 동기를 부여합니다.

## 2. 주요 기능 
### 1. 로그인 / 로그아웃
* Spring Security 기반의 인증 시스템을 구축하여 보안성을 강화했습니다.
* BCryptPasswordEncoder를 활용한 비밀번호 암호화 처리가 적용되었습니다.

### 2. 회원가입
* 사용자별 독립적인 학습 기록 저장을 위한 회원가입 기능을 제공합니다.

### 3. 단계별 단어 학습장
* 사용자 수준(난이도)에 맞는 단어를 Day(일차)별로 나누어 체계적으로 제공합니다.

### 4. 단어 퀴즈 (Test)
* 저장된 단어를 기반으로 객관식/주관식 퀴즈를 풀며 암기 여부를 확실하게 점검합니다.
* 틀린 문제는 자동으로 오답노트에 기록되어 재학습을 유도합니다.

### 5. 랭킹 리더보드
* 퀴즈 점수를 바탕으로 사용자 간 순위를 실시간으로 제공하여 선의의 경쟁을 유도합니다.

### 6. 학습 통계 대시보드
* 학습 진행률, 정답률 등을 시각화된 그래프로 제공하여 성장 과정을 한눈에 확인합니다.

## 3. 시스템 아키텍처 및 설계 
### 1. 유스케이스 다이어그램 
사용자의 행동 패턴과 보안 로직을 시각화하였습니다.

* 보안 중심 설계: 단어 퀴즈, 학습 통계 등 핵심 기능은 로그인을 전제조건(<<include>>)으로 하여 비인가 접근을 차단했습니다.
* 유연한 흐름: 로그인 성공/실패 여부에 따른 시나리오를 분기(<<extends>>)하여 예외 상황을 체계적으로 관리합니다.

## 시스템 아키텍처 및 설계
<img width="700" height="530" alt="image" src="https://github.com/user-attachments/assets/43e0d67f-032e-4958-b6a9-247400a8e578" />

## 4. 기술 스택
* Language: Java 8+
* Framework: Spring Framework 5, Spring Security
* Database: MySQL (또는 Oracle), MyBatis
* Server: Apache Tomcat 9.0
* Frontend: JSP, JSTL
* Tool: Eclipse, Maven

## 5. 실행 화면
### 메인 페이지 - **로그인 전**
<img width="600" height="300" alt="image" src="https://github.com/user-attachments/assets/01670389-3a99-4991-8099-47580af6cbde" />

### 로그인/로그아웃 
<img width="460" height="422" alt="image" src="https://github.com/user-attachments/assets/757fae67-ef8c-4182-9213-36fdfd9a6814" />

### 메인 페이지 - **로그인 후**
<img width="600" height="300" alt="image" src="https://github.com/user-attachments/assets/9eacc46b-b7b4-4417-bc98-72f0f146fcbf" />

### 학습 난이도 선택
<img width="600" height="300" alt="image" src="https://github.com/user-attachments/assets/d1a8a3f1-c75b-41aa-a44a-fab568781109" />








