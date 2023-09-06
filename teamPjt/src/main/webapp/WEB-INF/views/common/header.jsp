<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STAY OLLE GALLE</title>
<!-- 부트스트랩 css link -->
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous"> -->
<link rel="shortcut icon" type="image⁄x-icon" href="https://www.stayfolio.com/web/images/logo.png">	
<link rel="stylesheet" href="/resources/css/common/bootstrap5_2_3.css">
<link rel="stylesheet" href="/resources/css/common/48ab7619b7161b1c.css">
<style type="text/css">
.form-control-dark {
  border-color: var(--bs-gray);
}
.form-control-dark:focus {
  border-color: #fff;
  box-shadow: 0 0 0 .25rem rgba(255, 255, 255, .25);
}

.text-small {
  font-size: 85%;
}

.dropdown-toggle {
  outline: 0;
}
</style>
<link rel="stylesheet" href="/resources/css/main/header.css">
<style type="text/css" data-styled-jsx="">a.jsx-a44b61ff91ee7fc6{padding-bottom:30px;border-bottom:1px solid#e6e6e6;margin-bottom:10px}p.jsx-a44b61ff91ee7fc6{font-size:12px;color:#999}.login.jsx-a44b61ff91ee7fc6{font-size:16px;color:#333;margin-bottom:10px}</style>
</head>
<script src="/resources/js/reserved/jquery-3.7.0.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<script>
	// 초대 메세지를 받기 위한 로직
document.addEventListener('DOMContentLoaded', function() {
    	
	
	function initInviteSocket(targetMemberId) {
    	
        let socketInvite = new SockJS("http://localhost:8080/echo?targetMemberId=" + targetMemberId);
		
	var stayNoMsg = '';
        socketInvite.onmessage = function(event) {
            console.log("Received raw data:", event.data);
            // JSON 형식인지 확인
            let receivedData;
            try {
                receivedData = JSON.parse(event.data);
                
            } catch (e) {
                console.warn("Received non-JSON message:", event.data);
                return;  // 현재 메시지 처리 종료
            }

            // JSON 데이터를 정상적으로 파싱한 후, 이후 로직 처리
            if (receivedData && receivedData.type === 'invite') {
                let roomId = receivedData.roomId;
                stayNoMsg = receivedData.stayNoMsg;
                let receivedMessage = receivedData.message;
                let receivedUserId = '';
                const pattern = /(.*?)(?=님이)/;

                const match = receivedMessage.match(pattern);

                if (match) {
                    receivedUserId = match[1];
                    console.log(receivedUserId);  // user1
                }
                alertPopOn(receivedUserId+"님이 "+roomId + "번 방으로 초대하셨습니다.\n이동하시겠습니까?");

                document.getElementById('acceptInvite').style.display = 'block';
                document.getElementById('declineInvite').style.display = 'block';
                document.getElementById('popup-focus').style.display = 'none';
            }
        };

        document.getElementById('acceptInvite').addEventListener('click', function() {	
            let roomId = document.getElementById('alertTxt').innerText;
            
            let match = roomId.match(/(\d+)번/);

            if (match && match[1]) {
                let roomNumber = match[1];  
                window.location.href = "/chat/chat?roomId=" + roomNumber + "&stayNoMsg="+ stayNoMsg;
            } else {
                console.log("방 번호를 찾을 수 없습니다.");
            }
            
            document.getElementById('acceptInvite').style.display = 'none';
            document.getElementById('declineInvite').style.display = 'none';
            document.getElementById('popup-focus').style.display = 'block';

            alertPopClose();
        });

        document.getElementById('declineInvite').addEventListener('click', function() {
            document.getElementById('acceptInvite').style.display = 'none';
            document.getElementById('declineInvite').style.display = 'none';
            document.getElementById('popup-focus').style.display = 'block';

            alertPopClose();
        });
    }
    // 현재 로그인한 사용자의 ID를 사용하여 초대 웹소켓 연결 초기화
    initInviteSocket($("#currentLoggedInUserId").val());
});	
	
	// 알림창을 위한 변수
	let msg = '${msg}'
	if('${param.msg}' != ''){
		msg = '${param.msg}';
	}
	// let msg = '모달테스트';
	
	// sideMenu가 켜진 상태에서 페이지 사이즈를 늘려 메뉴가 사라졌을 경우, 다시 사이즈를 줄이면
	// sideMenu를 보여주기 위한 변수
	var side;

	window.addEventListener('load', function(){
		console.log(msg);
		// btnWhere 클릭되면 모달창 보이기
		btnWhere.addEventListener('click', function(){
			document.querySelector("#whereModal").style.display='';
	    })
	
	    // closeBtn 클릭되면 모달창 가리기
	    closeBtn.addEventListener('click', function(){
	        document.querySelector("#whereModal").style.display='none';
	    })
	    
	    // 언제 떠날까요? 달력
	    btnWhen.addEventListener('click', function(){
	        document.querySelector("#whenModal").style.display='';
	        $('input[name=btnYN]').val('search');
	    })
	    
	    closeBtn2.addEventListener('click', function(){
	        document.querySelector("#whenModal").style.display='none';
	        $('input[name=btnYN]').val('');
	    })
		// 언제 떠날까요? 달력 끝

		// window 첫 로드시 width 1024보다 작으면 사이드바 버튼 display none
		if(window.innerWidth >= 1024){
			sideMenuMiddle.style.display='none';
		}
		
	    // a 요소 (button 의 자식 a)
	    let buttons = document.querySelectorAll("#whereBox a");
	    
	    buttons.forEach(button => {
	    	// 버튼이 클릭되면
	        button.addEventListener('click', () => {
	        	// 클릭된 버튼만 active 클래스 추가, 나머지는 active 클래스 삭제
	            buttons.forEach(otherButton => {
	                if (otherButton === button) {
	                    otherButton.classList.add('active');
	                } else {
	                    otherButton.classList.remove('active');
	                }
	            });
	        })
	    })
	    
	    let typeButtons = document.querySelectorAll('#typeBox a');
	    
	    typeButtons.forEach(button =>{
	    	button.addEventListener('click', ()=>{
	    		typeButtons.forEach(otherButton => {
	                if (otherButton === button) {
	                	// 이미 선택된 버튼을 누르면 active 클래스 삭제
	                	if(button.classList.contains('active')){
	                		button.classList.remove('active');
	                	}else{
		                    otherButton.classList.add('active');
	                	}
	                } else {
	                    otherButton.classList.remove('active');
	                }
	            })
	    	})
	    })
	    
	    
	    // 사이드메뉴 버튼 클릭시 사이드메뉴
	    sideMenuMiddle.addEventListener('click', ()=>{
	    	document.querySelector("#sideMenu").style.display='block';
	    	side = 1;
	    })
	    
	    // 사이드메뉴 버튼 클릭시 사이드메뉴 보여줌
	    sideMenuOn.addEventListener('click', ()=>{
	    	document.querySelector("#sideMenu").style.display='block';
	    	side = 1;
	    })
	    
	    // 사이드 메뉴 이 외의 부분 클릭 시 사이드메뉴 제거
	    sideMenuOverlay.addEventListener('click', ()=>{
	    	document.querySelector("#sideMenu").style.display='none';
	    	side = 0;
	    })

	    // msg가 있으면 알림창 보여주기
	    alertPopOn(msg);
	
	})
	
	// active 클래스가 있는 버튼의 innerHTML 값을 파라메터로 가지고 list 페이지 이동
	function searchWhere(){
		let where;
		let type;
		document.querySelectorAll('#whereBox a').forEach(button =>{
			console.log(button.classList.contains('active'));
	        if(button.classList.contains('active')){
			 	where = button.innerHTML;
			}
	    })
	    document.querySelectorAll('#typeBox a').forEach(button =>{
	    	if(button.classList.contains('active')){
	    		type = button.innerHTML;
	    	}
	    })
	 	location.href='/stay/list?stayLoc='+where+'&stayType='+type;
	}
	
	// 화면이 사이즈가 재조정 될 때마다 함수 실행
	window.addEventListener("resize", sideMenuClose);
	
	// 사이드바가 켜져있는 상태에서 화면이 커지면 사이드바를 닫기 위한 함수
   function sideMenuClose(){
		
		
	   
	   if(window.innerWidth >= 1024 && '${sessionScope.memberId}' != ""){
	   	document.querySelector("#sideMenu").style.display='none';
	   // 768-1024 사이즈에서 사이드메뉴를 보여주기 위해 / 새로 만든 이미지를 사이즈가 커지면 없애기 위한 코드
	   	sideMenuMiddle.style.display='none';
	   }
	   
	   
	   if(window.innerWidth <= 1023){
		   // 768-1024사이즈에서 사이드메뉴를 보여주는 코드
		   sideMenuMiddle.style.display='block';
		   // 브라우저 사이즈가 1023보다 작아졌을 때 side가 1이면 sideMenu 다시 열기
		   if(side == 1){
			   document.querySelector("#sideMenu").style.display='block';
		   }
	   }
   }

	// 매개변수로 받은 메시지를 알림창으로 띄워주는 함수
	function alertPopOn(msg){
		if(msg != ''){
			alertTxt.innerHTML=msg;
			alertPop.style.display='block';
		}
	}
	
	// 알림창 끄기
	function alertPopClose(){
		alertPop.style.display='none';
	}
	
	function goMain(){
		location.href="/main";
	}
	

	
</script>
<body>
	<!-- 알림 팝업창
				alertPop display='block' 설정 해주고, alertTxt.innerHTML로 메시지 입력 -->
	<div class="layer_pop" id="alertPop"
		style="background: none; display: none; z-index: 9500;">
		<div role="button" tabindex="0" class="layer_pop" aria-label="bg"
			style="display: block;"></div>
		<div class="layer_pop_wrap" style="z-index: 9001;">
			<button type="button" class="btn_layer_close" onclick="alertPopClose()">닫기</button>
			<button type="button" class="btn_back mo_only">back</button>
			<h2 class="layer_title">&nbsp;</h2>
			<div class="change_wrap">
				<div class="change_cont">
					<div class="txt" id="alertTxt">파일 업로드에 실패하였습니다.</div>
				</div>
				<div class="bt_btns">
					<button id="acceptInvite" class="btn_bk" style="display:none">수락</button>
					<button id="declineInvite" class="btn_bk" style="display:none">거절</button>
					<button type="button" class="btn_bk" id="popup-focus" onclick="alertPopClose()">확인</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="currentLoggedInUserId" value="${sessionScope.memberId}" />
	<!-- where/when 모달 -->
	<!-- where modal -->
	<div class="modalOverlay" id="whereModal" style="display: none;">
		<div class="modalWrapper">
			<div class="modalInner">
				<div class="layer layer_whe where open"
					style="position: relative; display: block; height: auto;">
					<div class="container">
						<button type="button" class="btn_close" id="closeBtn">닫기</button>
						<div class="whe_tit" style="text-align: left;">어디로 떠날까요?</div>
						<div class="whe_wrap">
							<div class="where_search">
								<input type="text" placeholder="원하는 스테이 혹은 지역을 검색해 보세요.">
							</div>
							<div class="whe_cont">
								<div class="box" id="whereBox">
									<div class="tit" style="text-align: left;">국내</div>
									<ul class="clearfix">
										<li><button type="button">
												<a class="">국내 전체</a>
											</button></li>
										<li><button type="button">
												<a class="">제주</a>
											</button></li>
										<li><button type="button">
												<a class="">서울</a>
											</button></li>
										<li><button type="button">
												<a class="">강원</a>
											</button></li>
										<li><button type="button">
												<a class="">부산</a>
											</button></li>
										<li><button type="button">
												<a class="">경기</a>
											</button></li>
										<li><button type="button">
												<a class="">충청</a>
											</button></li>
										<li><button type="button">
												<a class="">경상</a>
											</button></li>
										<li><button type="button">
												<a class="">전라</a>
											</button></li>
										<li><button type="button">
												<a class="">인천</a>
											</button></li>
										<li><button type="button">
												<a class="">광주</a>
											</button></li>
										<li><button type="button">
												<a class="">대전</a>
											</button></li>
										<li><button type="button">
												<a class="">대구</a>
											</button></li>
										<li><button type="button">
												<a class="">울산</a>
											</button></li>
									</ul>
								</div>
								<div class="box" id="typeBox">
									<div class="tit" style="text-align: left;">스테이유형</div>
									<ul class="clearfix">
										<li><button type="button">
												<a class="">펜션</a>
											</button></li>
										<li><button type="button">
												<a class="">한옥</a>
											</button></li>
										<li><button type="button">
												<a class="">렌탈하우스</a>
											</button></li>
										<li><button type="button">
												<a class="">민박</a>
											</button></li>
										<li><button type="button">
												<a class="">호텔</a>
											</button></li>
									</ul>

								</div>
							</div>
							<a href="#none" onclick="searchWhere()" style="display: flex; justify-content: center;"><button
									type="button" class="btn-searchstay" id="gigi"
									style="order: 0; margin-bottom: 30px;">SEARCH</button></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- when modal -->
	<div class="modalOverlay" id="whenModal" style="display: none;">
		<div class="modalWrapper">
			<div class="modalInner" style="width:1220px; height:900px;">
	
					<jsp:include page="/WEB-INF/views/reserved/calendar.jsp"/>
			</div>
		</div>
	</div>
	
	<!-- 헤더 메뉴 -->
	<div id="gnbBgColor">
		<header id="header" class="container_wide">
			<div class="header_wrap gnb-responsive-css only-pc">
				<div class='logo'>
					<a href="/main" >STAY OLLAE</a>
				</div>										<!-- 사이즈 768-1024일 때 사이드바 메뉴 버튼 이미지 -->
				<div class="side-Menu" id="sideMenuMiddle" style="width: 44px; height: 44px; background-image: url(https://www.stayfolio.com/mobile-menu.svg);"></div>
				<div class="whe gnb-responsive-margin" style="">
					<button type="button" class="gnb-mo-small" id="btnWhere">
						<span class="gnb-mo-small">어디로 떠날까요?</span>
					</button>
					<button type="button" class="gnb-when-mo-small" id="btnWhen">
						<span class="gnb-mo-small">언제 떠날까요?</span>
					</button>
				</div>
				<div class="toggle-ko-mo"></div>
				<div class="nav">
					<ul class="menu">
						<li class=""><a href="/stay/list">FIND STAY</a></li>
						<!-- <li class=""><a href="#none">메뉴</a></li> -->
					</ul>
					<ul class="etc">
						<div class="nav_etc">
							<c:if test="${ empty sessionScope.member }" var="res">
								<div class="box" style="border:0px">
									<a href="/login/login"><div class="nav_tit login">LOGIN</div></a>
								</div>
							</c:if>
							<c:if test="${ not res }">
								<!-- 로그인 구현 되면 session에 저장된 값을 비교 -->
								<c:if test="${ sessionScope.role_id eq '[user]' }">
									<div class="box">
										<div class="nav_tit mypage">MY PAGE</div>
										<ul class="open_list" style="width: 125px;">
											<li><a href="/member/mypage/reservation">예약 정보</a></li>
											<li><a href="/member/mypage/cancel">취소 내역</a></li>
											<li><a href="/member/mypage/likestay">관심 스테이</a></li>
											<li><a href="/member/mypage/info">회원 정보 수정</a></li>
											<li><a href="/member/mypage/message">메시지</a></li>
											<!-- 편의를 위해 우선  main 페이지로 설정 -->
											<li class="login"><a onclick="location.href='/logout'" style="cursor:pointer;">로그아웃</a></li>
										</ul>
									</div>
								</c:if>
								<c:if test="${ sessionScope.role_id eq '[admin]' }">
									<div class="box">
										<div class="nav_tit mypage">ADMIN PAGE</div>
										<ul class="open_list" style="width: 125px;">
											<li><a href="/member/admin/stayadmin">숙소
													관리</a></li>
											<li><a href="/member/admin/useradmin">사용자
													관리</a></li>
											<li><a href="/member/admin/hosthelp">호스트
													지원</a></li>
											<li><a href="/member/admin/staticPage">통계
													및 분석</a></li>
											<li class="login"><a href="/logout">로그아웃</a></li>
										</ul>
									</div>
								</c:if>
								<c:if test="${ sessionScope.role_id eq '[host]' }">
									<div class="box">
										<div class="nav_tit mypage">HOST PAGE</div>
										<ul class="open_list" style="width: 125px;">
											<li><a href="/member/host/stayhost">숙소 관리</a></li>
											<li><a href="/member/host/reservation">예약 관리</a></li>
											<li><a href="/member/host/income">수입 현황</a></li>
											<li><a href="/member/host/guide">호스트 가이드</a></li>
											<li><a href="/member/host/infoHost">회원 정보 수정</a></li>
											<li><a href="/member/host/message">메시지</a></li>
											<li class="login"><a href="/logout">로그아웃</a></li>
										</ul>
									</div>
								</c:if>
							</c:if>
						</div>
					</ul>
				</div>
			</div>
			<div class="header_wrap gnb-responsive-css only-mobile">
				<div class="logo">
					<a href="/main">STAY FOLIO</a>
				</div>
				<div class="side-menu" id="sideMenuOn"></div>
			</div>
			<div class="header_wrap gnb-responsive-css new-header">
				<div class="logo" style="margin-left: 16px;">
					<a href="/main">STAY FOLIO</a>
				</div>
				<div class="right-menu">
					<div class="side-menu"></div>
				</div>
			</div>
		</header>
	</div>
	<!-- 사이드 메뉴 -->
	<div class="jsx-645c674fce93a7bf wrapper" style="display: none;"
		id="sideMenu">
		<div aria-hidden="true" class="jsx-645c674fce93a7bf overlay"
			id='sideMenuOverlay'></div>
		<div class="jsx-645c674fce93a7bf menu-modal">
			<c:if test="${ not empty sessionScope.memberId }" var="res">
			<a href="/member/mypage/reservation" class="jsx-c4e7717c5657cc43">
				<div class="jsx-c4e7717c5657cc43 profile">
					<div class="jsx-c4e7717c5657cc43 profile-img" style="background: url(/resources/images/${sessionScope.member.profile.replace('\\','/')});background-size:cover"></div>
					<div class="jsx-c4e7717c5657cc43 profile-right">
						<div class="jsx-c4e7717c5657cc43 name">
							${ sessionScope.member.memberName }님 환영합니다
						</div>
						<div role="link" tabindex="0"
							class="jsx-c4e7717c5657cc43 booking-msg">올래갈래</div>
					</div>
				</div>
			</a>
			<div class="landing_menu">
				<ul style="padding-left:0px;">
					<c:if test="${ sessionScope.role_id eq '[user]' }">
						<li><a href="/member/mypage/reservation">예약 정보</a></li>
						<li><a href="/member/mypage/cancel">취소 내역</a></li>
						<li><a href="/member/mypage/likestay">관심 스테이</a></li>
						<li><a href="/member/mypage/info">회원 정보 수정</a></li>
						<li><a href="/member/mypage/message">메시지</a></li>
					</c:if>
					<c:if test="${ sessionScope.role_id eq '[host]' }">
						<li><a href="/member/host/stayhost">숙소 관리</a></li>
						<li><a href="/member/host/reservation">예약 관리</a></li>
						<li><a href="/member/host/income">수입 현황</a></li>
						<li><a href="/member/host/guide">호스트 가이드</a></li>
						<li><a href="/member/host/infoHost">회원 정보 수정</a></li>
						<li><a href="/member/host/message">메시지</a></li>
					</c:if>
					<c:if test="${ sessionScope.role_id eq '[admin]' }">
						<li><a href="/member/admin/stayadmin">숙소 관리</a></li>
						<li><a href="/member/admin/useradmin">사용자 관리</a></li>
						<li><a href="/member/admin/hosthelp">호스트 지원</a></li>
						<li><a href="/member/admin/staticPage">통계 및 분석</a></li>
					</c:if>
				</ul>
			</div>
			<ul style="padding-left:0px;" class="jsx-bc9726d7609f7d7f setting-menu">
<!-- 				<li role="presentation" class="jsx-bc9726d7609f7d7f lang-menu">
					<div class="jsx-bc9726d7609f7d7f">언어 설정</div>
					<div class="jsx-bc9726d7609f7d7f lang">한국어</div>
				</li> -->
			</ul>
			<div class="jsx-13bd1097de52bb6b">
				<button type="button" class="jsx-13bd1097de52bb6b" onclick="location.href='/logout'">로그아웃</button>
			</div>
			</c:if>
			
			<c:if test="${ not res }">
				<a href="/login/login" class="jsx-c4e7717c5657cc43">
					<div class="jsx-c4e7717c5657cc43 profile">
						<div class="jsx-c4e7717c5657cc43 profile-img"></div>
						<div class="jsx-c4e7717c5657cc43 profile-right">
							<div class="jsx-c4e7717c5657cc43 name">로그인 • 회원가입</div>
							<div role="link" tabindex="0"
								class="jsx-c4e7717c5657cc43 booking-msg">올래갈래말래 화이팅</div>
						</div>
					</div>
				</a>
				<ul class="jsx-bc9726d7609f7d7f setting-menu">
<!-- 				<li role="presentation" class="jsx-bc9726d7609f7d7f lang-menu">
					<div class="jsx-bc9726d7609f7d7f">언어 설정</div>
					<div class="jsx-bc9726d7609f7d7f lang">한국어</div>
				</li> -->
				<li role="presentation" class="jsx-bc9726d7609f7d7f">1:1 문의</li>
			</ul>
			<div class="jsx-13bd1097de52bb6b">
				<button type="button" class="jsx-13bd1097de52bb6b" onclick="location.href='/login/login'">로그인</button>
			</div>
			</c:if>
		</div>
	</div>