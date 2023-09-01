<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- js -->
<script src='/resources/js/reserved/payment.js'></script>
<!-- css -->
<link rel="stylesheet" href="/resources/css/mypage/reservation.css">
<style>

	.active{font-weight: 530;}
</style>
</head>


<body>
<!-- 헤더 -->
<%@ include file="../../common/header.jsp" %>

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

	<script src="/static/js/common.js"></script>
	<div id="__next" data-reactroot="">
		<div>
			<div class=""></div>
			<div id="gnbBgColor"></div>
			<div id="contents">
				<div class="container sub_title">
					<div class="tit">MY PAGE</div>
				</div>
				<div class="container mypage_wrap">
					<div class="mypage_myinfo">
						<!-- =================================== user 이름 !!!! =================================== -->
						                            <c:if test="${sessionScope.member.snsCk eq 'Y'}" var="sns">
                            	<div class="tit">${sessionScope.member.memberName}님 반가워요!</div>
                            </c:if>
                            <c:if test="${not sns}">
                            	<div class="tit">${sessionScope.memberId}님 반가워요!</div>
                            </c:if>

						<div class="my-count" role="link" tabindex="0">함께  ${travelCnt } 번의 여행을 했어요.</div>
					</div>
					<div class="newmypage_menu pc_only">
						<ul>
							<li class="active"><a href="./reservation">예약 정보</a></li>
							<li class=""><a href="./cancel">취소 내역</a></li>
							<li class=""><a href="./likestay">관심 스테이</a></li>
							<li class=""><a href="./info">회원 정보 수정</a></li>
							<li class=""><a href="./message">메시지</a></li>
						</ul>
					</div>
<div class="mypage_content reservation">
    <div class="reserv_detail">
        <div class="stay_info">
            <div class="photo" style="background-image: url('/resources/images/${mainImg.replace('\\','/')}'); background-repeat: no-repeat; background-position: center center; background-size: cover;">
            </div>
            <div class="info">
                <div class="name"><a style="color:white" href="/findstay/vintage-jeju">${stayName}</a></div>
                <div class="contact">제주특별자치도 제주시 한경면 용수리 1502<br><a class="phone" href="tel:0504-0904-2034">0504-0904-2034</a><a class="email" href="mailto:vintagejeju@gmail.com" target="_blank" rel="noreferrer">vintagejeju@gmail.com</a></div>
            </div>
        </div>
        <div class="reserv_sec">
            <div class="title">예약 상태</div>
            <ul class="guide_step">
                <li>
                    <div class="guide_box ">
                        <div class="step" style="padding-left: 0px;"><img src="/web/images/ico_guide1.svg" alt=""><small class="pc_only">STEP 01</small><br class="pc_only">예약 신청<small class="mo_only">STEP 01</small></div>
                        <div class="desc">예약 신청이 완료되었으며, 호스트의 예약 확정 대기 상태입니다. 스테이의 예약 상황에 따라
                            취소/환불될 수 있습니다.</div>
                    </div>
                </li>
                <li>
                    <div class="guide_box active">
                        <div class="step" style="padding-left: 0px;"><img src="/web/images/ico_guide2.svg" alt=""><small class="pc_only">STEP 02</small><br class="pc_only">예약 확정<small class="mo_only">STEP 02</small></div>
                        <div class="desc">호스트가 예약을 최종 확정한 상태입니다. 예약 취소 시 각 스테이의 환불규정에 따라 환불이
                            진행됩니다.</div>
                    </div>
                </li>
                <li>
                    <div class="guide_box ">
                        <div class="step" style="padding-left: 0px;"><img src="/web/images/ico_guide3.svg" alt=""><small class="pc_only">STEP 03</small><br class="pc_only">체크인<small class="mo_only">STEP 03</small></div>
                        <div class="desc">예약 내용에 따라 스테이를 이용할 수 있습니다. 예약 당일 오전 체크인 안내를 드리고 있습니다.
                        </div>
                    </div>
                </li>
            </ul>
            
            <script>
            	
            	window.addEventListener('load', function(){
            		
            		var isAlready = '${param.already}';
            		
            		if(isAlready=='yes'){
            			
	            		$('.guide_box:eq(2)').addClass('active');
	            		$('.guide_box:eq(1)').removeClass('active');
	            		
            		
            		} else {
            			
	            		$('.guide_box:eq(1)').addClass('active');
	            		$('.guide_box:eq(2)').removeClass('active');
            			
            		}
            		
            		
            	});
            	
            	
            </script>
            
        </div>
        <div class="reserv_sec">
            <div class="title">예약 안내</div>
            <div class="reserv_guide">
                <ul class="dl">
                    <li>
                        <div class="dt">01. 예약 번호 </div>
                        <div class="dd">${param.reservationNo}<small>(예약 확정 : 2023-07-26 10:05)</small></div>
                    </li>
                    <li>
                        <div class="dt">02. 스테이 및 객실</div>
                        <div class="dd">${stayName} / ${roomName}</div>
                    </li>
                    <li>
                        <div class="dt">03. 예약 인원</div>
                        <div class="dd">총 ${memberCount}명<small> (성인: ${memberCount}명 / 아동: 0명 / 영아: 0명)</small></div>
                    </li>
                    <li>
                        <div class="dt">04. 체크인</div>
                        <div class="dd">${checkIn}</div>
                    </li>
                    <li>
                        <div class="dt">05. 체크아웃</div>
                        <div class="dd">${checkOut}</div>
                    </li>
                    <hr class="line">
                    <li>
                        <div class="dt">06. 옵션</div>
                        <div class="dd">
                            <div>옵션이 없습니다.</div>
                        </div>
                    </li>
                    <hr class="line">
                    <li>
                        <div class="dt">07. 요청사항</div>
                        <div class="dd">${talk}</div>
                    </li>
                    <hr class="line">
                    <li>
                        <div class="dt">08. 동의사항</div>
                        <div class="dd">
                            <div class="block">인원규정<p class="desc">
                                </p><div>예약 인원 초과 입실 및 방문자 출입은 불가합니다. 위반시 환불 없이 즉각 퇴실조치 됨을 사전에
                                    알려드립니다.</div>
                                <p></p>
                            </div>
                            <div class="block">금연안내<p class="desc">
                                </p><div>숙소 내 모든 공간에서의 흡연을 절대 금합니다.</div>
                                <div></div>
                                <p></p>
                            </div>
                            <div class="block">변상안내<p class="desc">
                                </p><div>숙소 내 가구 및 소품이 파손, 분실, 손상 되었을 경우 해당 제품의 구매가로 변상비를 청구합니다.
                                </div>
                                <div></div>
                                <p></p>
                            </div>
                            <div class="block">주방사용<p class="desc">
                                </p><div>고기, 해산물 등 냄새가 강하게 남는 음식의 조리를 금합니다. 바베큐 그릴은 야외에서만 이용하실 수
                                    있습니다. </div>
                                <div></div>
                                <p></p>
                            </div>
                            <div class="block">촬영 및 대관 안내<p class="desc">
                                </p><div>상업 목적의 사진/영상 촬영(광고, 쇼핑몰, SNS 마켓 등)과 드론 촬영은 불가합니다.</div>
                                <p></p>
                            </div>
                            <div class="block">고양이 출몰<p class="desc">
                                </p><div>길고양이가 많은 관계로 정원에 고양이가 출몰할 수 있습니다.</div>
                                <div>고양이를 싫어하시는 경우 신중한 예약을 부탁드립니다. 이는 환불 사유가 되지 않습니다.</div>
                                <p></p>
                            </div>
                        </div>
                    </li>
                    <hr class="line">
                    <li>
                        <div class="dt">09. 금지 조항</div>
                        <div class="dd">숙박권의 재판매, 양도, 양수, 교환을 금지합니다.<p class="desc">예약자의 부득이한
                                사유로 인해 본인 이용이 어려울 경우, 가족에 한해 해당 스테이에 가족관계임을 증명할 수 있는 서류(가족관계증명서
                                등)와 실제 이용하시는 분의 신분증을 제시 후 이용이 가능합니다.</p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="reserv_sec">
                <div class="title">결제 정보</div>
                <div class="reserv_guide">
                    <ul class="dl">
                        <li>
                            <div class="dt">01. 결제 금액</div>
                            <div class="dd">
                                <div class="price">
                                    <div>${stayName} / ${roomName}<span class="desc">${day} 박</span></div>
                                    <div>₩${dayPrice}</div>
                                </div>
                                <div class="price total">
                                    <div>총 결제 금액<span class="desc">₩${allPrice}(${paymentMethod})</span></div>
                                    <div>₩${allPrice}</div>
                                </div>
                            </div>
                        </li>
                        <hr class="line">
                        <li>
                            <div class="dt">02. 결제 방법</div>
                            <div class="dd">${paymentMethod}<small> (결제 완료 : ${paymentRegDate})</small>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="bt_btns">
            <button id="canclePayBtn" style="background-color:black; color:white;" type="button" class="btn_wh">예약 취소</button>
            <button id="messageBtn" style="background-color:#f2f2f2; color: black;" type="button" class="btn_wh">문의 하기</button>
            <button type="button" style="border: 1px solid black;" onclick="location.href='https://www.easylaw.go.kr/CSP/CnpClsMain.laf?csmSeq=835&ccfNo=4&cciNo=1&cnpClsNo=2'">이용 안내 및 환불 규정</button>
            </div>
            
        </div>
    </div>
</div>				</div>
			</div>

			<nav id="moMenu" class="mo-samll-only">
				<ul>
					<li><a class="" href="/findstay"><span>FIND STAY</span></a></li>
					<li><a class="" href="/promotions"><span>PROMOTION</span></a></li>
					<li><a class="" href="/journal"><span>JOURNAL</span></a></li>
					<li><a class="" href="/preorder"><span>PRE-ORDER</span></a></li>
					<li><a class=" false" href="/chat"><span>MESSAGE</span></a></li>
				</ul>
			</nav>
		</div>
		<button class="custom-button-1"></button>
	</div>
</body>

<!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>

<script>

	var canclePay = '${impUid}';		 // 환불할 imp_uid
	var realAmount = '${allPriceInteger}';	 // 환불할 금액

	$(function(){
			
		$('.btn_reserv_detail').click(function(){
				
			location.href='/member/mypage/reserved_detail';
			
		});
		
		$('#canclePayBtn').click(function(){
			
			canclePayFunction();
			
		});
		
		$('#messageBtn').click(function(){
			
			location.href='/chat/chat?reservationNo=${param.reservationNo}';
			
		});
		
		
	});
	
</script>

</html>