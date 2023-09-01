<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message</title>
    <link rel="stylesheet" href="./css/host/host.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
</head>
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
                               <li class=""><a href="./reservation">예약 관리 </a></li>
                               <li class=""><a href="./income">수입 현황</a></li>
                               <li class=""><a href="./guide">호스트가이드</a></li>
                               <li class=""><a href="./infoHost">회원 정보 수정</a></li>
                               <li class="active"><a href="./message">메세지</a></li>
                           </ul>
                       </div>
                       <div class="mypage_content">
                           <div class="reserv_wrap mypage-reservation-info">
								<div class="container">
								<div class="stay_view">
										<!-- ▶▶▶ forEach ▶▶▶ -->
								    
                                 </div>
                                 
                                     
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
    

										
								    
								
								
                                
                           </div>
                           

                           <!-- =============================== 페이징 ============================================-->
                         <div style="height:100px;" class="paging">
							<a id="messageRoomPrevBtn" class="prev" title="이전 페이지">이전 페이지</a>
							<a class="on">${pageNo}</a>
							<a id="messageRoomNextBtn" class="next" title="다음 페이지">다음 페이지</a>
							<input type="hidden" id="pageNow" value="${pageNo}">
						</div>
                       </div>
                   </div>
               </div>
               
           </div><button class="custom-button-1"></button>
       </div>
      


<!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>

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
				
				location.href='/member/host/message?pageNo='+pageMove;
				
			}
			
			
		});
		
		$('#messageRoomNextBtn').click(function(){
			
			var pageCal = parseInt(pageNow);
			var pageMove = pageCal+1;
			
			if(pageCal<parseInt('${pageEnd}')){
				
				location.href='/member/host/message?pageNo='+pageMove;
			}
			
		});
		
		
	});

</script>

</html>
</html>