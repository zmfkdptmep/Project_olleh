<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>reservation</title>
    <link rel="stylesheet" href="./css/host/host.css">

<style type="text/css">
	select {
    	border-radius: 0 !important;
	}
	
    tbody tr {
        line-height:30px;
    }
</style>

<script>
    function retrieveReservation() {
        var selectedRoomNo = document.querySelector("#roomSelect").value; // 선택한 객실의 roomNo 값
    }
</script>
</head>

   <body style="">
   
   <!-- 헤더 -->
<%@ include file="../../common/header.jsp" %>

<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
               title="googletagmanager-iframe" style="display:none;visibility:hidden"></iframe></noscript>
       <div id="fb-root" class=" fb_reset">
           <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
           <div style="position: absolute; top: -10000px; width: 0px; height: 0px;">
               <div></div>
           </div>
       </div>
      
       <script src="/static/js/common.js"></script>
       <div id="__next" data-reactroot="">
           <div>
               <div class=""></div>
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
                           <div class="my-count" role="link" tabindex="0">MY RESERVATION</div>
                       </div>
                       <div class="newmypage_menu pc_only">
                           <ul>
                               <li class=""><a href="./stayhost">숙소 관리</a></li>
                               <li class="active"><a href="./reservation">예약 관리 </a></li>
                               <li class=""><a href="./income">수입 현황</a></li>
                               <li class=""><a href="./guide">호스트가이드</a></li>
                               <li class=""><a href="./infoHost">회원 정보 수정</a></li>
                               <li class=""><a href="./message">메시지</a></li>
                           </ul>
                       </div>
                       <!-- 객실 검색 -->
				    	<div style="display: flex; justify-content: center; align-items: center;">
						    <form action="/member/host/reservation" method="post">
						        <div style="display: flex;">
						            <select name="selectedRoomNo" class="form-select" aria-label="Default select example" style="height: 40px; width: 300px; flex: 1;">
						                <option >객실 선택</option>
						                <c:forEach items="${name}" var="name" step="1">
						                    <option value="${name.roomNo}" ${paramRoomNo == name.roomNo ? 'selected' : ''} >${name.roomName} </option>
						                </c:forEach>
						            </select>
						            <button type="submit" class="btn btn-outline-dark" style="border-radius: 0; margin-left:20px;">조회</button>
						        </div>
						    </form>
						</div>


						<div style="height:50px;"></div>
                       
                       <!-- 객실 정보 출력 -->
                       <div class="mypage_content">
                           <div class="reserv_wrap mypage-reservation-info">
								<div class="container">
                                     <p class="name"><span class="ellipsis"></span></p>
                                <table class="table">
								    <thead>
								    <c:if test="${not empty list}">
								        <tr>
								            <th>객실명</th>
								            <th>회원 아이디</th>
								            <th>예약일</th>
								            <th>체크인</th>
								            <th>체크아웃</th>
								            <th>예약 인원</th>
								        </tr>
								    </c:if>
								    </thead>
								    <tbody>
								        <!-- ▶▶▶ forEach ▶▶▶ -->
								        <c:forEach items="${list}" var="reserve" step="1">
				                        
								
								            <c:if test="${empty reserve}">
								                    <tr>
								                        <td colspan="6">예약된 내역이 없습니다</td>
								                    </tr>
								            </c:if>
								                <tr>
								                    <td>${reserve.ROOMNAME}</td>
								                    <td>${reserve.RESERVATIONMEMBERID}</td>
								                    <td>${reserve.REGDATE}</td>
								                    <td>${reserve.CHECKIN}</td>
								                    <td>${reserve.CHECKOUT}</td>
								                    <td>${reserve.MEMBERCOUNT}</td>
								                </tr>
								        </c:forEach>
			                           
								    </tbody>
								</table>
								
                                </div>
                           </div>

                           <div class="paging"><a href="/" class="prev" title="이전 페이지">이전 페이지</a><a href="/"
                                   class="on">1</a><a href="/" class="next" title="다음 페이지">다음 페이지</a></div>
                       </div>
                   </div>
               </div>
               
           </div><button class="custom-button-1"></button>
       </div>
      


<!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>

</body>

</html>
</html>