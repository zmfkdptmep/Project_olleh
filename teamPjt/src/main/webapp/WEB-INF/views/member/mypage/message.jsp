<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

   <style>
        body {
            font-family: Arial, sans-serif;
        }
        .room-list {
            list-style: none;
            padding: 0;
        }
        .room-item {
            border-bottom: 1px solid #ddd; /* 변경: border-bottom 추가 */
            padding: 10px;
            margin: 5px;
            cursor: pointer;
            width: 500px;
        }
        .room-title {
            font-weight: bold;
            margin-top: 20px; /* 추가: 타이틀 위 여백 */
            margin-left: 15px;
        }
        .divider {
            border-top: 1px solid #ddd; /* 추가: 분할선 디자인 */
            margin-top: 20px; /* 추가: 분할선 위 여백 */
            width: 500px;
            margin-left: 5px;
        }
        .room-item {
		    opacity: 0; 
		    transition: opacity 0.5s; 
		}
		
		.fade-in {
		    opacity: 1; 
		}
    </style>


<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- css -->
<link rel="stylesheet" href="/resources/css/mypage/reservation.css">


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

						<div class="my-count" role="link" tabindex="0">함께 ${travelCnt }번의 여행을 했어요.</div>
					</div>
					<div class="newmypage_menu pc_only">
						<ul>
							<li class=""><a href="./reservation">예약 정보</a></li>
							<li class=""><a href="./cancel">취소 내역</a></li>
							<li class=""><a href="./likestay">관심 스테이</a></li>
							<li class=""><a href="./info">회원 정보 수정</a></li>
							<li class="active"><a href="./message">메시지</a></li>
						</ul>
					</div>
					<div class="mypage_content">
						<div class="room-title">방 목록</div>
						    <div class="divider"></div> <!-- 추가: 분할선 -->
						    
						    <ul class="room-list">
						    		
					    		<c:forEach items="${messageRoomList}" var="messageRoom">
					    			<c:if test="${not empty messageRoom.memberId}">
							            <li class="room-item" onclick="location.href='/chat/chat?roomId=${messageRoom.roomId}&stayNoMsg=${messageRoom.stayNo}'">
							                방 번호: ${messageRoom.roomId} | 회원 아이디: ${messageRoom.memberId} | 방 이름: ${messageRoom.roomName} | 스테이 번호 : ${messageRoom.stayNo}
							            </li>
						            </c:if>
					            </c:forEach>
    						</ul>
			<script>
			    var socket = new SockJS('http://localhost:8080/echo?socketType=updateRooms');
			    
			    socket.onmessage = function(event) {
			        var data = JSON.parse(event.data);
			        if (data.type === "ROOM_UPDATE") {
			            console.log('Received room update', data);
			            updateRoomList(data.rooms);
			        }
			    };
			    
			    function updateRoomList(rooms) {
			        var roomListElement = document.querySelector(".room-list");
			        roomListElement.innerHTML = '';

			        rooms.forEach(function(room, index) {
			            
			            var listItem = document.createElement('li');
			            listItem.className = "room-item";
			            listItem.onclick = function() {
			                location.href = '/chat/chat?roomId=' + room.roomId + '&stayNoMsg=' + room.stayNo;
			            };
			            listItem.textContent = '방 번호: ' + room.roomId + ' | 회원 아이디: ' + room.memberId + ' | 방 이름: ' + room.roomName + ' | 스테이 번호 : ' + room.stayNo;
			            roomListElement.appendChild(listItem);
			            
			            // Add a slight delay to give the fade-in effect
			            setTimeout(function() {
			                listItem.classList.add('fade-in');
			            }, 100 * index); // 100ms delay for each item, you can adjust this value to control the delay between fade-ins
			        });
			    }
			    
			    $(function(){
			    	
			    	$('.room-item').attr('style','opacity:1');
			    	
			    });
			</script>
	 
					
					
					
					
					

						<!-- =============================== 페이징 ============================================-->
						<div class="paging">
							<a id="messageRoomPrevBtn" class="prev" title="이전 페이지">이전 페이지</a>
							<a class="on">${pageNo}</a>
							<a id="messageRoomNextBtn" class="next" title="다음 페이지">다음 페이지</a>
							<input type="hidden" id="pageNow" value="${pageNo}">
							
						</div>
						<a href="/stay/list"><button type="button" class="btn_bk btn_sm findstay_btn" style="margin-top: 20px; margin-bottom: 20px;">FIND STAY</button></a>
					</div>
				</div>
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
				
				location.href='/member/mypage/message?pageNo='+pageMove;
				
			}
			
			
		});
		
		$('#messageRoomNextBtn').click(function(){
			
			var pageCal = parseInt(pageNow);
			var pageMove = pageCal+1;
			
			if(pageCal<parseInt('${pageEnd}')){
				
				location.href='/member/mypage/message?pageNo='+pageMove;
			}
			
		});
		
		
	});

</script>

<!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>


</html>