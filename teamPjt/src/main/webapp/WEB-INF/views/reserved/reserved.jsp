<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<link href="/resources/css/reserved/calendar.css" rel="stylesheet"/>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script src='/resources/js/reserved/payment.js'></script>
<head>
<style>
	.quantity-button{
	
		position: absolute;
		left: 35.5%;
	}

</style>

<!-- 인터넷 환경에 따라 자꾸 오류떠서 그냥 들어오면 한 번 새로고침하여 paymentNo의 값을 새로 받아옴 -->
<script type="text/javascript">
    // 페이지 로드 시 실행되는 함수
    window.onload = function() {
        // 로컬 스토리지에서 reloadStatus 값을 가져옴
        var reloadStatus = localStorage.getItem('reloadStatus');
        
        // reloadStatus 값이 없거나 'notReloaded'인 경우에만 새로고침 수행
        if (reloadStatus === null || reloadStatus === 'notReloaded') {
            // 로컬 스토리지에 reloadStatus 값을 'reloaded'로 설정
            localStorage.setItem('reloadStatus', 'reloaded');
            
            // 페이지 새로고침
            location.reload();
        } 
        else {
            // reloadStatus 값을 'notReloaded'로 다시 설정하여 
            // 다음 번 페이지 로드 시에도 새로고침이 수행될 수 있도록 함
            localStorage.setItem('reloadStatus', 'notReloaded');
        }
    }
</script>

<script>

			
			
	function btnWhenFunction(){
				
		document.querySelector("#whenModal").style.display='';
		btnYN = 'reservation';
		$('input[name=btnYN]').val('reservation');
	}
	
	function btnClose(){
		
		document.querySelector("#whenModal").style.display='none';
		$('input[name=btnYN]').val('');
		
	}

</script>
</head>

<body>
<jsp:include page="../common/header.jsp"/>
<div id="contents">
	<div class="container sub_title">
		<div class="txt">예약 페이지</div>
	</div>
	<div class="store_apply">
		
			<div class="store_apply_form">
				<ul class="form_dl">
					<li style="flex-direction: row"><span class="left"></span><span class="right">* 필수 입력 항목</span></li>
					
					<li><div class="left">예약 정보</div></li>
					<hr style="color:black; opacity: 1; height:30px;">
					<li><div class="dt">스테이 이름</div>
						<div class="dd">
							<input style="font-size: 12px; color:#666; background-color:#e6e6e6;" type="text" class="form_style" name="stayName" value="${stay.stayName}" disabled>
						</div></li>
					<hr>
					<li><div class="dt">객실 선택 *</div>
						<div class="dd">
						<!-- font-size: 12px;
    							color: #666; -->
							<input style="font-size: 12px; color:#666; background-color:#e6e6e6;" type="text" class="form_style" name="roomName" value="${room.roomName}" disabled>
						</div></li>
					<hr>
					<li><div class="dt">예약 날짜</div>
					
					
						<div class="dd">
							<c:if test="${empty reserved.checkIn}" var="res">
								<input style="font-size: 12px; color:#666; background-color:#e6e6e6;" type="text" class="form_style" name="checkInOut" value='예약 날짜를 선택해 주세요!' disabled>
								<button onclick="btnWhenFunction()" style="font-size: 12px; color:black;  text-align:left;" class="form_style" >예약 날짜 선택하기</button>
							</c:if>
							<c:if test="${not res}">
								<input style="font-size: 12px; color:#666; background-color:#e6e6e6;" type="text" class="form_style" name="checkInOut" value='${reserved.checkIn} ~ ${reserved.checkOut}' disabled>
								<button onclick="btnWhenFunction()" style="font-size: 12px; color:black;  text-align:left;" class="form_style" >예약 날짜 선택하기</button>
							</c:if>
							<script>
								$(function(){
									
									
										
										$('input[name=reserved_date]').val('${reserved_checkIn} ~ ${reserved_checkOut}');
									 
									
								});
							</script>			
						</div></li>
					
					<hr>
						<li><div class="dt" style="position:relative;">인원 수</div>
							<div class="dd">
								
									<input style="width:50px; text-align:center;font-size: 12px; color:#666; background-color:#e6e6e6;" type="text" class="form_style" id="quantity" name="quantity" value="${room.stdPerson}" disabled>
									<button type="button" style="top:46.7%;" class="quantity-button" onclick="adjustQuantity(1)">△</button>
									<button type="button" style="top:48%;" class="quantity-button" onclick="adjustQuantity(-1)">▽</button>
								
								
								<script>
									
									var stdPerson = '${room.stdPerson}'; // 최소 인원
									var overPerson = '${room.overPerson}'; // 최대 인원
								
							        function adjustQuantity(change) {
							            var quantityInput = document.getElementById("quantity");
							            var currentValue = parseInt(quantityInput.value);
							            var newValue = currentValue + change;
							            
							            if (newValue >= 1 && newValue <= overPerson) {
							                quantityInput.value = newValue;
							                memberCountValue.innerHTML = newValue+'명';
							                changeMemberCount(newValue);
							                
							            } else if (newValue > overPerson) {
							                alert('해당 스테이의 최대 인원은 ' + overPerson + '명입니다.');
							            }
							        }
								</script>			
							</div>
						</li>
					
					<hr>
					
						
					<li style="height:200px;"><div class="dt" style="position:relative;">가격</div>
						<div class="dd">
							<span style="font-size:0.85em; position:absolute; right:40%; top:56%; color: #66666682;">객실 요금</span><br>
							<span style="font-size:0.85em; position:absolute; right:3%; top:56%; color: #66666682;">₩${room.price}</span><br>
							<span style="font-size:0.85em; position:absolute; right:40%; top:59%; color: #66666682;">옵션</span><br>
							<span style="font-size:0.85em; position:absolute; right:5%; top:59%; color: #66666682;">-</span><br>
							<span style="font-size:0.85em; position:absolute; right:40%; top:62%; color: #66666682;">인원 수</span><br>
							<span style="font-size:0.85em; position:absolute; right:4%; top:62%; color: #66666682;" id="memberCountValue">${room.stdPerson}명</span><br>
							<span style="font-size:0.85em; position:absolute; right:40%; top:65%; color: #66666682;">예약일 수</span><br>
								
						<c:if test="${not empty reservedDay and reservedDay ne '0'}">									
							<span style="font-size:0.85em; position:absolute; right:4%; top:65%; color: #66666682;">${reservedDay}일</span><br>
						</c:if>	
						<c:if test="${reserved.checkIn eq '' or empty reserved.checkIn}" var='res'>
							<span style="font-size:0.85em; position:absolute; right:5%; top:65%; color: #66666682;">-</span><br>
						</c:if>
						<c:if test="${res}">
							<span style="font-size:2em; position:absolute; right:3%; top:68%;" id="amount" data-amount="">₩0</span>						
						</c:if>
						<c:if test="${not res}">
							<span style="font-size:2em; position:absolute; right:3%; top:68%;" id="amount" data-amount="${room.price}">₩${room.price}</span>						
						</c:if>
						</div></li>
					
					<hr>
					<li><div class="dt">요청 사항</div>
						<div class="dd">
							<textarea rows="5" class="form_style" name="description"
								placeholder="할말 있음 해라ㅋㅋ (최소 50자)" id="talk"></textarea>
						</div></li>
						
						
					<hr>	
					<li><div class="dt" style="position:relative;">결제 수단*</div>
							
							<button id="kakaopay" style="position:absolute; right:19%; bottom:0.5%;">
								<img src="/resources/images/kakaopay2.JPG" id="kakaoImg"/>
							</button>
							<button id="nice" style="position:absolute; right:3%; bottom:0.6%;">				
								<img src="/resources/images/신용카드2.JPG" id="niceImg"/>
							</button>
							
<script>
								

		var buyer_name = '${sessionScope.memberId}';   // sessionScope.userId 받아와야 함
		var paymentNo = '${paymentNo}'+ new Date().getTime(); // 시퀀스 추가해야 함
		var payInfo = '${sessionScope.memberId}';
		var purchaseName = $('input[name=stayName]').val()+', ' +$('input[name=roomName]').val();
		var purchaseAmount = '${price}';
		var pg = '';
		var reservationNo = '${reservationNo}';
		var roomNo = '${reserved.roomNo}';
		var r_checkIn = '${reserved.checkIn}';
		var r_checkOut = '${reserved.checkOut}';
		var memberCount = '${room.stdPerson}';
				
		var memberId = '${sessionScope.memberId}'; // sessionScope.userId 받아와야 함
		var talkSome = $('#talk').val();
		
		function changeMemberCount(value){
			
			memberCount = value;
		}
		
		
		
		$(function(){
			
			
			
			$('#talk').change(function(){
				
				talkSome = $('#talk').val();
			});
			
			$("#realAmountVal").change(function(){
				
				realAmount = $("#realAmountVal").val();
				
			});
			
			$('select[name=roomName]').change(function(){
				
				
				
				purchaseName = $('input[name=stayName]').val()+", "+$('select[name=roomName]').val();
				
				
				
			});
			
			$("#kakaopay").click(function(){
				
				
				pg = 'kakaopay';
				
				$("#kakaoImg").attr("src", "/resources/images/kakaopay.JPG");
				$("#nice").attr("style", "position:absolute; right:3%; bottom:0.6%;");
				$("#niceImg").attr("src", "/resources/images/신용카드2.JPG");
			});
			
			$("#nice").click(function(){
														
				pg = 'nice';
				
				$("#niceImg").attr("src", "/resources/images/신용카드.JPG");
				$("#nice").attr("style", "position:absolute; right:3%; bottom:1%;");
				$("#kakaoImg").attr("src", "/resources/images/kakaopay2.JPG");
			});

			
			
		});
		

</script>
							
							
							
						</div></li>
					<hr>
				</ul>
			</div>
		
			
			<div class="bt_btns" style="padding-bottom:0px;">
				<button type="submit" class="btn_bk" onclick="purchaseBtn()">결제하기</button>
			</div>
			<div class="bt_btns">
				<button onclick="location.href='/main'" class="btn_bk" style="background-color:#243087;">메인으로</button>
			</div>
	</div>
	
</div>
				<script>
					
				function purchaseBtn(){
					
					if($('select[name=roomName]').val()==""){
						
						alert('객실을 선택해 주세요.');
						return false;
						
					} else if(pg==''){
						http://localhost:8080/addstay
						alert('결제 수단을 선택해 주세요.');
						return false;
					} else if('${reserved.checkIn}'==''){
						
						alert('예약 날짜를 선택해 주세요.');
						return false;
					}
						
						console.log('pg : ',pg);
						purchased(pg);
						return true;
				}					
							
								
						
						
					
				
				</script>
		
			
</body>
	<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
    <script src = "/resources/js/reserved/calendar.js"></script>
<jsp:include page="../common/footer.jsp"/>