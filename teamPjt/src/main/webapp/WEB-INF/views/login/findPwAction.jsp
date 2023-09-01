<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	var path = "${pageContext.request.contextPath}";


</script>
<body>
	<div id="contents">
		<div class="container sub_title">
			<div class="tit" style="font-weight:bold;">FIND PASSWORD</div>
			<div class="txt" style="font-weight:bold;">비밀번호 찾기</div>
		</div>
		<form action="findPwform" method="post">
		<div class="container">
			<div class="login_wrap">
				<div class="txt" style="font-weight:bold;"> 가입하신 이메일로 임시 비밀번호가 발송되었습니다.</div>
					<div class="w3-content w3-container w3-margin-top">
						<div class="w3-container w3-card-4">
							<div class="w3-center w3-large w3-margin-top">
						      <div class="text-center">
						          <h2 class="h4 text-gray-900 mb-2"></h2><br><br>
						               
						      </div>									

							<div class="text-center">
							
									<div style="display: flex; align-items: center; justify-content: center; margin-bottom: 1em; ">
									<a style="padding-top:30px;" class="small" href="/login/signup">아직 회원이 아니신가요?
										<button type="button" id='findPwbtn' onclick=""
											class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
											style="width: 100px; height: 30px; border: 1px solid #ebebeb; background-color: #fff; border-radius: 20px;">회원가입</button>
									</a>
									</div>
							
<div style="display: flex; align-items: center; justify-content: center;">
								<a style="padding-top:25px;" class="small" href="/login/login">이미 회원이신가요?
									<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
										style="width: 100px; height: 30px; border: 1px solid #ebebeb; background-color: #fff; border-radius: 20px; margin: left;">로그인</button>
								</a>
								</div>
							</div>

						</div>
					</div>
			</div>
		</div>
	</div>
</form>
</div>
</body>
<jsp:include page="../common/footer.jsp" />
</html>