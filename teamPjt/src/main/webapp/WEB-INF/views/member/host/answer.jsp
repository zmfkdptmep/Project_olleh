<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>answer</title>
    <link rel="stylesheet" href="./css/host/host.css">


<script type="text/javascript">
	function goList(){
		window.location.assign('/member/host/qaList');
	};
</script>

<style>
	.form-control {
	    border-radius: 0 !important;
	}
</style>
</head>



<body style="">
<!-- 헤더 -->
<%@ include file="../../common/header.jsp" %>
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
               title="googletagmanager-iframe" style="display:none;visibility:hidden"></iframe></noscript>
     <div id="fb-root" class=" fb_reset">
         <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
         <div style="position: absolute; top: -10000px; width: 0px; height: 0px;">
         </div>
     </div>
    
     <script src="/static/js/common.js"></script>
     <div id="next" data-reactroot="">
         <div>
             <div id="gnbBgColor">
             </div>
             <div id="contents">
                 <div class="container sub_title">
                     <div class="tit">HOST PAGE</div>
                 </div>
                 <div class="container mypage_wrap">
                     <div class="mypage_myinfo">
                         <!-- =================================== host 이름 !!!! =================================== -->
                         <div class="tit">HOST ${sessionScope.memberId}</div>
                         <div class="my-count" role="link" tabindex="0">HOST GUIDE</div>
                     </div>
                     <div class="newmypage_menu pc_only">
                         <ul>
                             <li class=""><a href="./stayhost">숙소 관리</a></li>
                             <li class=""><a href="./reservation">예약 관리 </a></li>
                             <li class=""><a href="./income">수입 현황</a></li>
                             <li class="active"><a href="./guide">호스트가이드</a></li>
                             <li class=""><a href="./message">메세지</a></li>
                         </ul>
                     </div>
                     <div class="mypage_content">
                     
                     <!-- 문의 요청 -->
                     <form>
	                    <div class="mb-3">
							  <label for="title" class="form-label">제목</label>
							  <input type="text" class="form-control" id="title" name="title" value="${que.title }" style="font-size:15px" readonly>
						</div>
						<div class="mb-3">
							  <label for="content" class="form-label">내용</label>
							  <textarea class="form-control" id="content" rows="10" name="content" style="font-size:15px" readonly> ${que.content } 
							 
							  </textarea>
						</div>
					</form>
					
					<div style="height:30px"></div>
					
					<c:if test="${not empty answer.answerInfo}">

						<!-- admin 답변 보기 -->
	                 	<form>
	                 		문의 답변
							<div class="mb-3">
								  <label for="answerInfo" class="col-sm-2 col-form-label"></label>
								  <textarea class="form-control" id="answerInfo" rows="10" 
								  name="answerInfo" style="font-size:15px; background-color:white" >${answer.answerInfo }
								  </textarea>
							</div>
						</form>
					</c:if>
                     
					<div style=" float: right">
						<button type="button" class="btn btn-outline-dark btn-sm" onclick="goList()">문의 목록 바로가기</button>
					</div>
                     
                 </div>
             </div>

 <!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>
</body>

</html>