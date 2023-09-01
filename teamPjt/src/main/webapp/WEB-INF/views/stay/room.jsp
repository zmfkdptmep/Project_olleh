<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${list.STAYNAME }</title>
<link rel="shortcut icon" type="image⁄x-icon" href="https://www.stayfolio.com/web/images/logo.png">

<link href="../resources/css/common/48ab7619b7161b1c.css" rel="stylesheet">
<link href="../resources/css//common/5f0d2e1da89b35fb.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="/resources/js/reserved/calendar.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=124076e69929aa6f11bd182ef5993338"></script>

<style>
	.reveal {
    visibility: visible;
    opacity: 1;
    transition: .3s;
}
</style>

<script charset="utf-8">
        window.addEventListener('load', function () {
            let guideBtn = document.querySelectorAll('.faq_cont .left li');
            let guideInfo = document.querySelectorAll('.tab_view');
            guideBtn.forEach((button, index) => {
                button.addEventListener('click', () => {
                    guideBtn.forEach((otherButton, otherIndex) => {
                        console.log('클릭된 버튼의 인덱스:', index);
                        if(otherButton == button){
                            otherButton.classList.add('active');
                            guideInfo[index].classList.add('active');
                            guideInfo[index].classList.remove('hide');
                        }else{
                            otherButton.classList.remove('active');
                            guideInfo[otherIndex].classList.remove('active');
                            guideInfo[otherIndex].classList.add('hide');
                        }
                    });
                })
            });
            
            // 좋아요
/*             let likeBtn = document.querySelector('.btn_like2');
            likeBtn.addEventListener('click', () => {
                if (likeBtn.classList.contains('on')) {
                    likeBtn.classList.remove('on');
                } else {
                    likeBtn.classList.add('on');
                }
            }) */
            
            
            // 날짜 선택 버튼
            let dateBtn = document.querySelector('.booking_summary .dayday');
            dateBtn.addEventListener('click', () => {
            	console.log('aa');
            	document.querySelector('.booking_summary .modalOverlayList').style.display='';
            })
            
            let btn_close = document.querySelector('.container .container .btn_close');
            btn_close.addEventListener('click', () => {
            	console.log('a');
            	document.querySelector('.booking_summary .modalOverlayList').style.display='none';
            	document.querySelector('.booking_summary .modalOverlay').style.display='none';
            }) 
            
            
            // 카카오 지도 
           /*  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(${list.LATITUDE}, ${list.LONGITUDE}), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };
		
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(${list.LATITUDE}, ${list.LONGITUDE}); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition,
			    title : '${list.STAYNAME }'
			    
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map); */
			
            
			
			
			
			
			
			
			
			
			
			 let nextBtn = document.querySelector('.swiper-button-next-room');
			 var roomList = document.querySelectorAll('.room_slider ul li');
			 var roomListt = document.querySelectorAll('.room_slider ul li');
			 var roomListtt = document.querySelectorAll('.room_slider ul li');
			 let room = document.querySelectorAll('.room_slider ul');
			
			 let startIdx = 0;
			 let maxIdx = roomList.length;			 	
			
			// 객실 갯수에 따른 인덱스 번호
			let indices = Array.from({ length: roomList.length }, (_, i) => i);

			function rotateIndices() {
			  let firstIndex = indices[0];

			  indices.shift();

			  indices.push(firstIndex);

			  return indices;
			}

			let rotateBtn = document.querySelector('.swiper-button-next-room');

			rotateBtn.addEventListener('click', () => {
			  let updatedIndices = rotateIndices();
				
			  console.log(updatedIndices);
			  console.log(updatedIndices[0]);
			  console.log(updatedIndices[1]);
			  console.log(updatedIndices[2]);
			  
			  
/* 			  roomList[0].innerHTML = roomListt[updatedIndices[0]].outerHTML;
			  console.log(roomListt[updatedIndices[0]]);
			  roomList[1].innerHTML = roomListt[updatedIndices[1]].outerHTML;
			  console.log(roomListt[updatedIndices[1]]);
			  roomList[2].innerHTML = roomListt[updatedIndices[2]].outerHTML; 
			  console.log(roomListt[updatedIndices[2]]); */

			  
			  let tmp = roomList[0].innerHTML;
			  for(i=0; i<roomList.length-1; i++){
				  roomList[i].innerHTML = roomList[i+1].innerHTML;
			  }
			  roomList[roomList.length-1].innerHTML = tmp;
/* 			  roomList[0].innerHTML = roomList[1].innerHTML;
			  roomList[1].innerHTML = roomList[2].innerHTML;
			  roomList[2].innerHTML = tmp; */
			});

			let prevtBtn = document.querySelector('.swiper-button-prev-room');
			prevtBtn.addEventListener('click', ()=>{
				  let tmp = roomList[roomList.length-1].innerHTML;
				  for(i=roomList.length-1; i>0; i--){
					  roomList[i].innerHTML = roomList[i-1].innerHTML;
				  }
				  roomList[0].innerHTML = tmp;
				  /* roomList[0].innerHTML = roomList[2].innerHTML;
				  roomList[1].innerHTML = roomList[1].innerHTML;
				  roomList[2].innerHTML = tmp; */
			})
			
			
			
			
			// 공유하기
			let shareClose = document.querySelector('.share_layer .btn_close');
			shareClose.addEventListener('click', ()=>{
				document.querySelector('.share_layer').style.display= 'none';
			})
			
			let shareBtn = document.querySelector('.links_area .btn_share');
			shareBtn.addEventListener('click', ()=>{
				document.querySelector('.share_layer').style.display= '';
			})
			
			var link =  document.location.href;
			console.log(link);
			
			
			
	 		/* var pic = "${list.MAINPIC1}";
			console.log(pic);
			var pp = pic.replace('\\', '/');
			var savePath= encodeURIComponent(pp);
			console.log(savePath);
			console.log('/display?fileName='+savePath);
			var p = '/display?fileName='+savePath; */
			
			
			// 카카오 링크 공유 api
			 Kakao.Share.createDefaultButton({
			      container: '#kakaotalk-sharing-btn',
			      objectType: 'feed',
			      content: {
			        title: '${list.STAYNAME }',
			        description: '${list.STAYINFO }',
			        imageUrl: "https://images.stayfolio.com/system/pictures/images/000/189/235/original/b192523dfeb1178a83595753a4800548b70271cf.jpg?1690248886",
			        link: {
			          // [내 애플리케이션] > [플랫폼] 에서 등록한 사이트 도메인과 일치해야 함 // 들어갈 링크
			          mobileWebUrl: link,
			          webUrl: link,
			        },
			      },
			      buttons: [
			        {
			          title: '자세히 보기',
			          link: {
			            mobileWebUrl: link,
			            webUrl: link,
			          },
			        },
			      ],
			      // 카카오톡 미설치 시 카카오톡 설치 경로이동
			      installTalk: true,
			    });
			
			let likeCopy = document.querySelector('.share_list img');
			let copySuccess = document.getElementById('toast');
			likeCopy.addEventListener('click', () => {
				console.log('a');
				
				// 링크 복사
				navigator.clipboard.writeText(link).then(() => {
					// 링크 복사 알림창
					copySuccess.classList.add('reveal');
					
					// 3초후에 사라짐
					setTimeout(() => {
						copySuccess.classList.remove('reveal');
					}, 3000);
				}).catch((err) => {
				    console.error('Failed to copy link:', err);
				});
			});
			
			
			
			
			// 주변 맛집
			
			let address = '${list.STAYADRESS }';
			let mapx = '${list.LATITUDE}';
			let mapy = '${list.LONGITUDE}';
			
			let parts = address.split(' ', 3); // 최대 3개의 부분으로 나눔
			
			let shortenedAddress = parts.join(' ');
			let ch = shortenedAddress +'주변 맛집';
			
			let encodedPromotion = encodeURIComponent(ch); // endoce
			
			fetch('/stst/matjip/'+encodedPromotion+'/'+mapx+'/'+mapy)
			.then(response => response.json())
			.then(map => {kk(map); initializeKakaoMap();}); 
			
			
			var positions = [];
			
			async function kk(map){
				let rs = map.rs;
				//console.log(rs);
				
				let parsedData = JSON.parse(rs);
				//console.log(parsedData);
				
				
				let matjip = document.querySelector('#matjip ul'); 
				matjip.innerHTML = '';
				let pageBlock = '';
				
				
				parsedData.documents.forEach((list,index)=>{
					
					
					if (index < 6) {
						
						let categoryString =  list.category_name;
						const categories = categoryString.split(" > ");
						const categoryObject = {
						  main: categories[0],
						  type: categories[1],
						  subType: categories[2],
						  name: categories[3]
						};
						
						let cnt = index + 1;
						
						pageBlock
						+='<a href='+list.place_url+' target="_blank">'
						+'<li>'
	                    +'<div class="map_marker" role="presentation" style="cursor: pointer;">'+cnt+'</div>';
	                    if(categoryObject.subType == null){
	                    	pageBlock
	                    	+='<div class="tit">'+list.place_name+'<em>'+categoryObject.main +'>'+categoryObject.type+'</em></div>';
	                    }else{
		                    pageBlock                  	
		                    +='<div class="tit">'+list.place_name+'<em>'+categoryObject.main +'>'+categoryObject.type+'>'+categoryObject.subType+'</em></div>';
	                    }
	                    pageBlock
	                    +='<div class="desc">'+list.address_name+'</div>'
	                	+'</li>'
						+'</a>';
						
	                    matjip.innerHTML = pageBlock;
	                    
	                    // 맛집 좌표 배열에 넣기
	                    positions.push({
	                        title: list.place_name,
	                        latlng: new kakao.maps.LatLng(list.y, list.x)
	                    });
					}
				})
				
				console.log(positions);
			}
			console.log(positions.length);
				// 마커 이미지의 이미지 주소입니다
				
				function initializeKakaoMap() {
					console.log(positions);
					
					 var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = { 
					        center: new kakao.maps.LatLng(${list.LATITUDE}, ${list.LONGITUDE}), // 지도의 중심좌표
					        level: 4 // 지도의 확대 레벨
					    };
					
						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(${list.LATITUDE}, ${list.LONGITUDE}); 
						
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition,
						    title : '${list.STAYNAME }'
						    
						});
						
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);	
					
					
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
 				    
				for (var i = 0; i < positions.length; i ++) {
				    console.log(positions[i].latlng);
				    // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new kakao.maps.Size(24, 35); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				    
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지 
				    });
				}
			
				}
			
			
		
				// 좋아요
				let member = document.getElementById('memberId').value;
	            console.log(member);

	            //좋아요
	            let likeBtn = document.querySelector('.links_area li .btn_like2');
	            	likeBtn.addEventListener('click', () => {
	                	if(member === null || member === ""){
	                		alertPopOn("로그인 후 이용하세요");
	                    }else{
			                        if(!likeBtn.classList.contains('on')){
			                        	likeBtn.classList.add('on');
			                        	
			                        	let data = {
			    	        					stayNo : '${list.STAYNO}',
			    	        					memberId: member
			    	        			      };
			                        	
			                        	fetch("/stst/insertLike", {
				        			        method : 'post', 
				        			        headers : {
				        			          'Content-Type': 'application/json'
				        			        },
				        			        body : JSON.stringify(data)
				        			      })
				        			      .then(response => response.json())
				        			      //.then(map => keywordList(map));
				        			      .then(map => likeValue(map));
			                        }else{
			                        	likeBtn.classList.remove('on');
			                            
			                            let data = {
			    	        					stayNo : '${list.STAYNO}',
			    	        					memberId: member
			    	        			      };
			                        	
			                        	fetch("/stst/deleteLike", {
				        			        method : 'post', 
				        			        headers : {
				        			          'Content-Type': 'application/json'
				        			        },
				        			        body : JSON.stringify(data)
				        			      })
				        			      .then(response => response.json())
				        			      //.then(map => keywordList(map));
				        			      .then(map => likeValue(map));
			                    	}
	                    }
	                })
	            
	            
	            // 모달창 띄우기
	        	function alertPopOn(msg){
	        		if(msg != ''){
	        			alertTxt.innerHTML=msg;
	        			alertPop.style.display='block';
	        		}
	        	}
			 
	            // 실시간 하트값 출력
				function likeValue(map){
					let value = map.value;
					
					let likeValue = document.querySelector('.links_area li .small');
					if(value == '1' && value != null){
						likeValue.innerHTML  = ( Number(likeValue.innerHTML) + 1);
					}else{
						likeValue.innerHTML  = (likeValue.innerHTML - 1);
					}
				}
			
				let dayBtn = document.querySelector('.btn-number-search');
				dayBtn.addEventListener('click', () => {
	            	console.log('aa');
	            	
	            	let findStartDate = document.querySelector('#check_in_day').innerHTML.split(' ')[0];
        			if(findStartDate === null){
        				findStartDate == "";
        			}
        			console.log(findStartDate);
        			
        			// 체크아웃
        			let findEndDate = document.querySelector('#check_out_day').innerHTML.split(' ')[0];
        			if(findEndDate === null){
        				findEndDate == "";
        			}
        			console.log(findEndDate);
        			
					let stayName = document.querySelector('.top_title .name').innerHTML;
					console.log(stayName);
        			      
        			fetch('/stst/room/'+stayName+'/'+findStartDate+'/'+findEndDate)
        			.then(response => response.json())
        			.then(map => roomArea(map));
	            	
	            	document.querySelector('.booking_summary .modalOverlayList').style.display='none';
        			      
	            	document.querySelector('.btn_select').innerHTML = formatDate(checkInDate) + ' ~ ' + formatDate(checkOutDate) + '  (' + (checkOutDate - checkInDate) + '박)';
	            });
        		
	            // 날짜 변환
        		function formatDate(input) {
				    let year = input.substr(0, 4);
				    let month = input.substr(4, 2);
				    let day = input.substr(6, 2);
				    return year + '/' + month + '/' + day;
				}
				
				
        		
        
	            
	            
        
        
        
        
        function roomArea(map){
			let roomList = map.roomList;
			let roomImg = map.roomImg;
			
			console.log(roomList);
			console.log(roomImg);
			
			let roomListArea = document.querySelector('.swiper-wrapper');
			let stayName = document.querySelector('.top_title .name').innerHTML;
			
			roomListArea.innerHTML = '';
			let pageBlock = '';
			
			roomList.forEach((list, index)=>{
				pageBlock
				+='<li class="swiper-slide slider_box single-room swiper-slide-active">'
				+'	<a href="/stay/roomInfo?stayName='+stayName+'&roomName='+list.ROOMNAME+'&checkIn='+formatDate(checkInDate)+'&checkOut='+formatDate(checkOutDate)+'">';
				
				roomImg.forEach((img, index)=>{
					if(img.ROOMNO == list.ROOMNO){
						let file = img.FILENAME.replaceAll("\\", "/")
 					pageBlock
					+='	<div role="presentation" class="img" style="background-image: url(/resources/images/'+file+'); background-repeat: no-repeat; background-position: center center; background-size: cover;">'
					+'	</div>';
					}
				}) 
				
				pageBlock
				+='		<div class="room-info">'
				+'			<p class="name" style="width: 100%;">'
				+'				<small>특실</small>'+list.ROOMNAME+''
				+'			</p>'
				+'			<p class="etc" style="width: 100%;">'
				+'				<span>기준 '+list.STDPERSON+'명&nbsp;(최대 '+list.OVERPERSON+'명)</span><span>침구 '+list.BED+'개</span>'
				+'			</p>'
				+'			<p class="price">₩'+list.PRICE+' ~</p>'
				+'			<p class="book mo-book-btn" role="presentation">예약하기</p>'
				+'		</div>'
				+'	</a>'
				+'</li>';
			})
			roomListArea.innerHTML += pageBlock;
			
		}
        
        
        });
        
        
        
        
        
        
    </script>
    
    
    <!-- 카카오 공유하기 api스크립트 -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
  	<script>
  		Kakao.init('124076e69929aa6f11bd182ef5993338'); // 사용하려는 앱의 JavaScript 키 입력
  	</script>
</head>
<body>
	<%@include file="../common/header.jsp"%>
	<input type="hidden" value="${sessionScope.memberId}" id="memberId"> 
	<div id="contents" class="findstay-detail-container">
		<div class="container_wide fdetail_top">
			<div class="top_title">
				<div class="name" style='font-size: 40px; font-weight: bold;'>${list.STAYNAME }</div>
				<ul class="links_area">
					<li>
  						<c:choose>
						    <c:when test="${sessionScope.memberId == null}">
						        <button type="button" class="btn_like2"><span>관심스테이</span></button>
						    </c:when>
						    <c:when test="${likeList != null and sessionScope.memberId != null}">
						        <c:set var="isLiked" value="false" />
						        <c:forEach items="${likeList}" var="like" step="1" varStatus="status">
						            <c:if test="${like.stayNo eq list.STAYNO}">
						                <c:set var="isLiked" value="true" />
						            </c:if>
						        </c:forEach>
						        
						        <button type="button" class="btn_like2 ${isLiked ? 'on' : ''}"><span>관심스테이</span></button>
						    </c:when>
						</c:choose>

					
						<small class="small">${list.LIKECOUNT }</small></li>
					<li><button type="button" class="btn_share">공유하기</button>
						<div class="share_layer" style="display: none;">
							<button type="button" class="btn_close">
								<span>닫기</span>
							</button>
							<div class="share_tit">공유하기</div>
							<ul class="share_list">
								<li><a href="#"><img
										src="https://www.stayfolio.com/web/images/ico-share-link.svg" alt="링크복사">링크 복사</a></li>
								<li><a id="kakaotalk-sharing-btn" href="javascript:;">
								<img src="https://www.stayfolio.com/web/images/ico-share-kakao.svg" alt="올래갈래" />카카오톡</a></li>
							</ul>
							<div class="link-copy-topbanner" id="toast">클립보드에 링크가 복사되었습니다.</div>
						</div> 
						<small class="small">공유하기</small></li>
						
						
				</ul>
			</div>
			<div class="top_img">
				<a href="/stay/stayImg?stayName=${list.STAYNAME }">
					<div class="stay-main-img">
						<span id="show-pictures-button">사진 모아보기</span> <span
							style="box-sizing: border-box; display: block; overflow: hidden; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px; position: absolute; inset: 0px;">
							<img alt="Stay Main Image" sizes="100vw" src="/resources/images/${list.MAINPIC1 }"
							decoding="async" data-nimg="fill"
							style="position: absolute; inset: 0px; box-sizing: border-box; padding: 0px; border: none; margin: auto; display: block; width: 0px; height: 0px; min-width: 100%; max-width: 100%; min-height: 100%; max-height: 100%; object-fit: cover;">
						</span>
					</div>
				</a>
				<div class="info">
					<p class="txt">${list.STAYINFO }</p>
					<p class="link">
						<!-- <a href="/" class="not_link">MAGAZINE</a> -->
						<a href="/journal/picks/dansim-stay" class="">${list.BADGE }</a>
					</p>
					<p class="eng_name">${list.STAYNAME }<small>${list.STAYLOC }</small></p>
				</div>
			</div>
		</div>
		<div class="container fdetail_calendar">
			<div class="booking_summary">
				<div class="name">${list.STAYNAME }</div>
				<div class="dayday" role="presentation">
					<div class="btn_select ">날짜를 선택해주세요.</div>
				</div>
				
				
				 <div class="modalOverlayList" style="display: none">
                        <div class="modalWrapper" >
                            <div class="modalInner" >
                                <div class="container" >
                                     <div class="shared-calendar" >
                                        <div class="DatePicker_calendar_wrap" >
                                            <div class="DateRangePicker DateRangePicker_1">
                                                <div class="" style="width: 1080px; height: 450px; /*border: 1px solid #e4e4e4;*/ background: #fff; border-radius: 5px;">
                                                        <div class="calendar-wrap" style="padding-top: 0px ">
                                                            <div class="calendar-middle-wrap" style="height: 400px;">
                                                              <div class="cal_nav" style="margin-top:20px;">
                                                                <a href="javascript:;" class="nav-btn go-prev"></a>
                                                                <span class="year-month start-year-month">2023.08</span>
                                                                <a href="javascript:;" class="nav-btn go-next"></a>
                                                              </div>
                                                              <div class="cal_wrap" style="background: none;">
                                                                <div class="days">
                                                                  <div class="day">일</div>
                                                                  <div class="day">월</div>
                                                                  <div class="day">화</div>
                                                                  <div class="day">수</div>
                                                                  <div class="day">목</div>
                                                                  <div class="day">금</div>
                                                                  <div class="day">토</div>
                                                                </div>
                                                                <div class="dates start-calendar"><div class="day prev disable">30</div><div class="day prev disable">31</div><div class="day prev disable">1</div><div class="day current" data-day="20230802" onclick="selectDay(this)"><span>2</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230803" onclick="selectDay(this)"><span>3</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230804" onclick="selectDay(this)"><span>4</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230805" onclick="selectDay(this)"><span>5</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230806" onclick="selectDay(this)"><span>6</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230807" onclick="selectDay(this)"><span>7</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230808" onclick="selectDay(this)"><span>8</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230809" onclick="selectDay(this)"><span>9</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230810" onclick="selectDay(this)"><span>10</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230811" onclick="selectDay(this)"><span>11</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230812" onclick="selectDay(this)"><span>12</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230813" onclick="selectDay(this)"><span>13</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230814" onclick="selectDay(this)"><span>14</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230815" onclick="selectDay(this)"><span>15</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230816" onclick="selectDay(this)"><span>16</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230817" onclick="selectDay(this)"><span>17</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230818" onclick="selectDay(this)"><span>18</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230819" onclick="selectDay(this)"><span>19</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230820" onclick="selectDay(this)"><span>20</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230821" onclick="selectDay(this)"><span>21</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230822" onclick="selectDay(this)"><span>22</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230823" onclick="selectDay(this)"><span>23</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230824" onclick="selectDay(this)"><span>24</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230825" onclick="selectDay(this)"><span>25</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230826" onclick="selectDay(this)"><span>26</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230827" onclick="selectDay(this)"><span>27</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230828" onclick="selectDay(this)"><span>28</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230829" onclick="selectDay(this)"><span>29</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230830" onclick="selectDay(this)"><span>30</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230831" onclick="selectDay(this)"><span>31</span><p class="check_in_out_p"></p><p></p></div><div class="day next disable">1</div><div class="day next disable">2</div></div>
                                                              </div>
                                                            </div>
                                                      
                                                            <div class="calendar-middle-wrap" style="height: 400px;">
                                                              <div class="cal_nav" style="margin-top:20px;">
                                                                <a href="javascript:;" class="nav-btn go-prev"></a>
                                                                <span class="year-month last-year-month">2023.09</span>
                                                                <a href="javascript:;" class="nav-btn go-next"></a>
                                                              </div>
                                                              <div class="cal_wrap">
                                                                <div class="days">
                                                                  <div class="day">일</div>
                                                                  <div class="day">월</div>
                                                                  <div class="day">화</div>
                                                                  <div class="day">수</div>
                                                                  <div class="day">목</div>
                                                                  <div class="day">금</div>
                                                                  <div class="day">토</div>
                                                                </div>
                                                                <div class="dates last-calendar"><div class="day prev disable">27</div><div class="day prev disable">28</div><div class="day prev disable">29</div><div class="day prev disable">30</div><div class="day prev disable">31</div><div class="day current" data-day="20230901" onclick="selectDay(this)"><span>1</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230902" onclick="selectDay(this)"><span>2</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230903" onclick="selectDay(this)"><span>3</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230904" onclick="selectDay(this)"><span>4</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230905" onclick="selectDay(this)"><span>5</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230906" onclick="selectDay(this)"><span>6</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230907" onclick="selectDay(this)"><span>7</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230908" onclick="selectDay(this)"><span>8</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230909" onclick="selectDay(this)"><span>9</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230910" onclick="selectDay(this)"><span>10</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230911" onclick="selectDay(this)"><span>11</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230912" onclick="selectDay(this)"><span>12</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230913" onclick="selectDay(this)"><span>13</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230914" onclick="selectDay(this)"><span>14</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230915" onclick="selectDay(this)"><span>15</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230916" onclick="selectDay(this)"><span>16</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230917" onclick="selectDay(this)"><span>17</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230918" onclick="selectDay(this)"><span>18</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230919" onclick="selectDay(this)"><span>19</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230920" onclick="selectDay(this)"><span>20</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230921" onclick="selectDay(this)"><span>21</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230922" onclick="selectDay(this)"><span>22</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230923" onclick="selectDay(this)"><span>23</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230924" onclick="selectDay(this)"><span>24</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230925" onclick="selectDay(this)"><span>25</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230926" onclick="selectDay(this)"><span>26</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230927" onclick="selectDay(this)"><span>27</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230928" onclick="selectDay(this)"><span>28</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230929" onclick="selectDay(this)"><span>29</span><p class="check_in_out_p"></p><p></p></div><div class="day current" data-day="20230930" onclick="selectDay(this)"><span>30</span><p class="check_in_out_p"></p><p></p></div></div>
                                                              </div>
                                                            </div>
                                                      
                                                            <div class="checkInOutInfo" style="height:400px;">
                                                              <div>
                                                                <p>
                                                                  <span style="padding-bottom:15px">체크인</span>
                                                                  <label id="check_in_day_list" style="font-size: 20px;"></label>
                                                                </p>
                                                                <p class="space" style="color: #212529;font-size:2em;"></p>
                                                                <p>
                                                                  <span>체크아웃</span>
                                                                  <label id="check_out_day_list" style="font-size: 20px;"></label>
                                                                </p>
                                                                <br><br>
                                                                <p>
                                                                  <span>총 예약일</span>
                                                                </p>
                                                                <p>
                                                                  <label id="check_out_day" class="check_day_count_list" style="font-size: 20px;"></label>
                                                                </p>
                                                      
                                                              </div>
                                                            </div>
                                                            <div id="buttonBtn">
                                                                
                                                                  <input type="hidden" id="reserved_day" name="reserved_day" value="">
                                                                  <input type="hidden" id="reserved_checkIn" name="reserved_checkIn" value="">
                                                                  <input type="hidden" id="reserved_checkOut" name="reserved_checkOut" value="">
                                                        
                                                                  <div class="btn-wrapper" style="position:absolute; bottom:5%; left:35%;">
                                                                    <button style=" border:0px; cursor: pointer; margin-left: 80px;" type="submit" onclick="" class="btn-number-search">찾아보기</button>
                                                                  </div>
                                                                  <!-- <button style="padding-bottom:10px; background-color:white; border:0px; cursor: pointer; position:absolute; top:3%; right:2%;" type="button" id="closeBtn2">
                                                                    <img src="https://www.stayfolio.com/web/images/btn_layer_close.png">
                                                                  </button> -->
                                                                
                                                              </div>
                                                            <script>
                                                      
                                                              window.addEventListener('load', function () {
                                                      
                                                                /*
                                                                // 예약 페이지에선 닫기 버튼 안보여주기
                                                                if($('.modalOverlay2').attr('style') == null){
                                                                    
                                                                  $('#closeBtn2').attr('style', 'display:none;');
                                                                    
                                                                }
                                                                */
                                                      
                                                                if (checkInDate == '' || checkOutDate == '') {
                                                      
                                                                  $('.space').html('');
                                                      
                                                                }
                                                      
                                                      
                                                      
                                                      			// 초기화 버튼
                                                                /* reload.addEventListener('click', function (e) {
                                                      
                                                                  e.preventDefault();            <button style="padding-bottom:10px; background-color:white; border:0px; cursor: pointer;"
                                                                      id="reload">초기화</button><br><br>
                                                      
                                                                  //window.location.reload();
                                                      
                                                                  // 달력 체크 인/아웃 값 초기화
                                                                  $('.checkIn').find('.check_in_out_p').html('');
                                                                  $('.checkOut').find('.check_in_out_p').html('');
                                                      
                                                                  $('.day').removeClass('checkIn');
                                                                  $('.day').removeClass('checkOut');
                                                                  $('.day').removeClass('selectDay');
                                                      
                                                      
                                                                  $('.checkInOutInfo label').html('')
                                                      
                                                      
                                                      
                                                                  checkInDate = '';
                                                                  checkOutDate = '';
                                                      
                                                                  // ~ 표시
                                                                  $('.space').html('');
                                                                }); */
                                                      
                                                                // 뒤로가기 버튼
                                                                /* back.addEventListener('click', function (e) {
                                                      
                                                                  e.preventDefault();
                                                      
                                                                  location.href = '/main';
                                                      
                                                                }); */
                                                      
                                                              });
                                                      
                                                              // 날짜 유효성 검사
                                                              function check(form) {
                                                      
                                                                if (checkInDate == "") {
                                                      
                                                      
                                                                  alert('체크인 날짜를 선택해 주세요');
                                                      
                                                                  return false;
                                                                }
                                                      
                                                                if (checkOutDate == "") {
                                                      
                                                      
                                                                  alert('체크아웃 날짜를 선택해 주세요');
                                                      
                                                                  return false;
                                                                }
                                                      
                                                                form.submit();
                                                      
                                                      
                                                      
                                                              }
                                                      
                                                            </script>
                                                      
                                                          </div>


                                                    </div>
                                                
                                                
                                            </div>
                                        </div>
                                        <!-- <button type="button" class="day_del">선택 날짜 지우기</button> -->
                                    </div>
                                    <div class="btn_close" role="presentation"></div>
                                </div>
                            </div>
                        </div>
                    </div>
				
				
				
				
				<div></div>
			</div>
		</div>
		<div class="container_full fdetail_room">
			<div class="container room_cont">
				<div class="tit">
					ROOM<br class="pc_only">
				</div>
				<div class="txt"></div>
				<div class="swiper-buttons">
					<div class="swiper-button-prev-room swiper-button-disabled">Prev</div>
					<div class="swiper-button-next-room swiper-button-disabled">Next</div>
				</div>
			</div>
			<div class="room_slider">
				<div
					class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
					<ul class="swiper-wrapper">
						<!-- 반복 -->
						<c:forEach items="${stayRoomInfo}" var="roomList" step="1">
						<li class="swiper-slide slider_box single-room swiper-slide-active">
							<a href="/stay/roomInfo?stayName=${list.STAYNAME }&roomName=${roomList.ROOMNAME}">
								<c:forEach items="${stayRoomImg}" var="roomImg" step="1">
									<c:if test="${roomImg.roomNo eq roomList.ROOMNO }">
										<div role="presentation" class="img"
											style="background-image: url(/resources/images/${roomImg.fileName.replace('\\','/')}); background-repeat: no-repeat; background-position: center center; background-size: cover;">
										</div>
									</c:if>
								</c:forEach>
								<div class="room-info">
									<p class="name" style="width: 100%;">
										<small>특실</small>${roomList.ROOMNAME}
									</p>
									<p class="etc" style="width: 100%;">
										<span>기준 ${roomList.STDPERSON}명&nbsp;(최대 ${roomList.OVERPERSON}명)</span><span>침구 ${roomList.BED}개</span>
									</p>
									<p class="price">₩${roomList.PRICE} ~</p>
									<p class="book mo-book-btn" role="presentation">예약하기</p>
								</div>
							</a>
						</li>
						</c:forEach>
						<!-- 여기까지 -->
					</ul>
				</div>
			</div>
		</div>
		<div class="fdetail_info_wrapper">
			<div class="container fdetail_intro">
				<div class="fdetail_title">
					${list.INFO }<small>${list.STAYNAME }</small>
				</div>
				<div class="fdetail_text">
					<div class="txt1">저희 특별한 공간과 시간만을 제공하는 스테이폴리오에서 가장 인기있는 숙소 '${list.STAYNAME }' 입니다.</div>
					<div class="txt2">‘ㄱ’자 구조의 ${list.STAYNAME }는 전면에 배치된 4개의 통창이 단연 돋보입니다.
						특히, 다이닝 공간의 폴딩형 창은 완전히 오픈하면 주변과 경계 없이 호흡이 가능합니다. 실내에 따로 마련된 욕조 공간
						또한, 창을 통해 햇볕을 받으며 탁 트인 주변 경치를 감상할 수 있도록 했습니다. 노출 콘크리트와 월넛 우드 소재로
						구성된 내부는 공간에 채워진 오브제나 액자, 가구와 어우러져 사뭇 미술관 같은 분위기마저 듭니다. 단심 스테이는
						호스트가 직접 공간에 어울리는 플레이리스트를 선별하여 제공하고 있습니다. 호스트가 제안하는 음악과 함께 공간에서의
						경험을 완성해 보세요.</div>
				</div>
			</div>

			<!-- 옵션 추출 -->
			<div class="container_full fdetail_special"
				<%-- style="background-image: url(/resources/images/${list.MAINPIC1.replace('\\','/')}); background-repeat: no-repeat; background-position: center center; background-size: cover;"> --%>
				style="background-image: url(&quot;https://images.stayfolio.com/system/pictures/images/000/161/864/original/2a59990a4d4b5571dc5112459261660fdc589946.jpg?1673939220&quot;); background-repeat: no-repeat; background-position: center center; background-size: cover;">
				<div class="container special_wrap">
					<div class="special_tit">
						<small>SPECIAL</small>
					</div>
					<div class="special_list">
						<c:if test="${list.POOL eq 'Y'}">
						<li><i><img
								src="https://images.stayfolio.com/system/pictures/images/000/161/857/original/41df569c4c5367b783f4793f058957ab0d7a771d.png?1673938881"
								alt="special_img_1"></i>
							<div class="tit">실내 스파</div>
							<div class="desc"> 여러분 프로젝트 하느라 고생 진짜 많으셨습니다. </div>
						</li>
						</c:if>
						<c:if test="${list.BEAMPROJECTOR eq 'Y'}">
						<li>
						<i><img
								src="https://images.stayfolio.com/system/pictures/images/000/022/852/original/da72017d52231aece7591975b33191a88d831d33.png?1509347637"
								alt="special_img_1"></i>
							<div class="tit">TOWN HOTEL</div>
							<div class="desc"> 여러분들 프로젝트가 최고로 잘했어요. </div>
						</li>
						</c:if>
						<c:if test="${list.BABIQU eq 'Y'}">
						<li>
						<i><img
								src="https://images.stayfolio.com/system/pictures/images/000/018/215/original/b8c313646dafe7674539a93e7e1effd20f670cd9.png?1500455204"
								alt="special_img_1"></i>
							<div class="tit">MEALS</div>
							<div class="desc"> 여러분들이 짱이에요. </div>
						</li>
						</c:if>
					</div>
				</div>
			</div>



			<div class="container_full fdetail_map">
				<div class="container map_txt">
					<div class="txt1">'${list.STAYNAME }'의 위치는 [${list.STAYADRESS }]
						입니다.</div>
					<div class="txt2">주차가 가능한 숙소입니다.</div>
				</div>
				<div class="map_container">
					<div id="naver-map-detail" tabindex="0"
						style="height: inherit; position: relative; overflow: hidden; background: rgb(248, 249, 250);">
						<!-- 카카오 지도 들어가는곳 -->
						<div id="map" style="width: 100%; height: 550px;"></div>
					</div>
					<div class="map_tit" style='margin-top: 40px'>
						<div class="title">
							HELLO.<br>${list.STAYNAME }
						</div>
						<div class="desc">
							${list.STAYADRESS }<br> <a class="phone"
								href="tel:0504-0904-2702">${list.TEL}</a> <a class="email"
								href="mailto:dansim.stay@gmail.com" target="_blank"
								rel="noreferrer">${list.SNS}</a>
						</div>
						<div class="links">
							<a href="http://instagram.com" target="_blank"
								rel="noopener noreferrer" class="insta">
								<div class="icon-insta"></div>
							</a>
						</div>
					</div>
				</div>
			<div class="container map_info" id="matjip">
            <ul class="info_list">
                
            </ul>
        </div>
			</div>




			<div class="container_full booking_faq" id="faq">
				<div class="container">
					<div class="faq_tit">
						<div class="left">안내사항</div>
						<div class="right">
							<div>숙소 이용에 대한 상세한 안내를 확인해 보세요.</div>
						</div>
					</div>
					<div class="faq_cont">
						<ul class="left tab_btn">
							<li class="active" role="presentation">예약 안내</li>
							<li class="" role="presentation">이용 안내</li>
							<li class="" role="presentation">환불 규정</li>
						</ul>
						<div class="right tab_cont">
							<div class="tab_view active">
								<div class="tit">예약 안내</div>
								<div class="cont">
									<dl>
										<dt>
											요금 기준
											<div class="line-break"></div>
										</dt>
										<dd>
											<p>
												<mark style="background-color: black;">
													<b style="color: #888; font-weight: bolder;"> &nbsp;
														정확한 객실 요금은 일정 선택 후 확인할 수 있습니다. &nbsp; </b>
												</mark>
												<br>&nbsp;
											</p>
											<table>
												<thead>
													<tr>
														<th
															style="color: #888; font-size: 12px; font-weight: bold;">숙소
														</th>
														<th
															style="color: #888; font-size: 12px; font-weight: bold;">
															인원(기준/최대)</th>
														<th
															style="color: #888; font-size: 12px; font-weight: bold;">요금
														</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td style="color: #888; font-size: 12px;">${list.STAYNAME }</td>
														<td style="color: #888; font-size: 12px;">
															 최소 ${list.STDPERSON}인 / 최대 ${list.OVERPERSON}인</td>
														<td style="color: #888; font-size: 12px;">${list.MINPRICE} ~ </td>
													</tr>
												</tbody>
											</table>
											<ul>
												<li>기준인원 ${list.STDPERSON}인이며, 최대 인원 ${list.OVERPERSON}인(영유아포함)까지 이용 가능한 숙소입니다.</li>
												<li>기준인원 초과 시 1인 1박당 2만원의 추가 요금이 발생합니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="cont">
									<dl>
										<dt>
											할인 혜택
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>한달 이상 사용자만 할인 혜택이 제공됩니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="cont">
									<dl>
										<dt>
											문의하기
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>예약과 이용 문의 060-700-5454</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
							<div class="tab_view hide">
								<div class="tit">이용 안내</div>
								<div class="cont">
									<dl>
										<dt>
											이용 규칙
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>체크인은 오후 3시, 체크아웃은 오후 12시입니다.</li>
												<li>최대인원을 초과하는 인원은 입실이 불가합니다.</li>
												<li>예약인원 외 방문객의 출입을 엄격히 제한합니다.</li>
												<li>모든 공간에서 절대 금연입니다. 위반 시 특수청소비가 청구됩니다.</li>
												<li>화재의 위험으로 모든 공간에서 화기 사용을 엄격히 금지합니다.</li>
												<li>취사 가능한 숙소이나, 연기와 냄새가 나는 음식(고기, 해산물 등)의 조리를 금지합니다.</li>
												<li>침구나 비품, 시설 등에 심각한 오염, 파손 및 분실이 발생한 경우 변상비가 청구됩니다.</li>
												<li>협의되지 않은 상업 사진 및 영상 촬영(광고용, 제품사진, 쇼핑몰, SNS마켓 포함), 드론
													촬영은 불가합니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="cont">
									<dl>
										<dt>
											실내 욕조
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>영유아와 어린이는 반드시 보호자의 동반 하에 안전하게 이용해 주시기 바랍니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
								<div class="cont">
									<dl>
										<dt>
											주차
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>주차가 가능한 숙소입니다.</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
							<div class="tab_view hide">
								<div class="tit">환불 규정</div>
								<div class="cont">
									<dl>
										<dt>환불 규정</dt>
										<dd>
											<table>
												<thead>
													<tr>
														<th>기준일</th>
														<th>환불 금액</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>체크인 15일전까지</td>
														<td>총 결제금액의 100% 환불</td>
													</tr>
													<tr>
														<td>체크인 10일전까지</td>
														<td>총 결제금액의 70% 환불</td>
													</tr>
													<tr>
														<td>체크인 7일전까지</td>
														<td>총 결제금액의 50% 환불</td>
													</tr>
													<tr>
														<td>체크인 3일전까지</td>
														<td>총 결제금액의 20% 환불</td>
													</tr>
													<tr>
														<td>체크인 2일전부터</td>
														<td>변경 / 환불 불가</td>
													</tr>
												</tbody>
											</table>
										</dd>
										<dt>
											숙박권 양도
											<div class="line-break"></div>
										</dt>
										<dd>
											<ul>
												<li>앙대요~</li>
											</ul>
										</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="../common/footer.jsp"%>
</body>
</html>
