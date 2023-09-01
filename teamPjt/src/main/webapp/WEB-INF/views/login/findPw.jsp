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

	$(document).ready(function() {
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});


function findPwAction() {
	// 유효성 체크
	var emailCk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	if ($("#memberId").val() == null || $("#memberId").val() == "") {
		alert("아이디를 입력해주세요.");
		$("#memberId").focus();

		return false;
	}
	if ($("#memberName").val() == null || $("#memberName").val() == "") {
		alert("이름을 입력해주세요.");
		$("#memberName").focus();

		return false;
	}

	if ($("#memberEmail").val() == null || $("#memberEmail").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#memberEmail").focus();

		return false;
	}

	if (!emailCk.test($("#memberEmail").val())) {
		alert("이메일 형식에 맞게 입력해주세요.");
		return false;
	}

	if (confirm("비밀번호를 찾으시겠습니까?")) {
		$("#findPwform").submit();
		return false;
	}
};
</script>
<body>
	<div id="contents">
		<div class="container sub_title">
			<div class="tit" style="font-weight:bold;">FIND PASSWORD</div>
			<div class="txt" style="font-weight:bold;">비밀번호 찾기</div>
		</div>
		<form action="${path}/login/findPwAction" id="findPwform" method="post">
		<div class="container">
			<div class="login_wrap">
				<div class="txt" style="font-weight:bold;">회원정보를 입력하세요</div>
					<div class="w3-content w3-container w3-margin-top">
						<div class="w3-container w3-card-4">
							<div class="w3-center w3-large w3-margin-top">
									<div class='input_box'>
								<table style="width: 100%; height: 50%; line-height: 60px;">
										<tr>
											
											<td style="border-bottom: 1px solid #ebebeb;"><input
												class="w3-input" type="text" id="memberId" name="memberId"
												placeholder="아이디를 입력해주세요." value="" required></td>
										</tr>
										<tr>
											
											<td style="border-bottom: 1px solid #ebebeb;"><input
												class="w3-input" type="text" id="memberName"
												name="memberName" placeholder="이름을 입력해주세요." value=""
												required></td>
										</tr>
										<tr>
											<td style="border-bottom: 1px solid #ebebeb;"><input
												class="w3-input" type="text" id="memberEmail"
												name="memberEmail" placeholder="이메일을 입력해주세요."
												value="" required></td>
										</tr>
								</table>
							</div>

							<p class="w3-center findidBtn"
								style="display: flex; align-items: center; justify-content: center; margin: 2em">
								<button style="background-color:black; color:white;" type="button" class="btn-sign-in" onclick="findPwAction();"
									class="btn btn-primary btn-user btn-block">임시 비밀번호 발송</button>
							</p>
							
						<table>
							<tr>
								<td>
									
										<p class="w3-center findidBtn"
											style="display: flex; padding-top:30px; align-items: center; justify-content: center;">
											<a class="small" href="/login/signup">아직 회원이 아니신가요?
												<button type="button" id='findPwbtn' onclick=""
													class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
													style="width: 100px; height: 30px; border: 1px solid #ebebeb; background-color: #fff; border-radius: 20px;">회원가입</button>
											</a>
										</p>
									
								</td>
							</tr>
							<tr>
								<td>
									
										<p class="w3-center findidBtn"
											style="display: flex; padding-top:30px; align-items: center; justify-content: center;">
										<a class="small" href="/login/login">이미 회원이신가요?
											<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
												style="width: 100px; height: 30px; border: 1px solid #ebebeb; background-color: #fff; border-radius: 20px; margin: left;">로그인</button>
										</a>
										</p>
									
								</td>
							</tr>
						</table>
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