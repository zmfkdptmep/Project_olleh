<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>likestay</title>
    <link rel="stylesheet" href="/resources/css/mypage/likestay.css">
</head>
<body>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./css/likestay.css">
</head>

    <body style="overflow: visible;">
    	    	<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0" title="googletagmanager-iframe" style="display:none;visibility:hidden">
    	</iframe></noscript>
    <!-- 헤더 -->
	<%@ include file="../../common/header.jsp" %>
        <div id="fb-root" class=" fb_reset">
            <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
            <div style="position: absolute; top: -10000px; width: 0px; height: 0px;"> </div>
        </div>
            <!-- =============================== 헤더 ============================================-->
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
								<li class=""><a href="./cancel">취소 내역</a></li>
								<li class="active"><a href="./likestay">관심 스테이</a></li>
								<li class=""><a href="./info">회원 정보 수정</a></li>
								<li class=""><a href="./message">메시지</a></li>
                            </ul>
                        </div>
                        <div class="mypage_content">
                        
                        <!-- ▶▶▶  forEach ▶▶▶  -->
                        <c:forEach items="${like}" var="like" step="1" varStatus="status">
                        <c:if test="${sessionScope.memberId == like.MEMBERID}">
                        
					        <div class="likestay_wrap">
					        <div class="likestay_box" role="presentation">
					            <div class="info_container">
					                <div class="name"><span class="ellipsis"
					                        style="padding-bottom: 0px;">${like.STAYNAME }</span><small>${like.STAYTYPE }</small></div>
					                <div class="stay">
					                    <p class="txt mo_only"><span class="ellipsis">about-flow</span></p>
					                    <p class="option">${like.STAYLOC }<br>최소 ${like.STDPERSON }명 / 최대 ${like.OVERPERSON }명<br>₩${like.PRICE }</p>
					                </div>
					                <div class="btns"><button type="button" class="btn_bk"><a href="../../../stay/room?stayName=${like.STAYNAME }" style="color:white">예약하기</a></button>
					                </div><a href="../../../stay/room?stayName=${like.STAYNAME }">
					                    <div class="likestay_img" role="presentation" style="padding-top: 0px;">
					                        <ul
					                            class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events slider1 flist_slider">
					                            <div class="swiper-wrapper">
					                                <li class="swiper-slide swiper-slide-active img"
					                                    style="background: url('/resources/images/${like.MAINPIC1.replace('\\','/')}') center center / cover no-repeat; width: 372px;">
					                                </li>
					                            </div>
					                        </ul>
					                    </div>
					                </a>
					            </div>
					        </div>
					        </div>
					        
					        </c:if>
					        </c:forEach>
					        
					    </div>
                    </div>
                            
                            <!-- ============ 페이징 =============== -->
                            <div class="paging">
                            	<a href="/" class="prev" title="이전 페이지">이전 페이지</a>
                            	<a href="/" class="on">1</a><a href="/" class="next" title="다음 페이지">다음 페이지</a>
                           	</div>
                </div>
        
        <!-- 푸터 -->
		<%@ include file="../../common/footer.jsp" %>

</body>

</html>
</body>
</html>