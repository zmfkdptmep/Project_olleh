<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>cancel</title>
    <link rel="stylesheet" href="/resources/css/mypage/cancel.css">
    <style>
    	#mapi{
    		pointer-events: none;
    		cursor: default !important;
    	}
    </style>
</head>

<body>
<!-- 헤더 -->
<%@ include file="../../common/header.jsp" %>

    <body style=""><noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
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
                        <div class="tit">MY PAGE</div>
                    </div>
                    <div class="container mypage_wrap">
                        <div class="mypage_myinfo">
                            <!-- =============================== 이름 ============================================-->
                            
                            <c:if test="${sessionScope.member.snsCk eq 'Y'}" var="sns">
                            	<div class="tit">${sessionScope.member.memberName}님 반가워요!</div>
                            </c:if>
                            <c:if test="${not sns}">
                            	<div class="tit">${sessionScope.memberId}님 반가워요!</div>
                            </c:if>
                            <div class="my-count" role="link" tabindex="0">함께  ${travelCnt }번의 여행을 했어요.</div>
                        </div>
                        <div class="newmypage_menu pc_only">
                            <ul>
                                <li class=""><a href="./reservation">예약 정보</a></li>
								<li class="active"><a href="./cancel">취소 내역</a></li>
								<li class=""><a href="./likestay">관심 스테이</a></li>
								<li class=""><a href="./info">회원 정보 수정</a></li>
								<li class=""><a href="./message">메시지</a></li>
                            </ul>
                        </div>
                        <div class="mypage_content">
                        
                        <c:if test="${empty list}">
							<div style="text-align: center;">
								<img src="/resources/images/no.png" class="img-booking-waiting" alt="img-booking-wating">
								<br>
								<p style="line-height: 1.5;">아직 예약 정보가 없습니다.<br class="mo_only"> 새로운 스테이를 찾아 떠나보세요.</p>
							</div>
						</c:if>
                        
                         <c:forEach items="${list}" var="list" step="1">
                         <c:if test="${sessionScope.memberId == list.MEMBERID}">
                        
                            <div class="reserv_wrap mypage-reservation-info">
                                <div class="reserv_box canceled">
                                    <div class="reserv_name">
                                        <p class="label">게스트 예약 취소</p>
                                        <!-- =============================== 숙소 이름 ============================================-->
                                        <p class="name"><span class="ellipsis">${list.STAYNAME }</span></p>
                                    </div>
                                    <div class="stay_view">
                                        <!-- =============================== 숙소 썸네일 url ============================================-->
                                        <div id="mapi" class="photo"
                                            style="background-image: url('/resources/images/${list.MAINPIC1.replace('\\','/')}'); background-repeat: no-repeat; background-position: center center; background-size: cover; cursor: default !important;">
                                            <span class="view" style="display:none;">스테이 보기</span></div>
                                    </div>
                                        <div class="reserv_info">
                                            <!-- =============================== 체크인 체크아웃 ============================================-->
                                            <div class="day">${list.CHECKIN } ~
                                                ${list.CHECKOUT }</div>
                                            <div class="option">성인 ${list.MEMBERCOUNT }명<br></div>
                                            <!-- =============================== 상세 보기 ============================================-->
                                        </div>
                                        <!-- =============================== 가격 & view ============================================-->
										<div class="price">₩ ${list.amount }</div> <br>
                                    </a>
                                </div>
                            </div>
                            
                            </c:if>
                        	</c:forEach>
                        
                            <!-- =============================== 페이징 ============================================-->
                            					<div class="paging">
							<a id="messageRoomPrevBtn" class="prev" title="이전 페이지">이전 페이지</a>
							<a class="on">${pageNo}</a>
							<a id="messageRoomNextBtn" class="next" title="다음 페이지">다음 페이지</a>
							<input type="hidden" id="pageNow" value="${pageNo}">
							
						</div>
						
						
			<script>
			
			
				window.addEventListener('load', function(){
					
					
	
					
					
					var pageNow = $('#pageNow').val();
					
					$('#pageNow').change(function(){
						
						pageNow = $('#pageNow').val();
						
					});
					
					$('#messageRoomPrevBtn').click(function(){
						
						var pageCal = parseInt(pageNow);
						var pageMove = pageCal-1;
						
						if(pageMove>=1){
							
							location.href='/member/mypage/cancel?pageNo='+pageMove;
							
						}
						
						
					});
					
					$('#messageRoomNextBtn').click(function(){
						
						var pageCal = parseInt(pageNow);
						var pageMove = pageCal+1;
						
						if(pageCal<parseInt('${pageEnd}')){
							
							location.href='/member/mypage/cancel?pageNo='+pageMove;
						}
						
					});
					
					
				});

		</script>        
                                    
                                    
                                    
                                    
                                    
                            <a href="/stay/list"><button type="button" class="btn_bk btn_sm findstay_btn" style="margin-top: 20px; margin-bottom: 20px;">FIND STAY</button></a>
                        </div>
                    </div>
                </div>
                
  
    <!-- 푸터 -->
	<%@ include file="../../common/footer.jsp" %>
    </body>
</body>

</html>