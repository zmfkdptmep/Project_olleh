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
<style>
	.tit, .txt{
		font-weight: bold;
	}

</style>
<script>
var path = "${pageContext.request.contextPath }";

$(document).ready(function() {
var msg = "${msg}";
if(msg != ""){
alert(msg);    
}
});
	// 아이디 찾기
	function findIdAction() {
		// 유효성 체크
		var emailCk =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
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
			 
			if(!emailCk.test($("#memberEmail").val())){
			alert("이메일 형식에 맞게 입력해주세요.");
			return false;
			}
			 
			 
			if (confirm("아이디를 찾으시겠습니까?")) {
			 
			$("#findIdform").submit();
			 
			return false;
			}
	};
</script>		
<body>

<form id="findIdform" name="findIdform" action="${path}/login/findIdAction" method="post">
<div id="contents">
	<div class="container sub_title">
		<div class="tit">FIND ID</div>
		<div class="txt" style="font-weight: bold;">아이디 찾기</div>
	</div>
	<div class="container">
		<div class="login_wrap">
			<div class="txt">이름과 이메일을 입력하세요.</div>
			<div class="w3-content w3-container w3-margin-top">
				<div class="w3-container w3-card-4">
					<div class="w3-center w3-large w3-margin-top">
					<div>
						<table style="width: 100%; height: 50%; line-height: 55px;">
						  <tr>
						   
						    <td style="border-bottom: 1px solid #ebebeb;">
						      <input style="padding-left:10px; font-size: 15px;" class="w3-input" type="text" id="memberName" name="memberName" placeholder="이름을 입력해주세요." value="" required>
						    </td>
						  </tr>
						  <tr>
						    
						    <td style="border-bottom: 1px solid #ebebeb;">
						      <input style="padding-left:10px; font-size: 15px;" class="w3-input" type="text" id="memberEmail" name="memberEmail" placeholder="이메일을 입력해주세요." value="" required>
						    </td>
						  </tr>
						</table>
						<div id="resultDiv"></div>
					</div>

							<p class="w3-center findidBtn" style="display: flex; align-items: center; justify-content:center; margin:5em;" >
								<button type="button" id='findIdbtn' onclick="findIdAction()"
									class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
									style="margin-right: 15px;width: 250px; height: 40px; border: 1px solid #ebebeb; background-color: black; color: white; border-radius:20px;">FIND</button>
								<button type="button" onclick="history.go(-1);"
									class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" 
									style="width: 250px; height: 40px; border: 1px solid #ebebeb; background-color: #fff; border-radius:20px; margin: right;">CANCLE</button>
							</p>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>


</form>
</body>
<jsp:include page="../common/footer.jsp" />
</html>