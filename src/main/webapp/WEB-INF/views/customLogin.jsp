<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>

<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
				
					<div class="panel-heading">
						<h3 class="panel-title">Please Sign In</h3>
					</div>
					
					<div class="panel-body">
						<form role="form" method="post" action="/login">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="User ID"
										name="username" type="text" autofocus>
								</div>

								<div class="form-group">
									<input class="form-control" placeholder="Password"
										name="password" type="password">
								</div>

								<div class="checkbox">
									<label>
										<input name="remember-me" type="checkbox"> Remember Me
									</label>
								</div>

								<button type="submit" class="btn btn-lg btn-success btn-block">Login</button>

								<button type="button" class="btn btn-default btn-block"
									style="margin-top:10px;"
									onclick="location.href='/'">
									메인으로 돌아가기
								</button>

								<button type="button" class="btn btn-info btn-block"
									style="margin-top:10px;"
									onclick="location.href='/member/join'">
									회원가입
								</button>

							</fieldset>

							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>

	<!-- 🔥 필요 없는 a태그 클릭 이벤트 제거 (이제 버튼 submit 사용함) -->
	<script>
	$(".btn-success").on("click", function(e){
		// 더 이상 막을 필요 없음. form submit 잘 됨.
	});
	</script>

	<!-- 로그아웃 메시지 -->
	<c:if test="${param.logout != null}">
		<script>
		$(document).ready(function(){
			alert("로그아웃하였습니다.");
		});
		</script>
	</c:if>

</body>
</html>

