<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>answer</title>
<link rel="stylesheet" href="./css/admin.css">


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>부트스트랩 테이블</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	
<script type="text/javascript">
window.addEventListener('load', function(){
	goAnswer.addEventListener('click', function(){ 
		answering.style.display = '';
	});
});


	function goList(){
		window.location.assign('/member/admin/hosthelp');
	};
</script>

<style>
	.form-control {
	    border-radius: 0 !important;
	}
	
	.form-control:focus {
	    border-color: initial; /* 포커스 시 테두리 색상 초기화 */
	    box-shadow: none; /* 포커스 시 그림자 효과 제거 */
	}
</style>

</head>


<body>
.
	<!-- 헤더-->
	<%@ include file="../../common/header.jsp"%>

	<noscript>
		<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ"
			height="0" width="0" title="googletagmanager-iframe"
			style="display: none; visibility: hidden"></iframe>
	</noscript>
	<div id="fb-root" class=" fb_reset">
		<script async="" src="https://connect.facebook.net/en_US/all.js"></script>
		<div
			style="position: absolute; top: -10000px; width: 0px; height: 0px;">
			<div></div>
		</div>
	</div>

	<div id="__next" data-reactroot="">
		<div>
			<div class=""></div>
			<div id="gnbBgColor"></div>
			<div id="contents">
				<div class="container sub_title">
					<div class="tit">ADMIN</div>
				</div>
				<div class="container mypage_wrap">
					<div class="mypage_myinfo">
						<!-- =================================== admin  =================================== -->
						<div class="tit">관리자</div>
						<div class="my-count" role="link" tabindex="0">USER MANAGEMENT</div>
					</div>
					<div class="newmypage_menu pc_only">
						<ul>
							<li class=""><a href="./stayadmin">숙소 관리</a></li>
							<li class=""><a href="./useradmin">사용자 관리 </a></li>
							<li class="active"><a href="./hosthelp">호스트 지원</a></li>
							<li class=""><a href="./staticPage">통계 및 분석</a></li>
						</ul>
					</div>
					
					<div class="mypage_content">
                     
                     <!-- host 문의 요청 불러오기 -->
                     <form>
	                    <div class="mb-3 row">
							  <label for="title" class="col-sm-2 col-form-label">제목</label>
							  <input type="text" class="form-control" id="title" name="title" value="${que.title }" 
							  	style="font-size:15px; background-color:white" readonly>
						</div>
						<div class="mb-3 row">
							  <label for="content" class="col-sm-2 col-form-label">내용</label>
							  <textarea class="form-control" id="content" rows="10" name="content" style="font-size:15px; background-color:white" readonly>${que.content } 
							 
							  </textarea>
						</div>
						<div style=" float: right">
							<button type="button" class="btn btn-outline-dark btn-sm" onclick="goList()">문의 목록 바로가기</button>
							<button type="button" class="btn btn-outline-dark btn-sm" onclick="Answering()" id="goAnswer">답변하기</button>
						</div>
					</form>
                    
                    <div style="height:30px"></div>
                    
                    <!-- 답변 form -->
                 	<form name='answering' id="answering" style='display: none;' method="post" action="/member/admin/answering">
						 문의 번호 : <input type="textNo" name="queNo" value="${que.queNo }" style="width:15px">번
						<div class="mb-3">
							  <label for="answerInfo" class="col-sm-2 col-form-label"></label>
							  <textarea class="form-control" id="answerInfo" rows="10" 
							  name="answerInfo" style="font-size:15px; background-color:white" >${answer.answerInfo }
							  </textarea>
						</div>
						 답변 작성일 : <input type="textNo" name="queNo" value="${answer.answerDate }" style="width:40px">
						<button type="submit" class="btn btn-outline-dark btn-sm" style=" float: right">답변 보내기</button>
					</form>
					
                 </div>
                 
				</div>
			</div>
		</div>
		<button class="custom-button-1"></button>
	</div>

	<!-- 푸터 -->
	<%@ include file="../../common/footer.jsp"%>

</body>

</html>