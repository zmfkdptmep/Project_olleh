<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<!DOCTYPE html>
<html>
<style>
	#ENTER > span , #OUT, #ENTER{
    
    font-style: italic;
    
    font-weight:300;
    color: black;
}

</style>
<head>
    <link href="/resources/css/reserved/calendar.css" rel="stylesheet" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <script src='/resources/js/reserved/payment.js'></script>
    <meta charset="UTF-8">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body onbeforeunload="exit()">
    <jsp:include page="../common/header.jsp" />
 
    <div style="position: absolute; top: 80px; width: 100%; text-align: center; padding: 38px; border-bottom: 1px solid rgb(242, 242, 242); background-color: white;">
        <p style="letter-spacing: 15px; text-indent: 15px; margin-bottom: 12px; font-family: Lato-Bold;">MESSAGE</p>
        <p style="font-size: 12px;">호스트와 대화를 나눠보세요.${sessionScope.role_id}</p>
    </div>
    <div id="contents" style="position: absolute; top:200px; width: 100%; text-align: center;">
        <div>
            <div class="chat-list-pc" style="position: relative; align:right;">
                <hr style="position:absolute;color: #f2f2f2; opacity: 1; height:30px; width:100%; top:5%;">
                <div id="messageList" style=" position:absolute; left:0;display: inline-block;text-align: center;  width:30%; height: 100%; border:1px solid #f2f2f2;">
                    <img onclick="userWantsToExit()" src="https://chat.stayfolio.com/img/back.svg" style="vertical-align: middle; border: 0; position: absolute; top: 7px; left: 20px; cursor: pointer;">
                    <span id="backBtn" style="position: absolute; top: 20px; left: 80px; font-size: 20px; font-weight: bold;">
                        메시지
                    </span>
                    <div id="messageRoom" style="position: absolute; background-color: white; width: 100%; height: 87.6%; top: 7%; vertical-align: text-bottom;">
                    	
						    <input type="hidden" id="myMemberId" value="${sessionScope.memberId}" required readonly><br>
						    초대할 아이디:<br><br>
						     <input style="border:1px solid #f2f2f2; width:80%; text-align:center;" type="text" id="targetMemberId" required><br>
						   	<input type="hidden" id="roomId" value="${roomId}" required readonly><br>
						    <button id="inviteBtn" style="padding-bottom:50px;">초대하기</button>
                    </div>
                    
                    <script>
                    
                    
                    
                    
                    
                    $(document).ready(function() {
                        $('#inviteBtn').click(function() {
                            var inviteData = {
                                myMemberId: $('#myMemberId').val(),
                                targetMemberId: $('#targetMemberId').val(),
                                roomId: $('#roomId').val()
                            };

                            $.ajax({
                                url: '/chat/inviteAction',
                                method: 'POST',
                                contentType: 'application/json',
                                data: JSON.stringify(inviteData),
                                success: function(response) {
                                    if (response.status === 'success') {
                                        console.log('Invitation sent successfully:', response.msg);
                                        sock.send ('<span id="INVITE" style="font-weight:bold; font-size:1.3em;">'+$('#myMemberId').val()+'님이 '+$('#targetMemberId').val()+'님을 '+ $('#roomId').val()+'번 방에 초대하셨습니다.</span>');
                                    } else {
                                        console.log('Failed to send invitation:', response.msg);
                                        sock.send('초대에 실패하였습니다. 원준에게 문의해 주세요.');
                                    }
                                },
                                error: function(error) {
                                    console.log('Error:', error);
                                }
                            });
                        });
                    });
                    </script>
 
                    
                    
                    
                </div>
                <div id="messageArea" style="position: absolute; right: 0; display: inline-block; text-align: center; width: 70%; height: 100%; vertical-align: bottom;">
                    <div id="chatList" style="position: absolute; background-color: white; width: 100%; height: 87.6%; top: 7%; overflow-y: scroll; vertical-align: text-bottom; line-height:40px;">
                    
                    <!-- 채팅이 생성되는 곳 -->
                    
                    <c:forEach items="${messageHistory}" var="history">
                    	
                    	<span style="font-weight:bold;">
                    		${history.content}
                    	</span>
                    	<br>
                    </c:forEach> 
                    
                    </div>
                    <div id="messageBtn" style="position: absolute; bottom: 0; width: 100%; border: 1px solid #f2f2f2;">
                        <input type="text" id="message" style="width: 300px; border: 1px solid #f2f2f2;" />
                        <input type="button" class="btnStyle" id="sendBtn" value="전송" style="border: 1px solid #f2f2f2;" />
                        <input type="button" class="btnStyle" onclick="userWantsToExit()" value="퇴장" style="border: 1px solid #f2f2f2;" />
                        <input type="button" class="btnStyle" id="cleanBtn" value="clean" style="border: 1px solid #f2f2f2;" />                    	
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </div>
    <input type="hidden" id="currentRoomId" value="${roomId}">
</body>

<script type="text/javascript">
    var message = '';
    var role = '';
    if('${sessionScope.role_id}'=='[host]'){
    	role = '<호스트>';
    } else {
    	role = '<유저>';
    }
    
    var memberId = '${sessionScope.memberId}';
    var content = '';
    var type = '';
    var enterMsg = '';

    // 엔터키로 바로 전송
    document.getElementById('message').addEventListener('keydown', function(event) {
        if (event.keyCode === 13 && document.activeElement === this) {
            enterMsg = '';
            if ($("#message").val().trim() !== '') {
                // 길이 제한
                if ($("#message").val().length > 85) {
                    $("#message").val('메세지는 85자를 초과할 수 없습니다.');
                } else {
                	type = 'TALK';
                    content = $('#message').val();
                    sendMessage(content);
                    $('#message').val('');
                }
            }
        }
    });

    $("#sendBtn").click(function() {
        enterMsg = '';
        if ($("#message").val().trim() !== '') {
            // 길이 제한
            if ($("#message").val().length > 85) {
                $("#message").val('메세지는 85자를 초과할 수 없습니다.');
            } else {
            	type = 'TALK';
                content = $('#message').val();
                sendMessage(content);
                $('#message').val('')
            }
        }
    });

    
    let sock;
    
    
    let wantExit = false;
    
    function connection(){
    	
    	
    	sock = new SockJS(`http://localhost:8080/echo?roomId=${roomId}&socketType=chat&stayNoMsg=${stayNoMsg}`);
	    console.log('sock : ', sock);
	    sock.onmessage = onMessage;
	    sock.onclose = onClose;
    	
	    sendEnterMessage();
    }
    
 	// 사용자가 의도적으로 나가는 경우의 함수
    function userWantsToExit() {
        wantExit = true;
        exit2();
    }

    window.addEventListener('load', connection);
    

    sock.onerror = function(event) {
    	setTimeout(connection, 2000);
    };

    // 메시지 전송
    function sendMessage() {
       
    	if(role=='<유저>'){
    		
	        sock.send("<span style='color:blue;'>"+ role +"</span>${memberName}님의 메세지 : <span style='color:black;'>"+$("#message").val()+"</span>");
    	} else {
    		
	        sock.send("<span style='color:brown;'>"+ role +"</span>${memberName}님의 메세지 : <span style='color:black;'>"+$("#message").val()+"</span>");
    	}
    }

 // 서버로부터 메시지를 받았을 때
    function onMessage(msg) {
       	
        message = msg.data;
        let roomId = '${roomId}';
		
        // 초대 메시지 확인
        if (message.includes("님이") && message.includes("번 방에 초대하였습니다.")) {
            // 초대 메시지는 무시하고 반환
            return;
        }

		

        var regDate = new Date(msg.timeStamp);
        var data = {
            content: content,
            regDate: regDate,
            writer: memberId,
            roomId: roomId,
        };
        
        	// 채팅 메세지 출력
			
		           $("#chatList").append("<span style='font-weight:bold;'>" + message + "</span><br>");
			
			         
    }
 	
 
 
 	
    // 서버와 연결을 끊었을 때
	function onClose(evt) {
		
	    if(!wantExit) {
		    sock = null;
	        console.log('님 컴이 꾸져서 연결이 끊겼습니다... 재접속합니다');
	        setTimeout(connection, 2000);
	    } else {
	    	
	    	if(role == '<호스트>'){
	    		
		        console.log('당신 스스로 퇴장을 선택하였습니다');
		        location.href='/member/host/message';
		        
	    	} else {
	    		
		        console.log('당신 스스로 퇴장을 선택하였습니다');
		        location.href='/member/mypage/message';
	    		
	    	}
	    	
	    }

	    
	}

	
	
	
    // 현재 시간 출력 함수
    function formatAndDisplayDate() {
            const currentDate = new Date();
            const year = (currentDate.getFullYear() % 100).toString();
            const month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
            const day = ('0' + currentDate.getDate()).slice(-2);
            const hours = ('0' + currentDate.getHours()).slice(-2);
            const minutes = ('0' + currentDate.getMinutes()).slice(-2);

            const formattedDate = "(" + year + "/" + month + "/" + day + " " + hours + ":" + minutes + ")";
            
            return formattedDate;
     }
    
    // 퇴장 메세지 출력
	async function exit() {
	    console.log('exit() 함수가 실행됩니다.');
		
	    // 메시지 전송
	    if (role == '<호스트>') {
	        sock.send("<span style='color:brown;'>" + role + "</span><span id='OUT' style='padding:5px; color:red;'>${memberName}님 " + roomId.value + "번 채팅방 연결 해제</span><span id='OUT'>" + formatAndDisplayDate() + "</span>");
	    } else {
	        sock.send("<span style='color:blue;'>" + role + "</span><span id='OUT' style='padding:5px; color:red;'>${memberName}님 " + roomId.value + "번 채팅방 연결 해제</span><span id='OUT'>" + formatAndDisplayDate() + "</span>");
	    }
		
	    // 메시지를 전송한 후 약간의 시간 대기
	    await new Promise(resolve => setTimeout(resolve, 4000)); // 500ms 대기. 필요한 경우 시간을 조절해볼 수 있습니다.
		
	    // 연결 종료
	    sock.close();
	}
    
	async function exit2() {
	    console.log('exit() 함수가 실행됩니다.');
		
	    // 메시지 전송
	    if (role == '<호스트>') {
	        sock.send("<span style='color:brown;'>" + role + "</span><span id='OUT' style='padding:5px; color:red;'>${memberName}님 " + roomId.value + "번 채팅방 연결 해제</span><span id='OUT'>" + formatAndDisplayDate() + "</span>");
	    } else {
	        sock.send("<span style='color:blue;'>" + role + "</span><span id='OUT' style='padding:5px; color:red;'>${memberName}님 " + roomId.value + "번 채팅방 연결 해제</span><span id='OUT'>" + formatAndDisplayDate() + "</span>");
	    }
		
	    // 메시지를 전송한 후 약간의 시간 대기
	    await new Promise(resolve => setTimeout(resolve, 500)); // 500ms 대기. 필요한 경우 시간을 조절해볼 수 있습니다.
		
	    // 연결 종료
	    sock.close();
	}
	    
    // 입장 메세지 출력
 	function sendEnterMessage() {
    setTimeout(function() {
    	type ='ENTER'
    	if(role=='<호스트>'){
    		
	        sock.send("<span style='color:brown;'>"+ role +'</span><span id="ENTER" style="color:red">${enter}</span>');
    	} else {
    		
	        sock.send("<span style='color:blue;'>"+ role +'</span><span id="ENTER" style="color:red">${enter}</span>');
    	}
    }, 1000);

    // 한번 동작 후 이벤트 핸들러를 제거합니다.
    //window.removeEventListener('load', sendEnterMessage);
	}
        
	// 페이지 로드 시 sendEnterMessage 함수를 호출합니다.
	//window.addEventListener('load', sendEnterMessage);   
</script>

<script>
	const chatList = document.getElementById("chatList");
	
	// 스크롤이 활성화되었을 때 맨 아래로 스크롤하는 함수
	function scrollToBottom() {
	  chatList.scrollTop = chatList.scrollHeight;
	}
	
	// 페이지 로드 후 처음에도 맨 아래로 스크롤
	scrollToBottom();
	
	// 내용이 업데이트되었을 때마다 맨 아래로 스크롤 유지
	chatList.addEventListener("DOMSubtreeModified", scrollToBottom);
	
	
	cleanBtn.addEventListener("click", function(){
		
		chatList.innerHTML = "";
	});
</script>


<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="/resources/js/reserved/calendar.js"></script>
</html>