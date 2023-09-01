<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="common/header.jsp" />

<style>
@media ( max-width : 900px) {
	.max-width900 {
		display: none;
	}
}

#carouselExampleInterval {
	
}

@media ( max-width : 1024px) {
	#carouselExampleInterval {
		top: 60px;
	}
}

@media ( max-width : 1024px) {
	#carouselExampleIndicators {
		top: 60px;
	}
}

/* @media ( max-width : 1024px ){
	.main_visual .house_info{
		top: 57%;
	} 
}	 */
h_logo img {
	height: 67px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	object-fit: contain
}

._routerWithArrow_wrapper__v67Nt {
	color: #181818;
	display: flex;
	justify-content: flex-end;
	align-items: center
}
</style>
<link href="/resources/css/main/mainList.css" rel="stylesheet">
<script>
let recStayArr;
let recStayWidth;

// mobile 모드 스테이 리스트 사이즈 조정 및 사이즈 변수 저장
window.addEventListener('resize', ()=>{
	recStayArr = document.querySelectorAll('div.recStay');
  	for(i=0; i<recStayArr.length; i++){
  		if(recStayArr[i].clientWidth != 0){
  			// 사이즈 변수 저장
  			recStayWidth = recStayArr[i].clientWidth;
  		}
  	}
  	let recBullets = document.querySelectorAll('span[name=recBullet]');
  	// 선택된 불릿의 index 저장
  	let index = Array.from(recBullets).findIndex(item => item.classList.contains('swiper-pagination-bullet-active'));
  	// 반응형 크기 조절을 위한 코드
  	recBox2.style.transform='translate3d('+ -recStayWidth*index +'px, 0px, 0px)';
  	
  	let popBullets = document.querySelectorAll('span[name=popBullet]');
  	let index2 = Array.from(popBullets).findIndex(item => item.classList.contains('swiper-pagination-bullet-active'));
  	popBox2.style.transform='translate3d('+ -recStayWidth*index2 +'px, 0px, 0px)';
});

window.addEventListener('load', ()=>{
	setMainImgsHeight();
	
   let timerId = 0;
   
   // 메인 케러셀 5초마다 넘겨주기
   timerId = window.setInterval(()=>{
	   BtnMainNext.click();
   }, 5000);
	
   // 마우스가 올라가면 interval 멈춤
   carouselExampleIndicators.addEventListener('mouseenter', ()=>{
	   clearInterval(timerId);
   })

   // 마우스가 떠나면 interval 재실행
   carouselExampleIndicators.addEventListener('mouseleave', () => {
	    timerId = window.setInterval(() => {
	        BtnMainNext.click();
	    }, 5000);
	});
   
   let newX = 0;
   let recPageNo = 1;
   // 추천 스테이 다음 버튼으로 넘기기
   BtnRecNext.addEventListener('click', ()=>{
		newX -= 330;
		if(document.querySelector('#recBox').style.transform.substr(12,5) == '-2310'){
			newX = 0;
		}
		recBox.style.transform='translate3d('+newX+'px, 0px, 0px)';
		recPageNo += 1;
		if(recPageNo == 9){
			recPageNo = 1;
		}
		recPage.innerHTML = recPageNo;
   })
	
   // 추천 스테이 이전버튼
   BtnRecPrev.addEventListener('click', ()=>{
	   newX += 330;
	   if(document.querySelector('#recBox').style.transform.substr(12,3) == '0px'){
		   newX = -2310;
	   }
	   recBox.style.transform='translate3d('+newX+'px, 0px, 0px)';
		recPageNo -= 1;
		if(recPageNo == 0){
			recPageNo = 8;
		}
		recPage.innerHTML = recPageNo;
   })

   // 처음 윈도우 로드시 width 변수 저장
   recStayArr = document.querySelectorAll('div.recStay');
  	for(i=0; i<recStayArr.length; i++){
  		if(recStayArr[i].clientWidth != 0){
  			recStayWidth = recStayArr[i].clientWidth;
  		}
  	}
   

   // 최신 스테이 불릿 클릭 시 검정색 
   let recBullets = document.querySelectorAll('span[name=recBullet]');
   // 첫 번째 불릿 검정색 설정
   recBullets[0].classList.add('swiper-pagination-bullet-active');
   recBullets.forEach((recBullet, index) =>{
	   recBullet.addEventListener('click', ()=>{
		   // 검정색인 불릿 선택
		   let activeBullet = document.querySelector('.swiper-pagination-bullet-active');
		   // 클래스 제거(검정색 제거)
		   activeBullet.classList.remove('swiper-pagination-bullet-active');
		   // 선택된 불릿 검정색으로 변경
		   recBullet.classList.add('swiper-pagination-bullet-active');
		   recBox2.style.transform='translate3d('+ -recStayWidth*index +'px, 0px, 0px)';
	   })
   })

   // 인기 스테이 불릿 클릭 시 검정색 
   let popBullets = document.querySelectorAll('span[name=popBullet]');
   // 첫 번째 불릿 검정색 설정
   popBullets[0].classList.add('swiper-pagination-bullet-active');
   popBullets.forEach((popBullet, index) =>{
	   popBullet.addEventListener('click', ()=>{
		   // 검정색인 불릿 선택
		   let activeBullet = document.querySelectorAll('.swiper-pagination-bullet-active')[1];
		   // 클래스 제거(검정색 제거)
		   activeBullet.classList.remove('swiper-pagination-bullet-active');
		   // 선택된 불릿 검정색으로 변경
		   popBullet.classList.add('swiper-pagination-bullet-active');
		   popBox2.style.transform='translate3d('+ -recStayWidth*index +'px, 0px, 0px)';
	   })
   })
   
   let popNewX = 0;
   let popPageNo = 1;
   btnPopNext.addEventListener('click', ()=>{
	   popNewX -= 440;
	   if(document.querySelector('#popBox').style.transform.substr(12,5) == '-3080'){
		   popNewX = 0;
	   }
	   popBox.style.transform='translate3d('+ popNewX +'px, 0px, 0px)';
	   popPageNo += 1;
	   if(popPageNo == 9){
		   popPageNo = 1;
	   }
	   popPage.innerHTML = popPageNo;
   })
   
   btnPopPrev.addEventListener('click', ()=>{
	   popNewX += 440;
	   if(document.querySelector('#popBox').style.transform.substr(12,3) == '0px'){
		   popNewX = -3080;
	   }
	   popBox.style.transform='translate3d('+ popNewX +'px, 0px, 0px)';
	   popPageNo -= 1;
	   if(popPageNo == 0){
		   popPageNo = 8;
	   }
	   popPage.innerHTML = popPageNo;
   })
   
   // 좋아요 버튼
   let btnLikes = document.querySelectorAll('.btn_like');
   let memberId = document.querySelector('#mainMemberId').value;
   btnLikes.forEach((btnLike, index)=>{
	   btnLike.addEventListener('click', ()=>{
		   if(memberId == null || memberId == ''){
			   alertPopOn('로그인 후 이용하세요.');
		   }else{
			   let stayNo = btnLike.children.likeStayNo.value;
			   if(!btnLike.classList.contains('on')){
				   btnLike.classList.add('on');
				   if(index == 0){
					   btnLikes[8].classList.add('on');
				   }
				   if(index == 1){
					   btnLikes[9].classList.add('on');
				   }
				   if(index == 2){
					   btnLikes[10].classList.add('on');
				   }
				   if(index == 8){
					   btnLikes[0].classList.add('on');
				   }
				   if(index == 9){
					   btnLikes[1].classList.add('on');
				   }
				   if(index == 10){
					   btnLikes[2].classList.add('on');
				   }
				   if(index == 19){
					   btnLikes[27].classList.add('on');
				   }
				   if(index == 20){
					   btnLikes[28].classList.add('on');
				   }
				   if(index == 27){
					   btnLikes[19].classList.add('on');
				   }
				   if(index == 28){
					   btnLikes[20].classList.add('on');
				   }
				   
	               	let data = {
	    					stayNo : stayNo
	    					, memberId: memberId
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
				      .then(map => {console.log(map);});
			   }else{
				   btnLike.classList.remove('on');
				   if(index == 0){
					   btnLikes[8].classList.remove('on');
				   }
				   if(index == 1){
					   btnLikes[9].classList.remove('on');
				   }
				   if(index == 2){
					   btnLikes[10].classList.remove('on');
				   }
				   if(index == 8){
					   btnLikes[0].classList.remove('on');
				   }
				   if(index == 9){
					   btnLikes[1].classList.remove('on');
				   }
				   if(index == 10){
					   btnLikes[2].classList.remove('on');
				   }
				   if(index == 19){
					   btnLikes[27].classList.remove('on');
				   }
				   if(index == 20){
					   btnLikes[28].classList.remove('on');
				   }
				   if(index == 27){
					   btnLikes[19].classList.remove('on');
				   }
				   if(index == 28){
					   btnLikes[20].classList.remove('on');
				   }
				   
                   let data = {
       					stayNo : stayNo
       					,memberId: memberId
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
	   			      .then(map => {console.log(map);});
			   }
		   }
	   })
   })
   
})
window.addEventListener('resize', setMainImgsHeight);


// 메인 이미지 height 값 조절 ( width 대비 0.45배 )
function setMainImgsHeight(){
	let mainImgs = document.querySelectorAll('div.carousel-item>a');
	let mainImg = document.querySelector('div.carousel-item.active>a');
	let height;
	let width
	
	for(i=0; i<mainImgs.length; i++){
		width = mainImg.clientWidth;
		height = width * 0.45;
		
		mainImgs[i].style.height = height + 'px';
	}
}
</script>
<!-- 메인 케러셀 -->
<div id="carouselExampleIndicators" class="carousel slide">
	<div class="carousel-indicators">
		<c:forEach items="${ listStay }" var="i" varStatus="status">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="${ status.index }"
				class="${ status.index eq 0 ? 'active' : ''}"
				aria-current="${ status.index eq 0 ? true : '' }"
				aria-label="Slide ${ status.index + 1 }"></button>
		</c:forEach>
	</div>
	<div class="carousel-inner main_visual container_wide">
		<c:forEach items="${ listStay }" var="stay" varStatus="status">
			<div class="carousel-item ${ status.index eq 0 ? 'active' : '' }">
				<a href="/stay/room?stayName=${ stay.stayName }"
					style="display: flex; align-items: center"> <img
					src="/resources/images/${ stay.mainPic1 }" class="d-block"
					style="width: 100%" alt="..."></a>
				<!-- 네모박스 (info) -->
				<div class="house_info max-width900">
					<p class="h_logo">
						<img
							src="//images.stayfolio.com/system/pictures/images/000/188/390/original/7a8a974ed01035f780b9246580258800b25c6a57.jpg?1689657777"
							alt="logo_url">
					</p>
					<p class="txt">${ stay.stayInfo }</p>
					<p class="event">${ stay.stayName }</p>
					<p class="more"><a href="/stay/room?stayName=${ stay.stayName }">read more</a></p>
				</div>
			</div>
		</c:forEach>
	</div>
	<button class="carousel-control-prev" type="button"
		data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Previous</span>
	</button>
	<button class="carousel-control-next" type="button" id="BtnMainNext"
		data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="visually-hidden">Next</span>
	</button>
</div>
<!-- 추천 스테이 -->
<div class="container main_new">
	<div class="recom_title">오직 올래갈래에서만</div>
	<div class="_routerWithArrow_wrapper__v67Nt">
		<button id="router_mobile" type="button">
			오직 올래갈래에서만<span
				style="box-sizing: border-box; display: inline-block; overflow: hidden; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px; position: relative; max-width: 100%;"><span
				style="box-sizing: border-box; display: block; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px; max-width: 100%;"><img
					alt="" aria-hidden="true"
					src="data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%2715%27%20height=%2715%27/%3e"
					style="display: block; max-width: 100%; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px;"></span><img
				alt="router_with_arrow"
				srcset="https://www.stayfolio.com/web/images/main/ico_next.svg 1x, https://www.stayfolio.com/web/images/main/ico_next.svg 2x"
				src="https://www.stayfolio.com/web/images/main/ico_next.svg"
				decoding="async" data-nimg="intrinsic"
				style="position: absolute; inset: 0px; box-sizing: border-box; padding: 0px; border: none; margin: auto; display: block; width: 0px; height: 0px; min-width: 100%; max-width: 100%; min-height: 100%; max-height: 100%;"></span>
		</button>
	</div>
	<div class="_routerWithArrow_wrapper__v67Nt">
		<button id="router" type="button">
			전체 보기<span
				style="box-sizing: border-box; display: inline-block; overflow: hidden; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px; position: relative; max-width: 100%;"><span
				style="box-sizing: border-box; display: block; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px; max-width: 100%;"><img
					alt="" aria-hidden="true"
					src="data:image/svg+xml,%3csvg%20xmlns=%27http://www.w3.org/2000/svg%27%20version=%271.1%27%20width=%2716%27%20height=%2716%27/%3e"
					style="display: block; max-width: 100%; width: initial; height: initial; background: none; opacity: 1; border: 0px; margin: 0px; padding: 0px;"></span><img
				alt="router_with_arrow"
				srcset="https://www.stayfolio.com/web/images/main/ico_next.svg 1x, https://www.stayfolio.com/web/images/main/ico_next.svg 2x"
				src="https://www.stayfolio.com/web/images/main/ico_next.svg"
				decoding="async" data-nimg="intrinsic"
				style="position: absolute; inset: 0px; box-sizing: border-box; padding: 0px; border: none; margin: auto; display: block; width: 0px; height: 0px; min-width: 100%; max-width: 100%; min-height: 100%; max-height: 100%;"></span>
		</button>
	</div>
	<div
		class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events stay_list"
		id="main-new-pc">
		<div class="swiper-button-prev" id="BtnRecPrev"></div>
		<div class="swiper-button-next" id="BtnRecNext"></div>
		<div class="swiper-pagination swiper-pagination-fraction">
			<span id="recPage" class="swiper-pagination-current">1</span> / <span
				class="swiper-pagination-total">8</span>
		</div>
		<div class="swiper-wrapper" id="recBox"
			style="transition-duration: 0ms; transform: translate3d(-0px, 0px, 0px);">
			<c:forEach items="${ listStay }" var="stay" varStatus="status">
				<div class="swiper-slide stay_box"
					data-swiper-slide-index="${ status.index }"
					style="z-index: 1; width: 330px;">
					<!-- 좋아요 리스트와 비교하여 하트 색 바꿔주기 -->
					<c:forEach items="${ likeList }" var="like">
						<c:if test="${ like.stayNo eq stay.stayNo }">
							<c:set var="res" value="on"></c:set>
						</c:if>
					</c:forEach>
					<button type="button" class="btn_like ${ res }">
						<input type="hidden" name="likeStayNo" value="${ stay.stayNo }">
						<span>관심스테이</span>
					</button>
					<c:set var="res" value=""></c:set>
					
					<a href="/stay/room?stayName=${ stay.stayName }">
						<div role="img" aria-label="main_image" class="img"
							style="background: url(/resources/images/${stay.mainPic1.replace('\\','/')}) center center / cover no-repeat;">
							<span>
								<div class="_badge_badge_wrapper__h9IsV">
									<div class="_badge_exclusive__prNZN">
										<span class="_badge_txt__fonwF">EXCLUSIVE</span>
									</div>
								</div>
							</span>
						</div>
						<div class="name">${ stay.stayName }</div>
						<div class="other">
							<span>${ stay.stayLoc }</span><span>₩${ stay.minPrice } ~
								₩${ stay.maxPrice }</span>
						</div>
					</a>
					<ul>
						<li class="btn_more"><a
							href="/stay/room?stayName=${ stay.stayName }">예약하기</a></li>
					</ul>
				</div>
			</c:forEach>
			<c:forEach begin="0" end="2" step="1" var="i">
				<div class="swiper-slide stay_box"
					data-swiper-slide-index="${ i+9 }"
					style="z-index: 1; width: 330px;">
					<c:forEach items="${ likeList }" var="like">
						<c:if test="${ like.stayNo eq listStay[i].stayNo }">
							<c:set var="res" value="on"></c:set>
						</c:if>
					</c:forEach>
					<button type="button" class="btn_like ${ res }">
						<input type="hidden" name="likeStayNo" value="${ listStay[i].stayNo }">
						<span>관심스테이</span>
					</button>
					<c:set var="res" value=""></c:set>
					<a href="/stay/room?stayName=${ listStay[i].stayName }">
						<div role="img" aria-label="main_image" class="img"
							style="background: url(/resources/images/${listStay[i].mainPic1.replace('\\','/')}) center center / cover no-repeat;">
							<span>
								<div class="_badge_badge_wrapper__h9IsV">
									<div class="_badge_exclusive__prNZN">
										<span class="_badge_txt__fonwF">EXCLUSIVE</span>
									</div>
								</div>
							</span>
						</div>
						<div class="name">${ listStay[i].stayName }</div>
						<div class="other">
							<span>${ listStay[i].stayLoc }</span><span>₩${ listStay[i].minPrice }
								~ ₩${ listStay[i].maxPrice }</span>
						</div>
					</a>
					<ul>
						<li class="btn_more"><a
							href="/stay/room?stayName=${ stay.stayName }">예약하기</a></li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
	<div
		class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events stay_list"
		id="main-new-mobile">
		<div
			class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets">
			<c:forEach items="${ listStay }" var="stay" varStatus="status">
				<span name="recBullet" class="swiper-pagination-bullet"></span>
			</c:forEach>

		</div>
		<div class="swiper-wrapper" id="recBox2"
			style="transition-duration: 0ms; transform: translate3d(-0px, 0px, 0px);">
			<c:forEach items="${ listStay }" var="stay" varStatus="status">
				<div class="swiper-slide stay_box recStay"
					data-swiper-slide-index="${ status.index }" style="z-index: 1;">
					<c:forEach items="${ likeList }" var="like">
						<c:if test="${ like.stayNo eq stay.stayNo }">
							<c:set var="res" value="on"></c:set>
						</c:if>
					</c:forEach>
					<button type="button" class="btn_like ${ res }">
						<input type="hidden" name="likeStayNo" value="${ stay.stayNo }">
						<span>관심스테이</span>
					</button>
					<c:set var="res" value=""></c:set>
					<a href="/stay/room?stayName=${ stay.stayName }">
						<div role="img" aria-label="main_image" class="img"
							style="background: url(/resources/images/${stay.mainPic1.replace('\\','/')}) center center / cover no-repeat;">
							<span>
								<div class="_badge_badge_wrapper__h9IsV">
									<div class="_badge_exclusive__prNZN">
										<span class="_badge_txt__fonwF">EXCLUSIVE</span>
									</div>
								</div>
							</span>
						</div>
						<div class="name">${ stay.stayName }</div>
						<div class="other">
							<span>${ stay.stayLoc }</span><span>₩${ stay.minPrice } ~
								₩${ stay.maxPrice }</span>
						</div>
					</a>
					<ul>
						<li class="btn_more"><a
							href="/stay/room?stayName=${ stay.stayName }">예약하기</a></li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
</div>




<!-- 인기순 -->
<div class="container_full main_viprecom">
	<div class="container main_recommend">
		<div class="recom_title false">추천 인기 스테이</div>
		<!-- <button type="button" class="btn_refresh">새로고침</button> -->
		<div
			class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events stay_list"
			id="main-recommend-pc">
			<div class="swiper-button-prev" id="btnPopPrev"></div>
			<div class="swiper-button-next" id="btnPopNext"></div>
			<div class="swiper-pagination swiper-pagination-fraction">
				<span id="popPage" class="swiper-pagination-current">1</span> / <span
					class="swiper-pagination-total">8</span>
			</div>
			<div class="swiper-wrapper" id="popBox"
				style="transition-duration: 0ms; transform: translate3d(-0px, 0px, 0px);">
				<c:forEach items="${ listPopStay }" var="stay" varStatus="status">
					<div class="swiper-slide stay_box"
						data-swiper-slide-index="${ status.index }"
						style="z-index: 1; width: 440px;">
						<c:forEach items="${ likeList }" var="like">
							<c:if test="${ like.stayNo eq stay.stayNo }">
								<c:set var="res" value="on"></c:set>
							</c:if>
						</c:forEach>
						<button type="button" class="btn_like ${ res }">
							<input type="hidden" name="likeStayNo" value="${ stay.stayNo }">
							<span>관심스테이</span>
						</button>
						<c:set var="res" value=""></c:set>
						<a href="/stay/room?stayName=${ stay.stayName }"><div
								role="img" aria-label="main_image" class="img"
								style="background: url(/resources/images/${stay.mainPic1.replace('\\','/')}) center center/cover no-repeat;">
								<span><div class="_badge_badge_wrapper__h9IsV"></div></span>
							</div>
							<div class="name">${ stay.stayName }</div>
							<div class="other">
								<span>${ stay.stayLoc }</span><span>₩${ stay.minPrice } ~
									₩${ stay.maxPrice }</span>
							</div></a>
						<ul>
							<li class="btn_more"><a
								href="/stay/room?stayName=${ stay.stayName }"
								style="color: white;">예약하기</a></li>
						</ul>
					</div>
				</c:forEach>
				<c:forEach begin="0" end="1" step="1" var="i">
					<div class="swiper-slide stay_box"
						data-swiper-slide-index="${ i+9 }"
						style="z-index: 1; width: 440px;">
						<c:forEach items="${ likeList }" var="like">
							<c:if test="${ like.stayNo eq listPopStay[i].stayNo }">
								<c:set var="res" value="on"></c:set>
							</c:if>
						</c:forEach>
						<button type="button" class="btn_like ${ res }">
							<input type="hidden" name="likeStayNo" value="${ listPopStay[i].stayNo }">
							<span>관심스테이</span>
						</button>
						<c:set var="res" value=""></c:set>
						<a href="/stay/room?stayName=${ listPopStay[i].stayName }"><div
								role="img" aria-label="main_image" class="img"
								style="background: url(/resources/images/${listPopStay[i].mainPic1.replace('\\','/')}) center center/cover no-repeat;">
								<span><div class="_badge_badge_wrapper__h9IsV"></div></span>
							</div>
							<div class="name">${ listPopStay[i].stayName }</div>
							<div class="other">
								<span>${ listPopStay[i].stayLoc }</span><span>₩${ listPopStay[i].minPrice }
									~ ₩${ listPopStay[i].maxPrice }</span>
							</div></a>
						<ul>
							<li class="btn_more"><a
								href="/stay/room?stayName=${ listPopStay[i].stayName }" style="color:white">예약하기</a></li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
		<div
			class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events stay_list"
			id="main-recommend-mobile">
			<div
				class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets">
				<c:forEach items="${ listPopStay }">
					<span name="popBullet" class="swiper-pagination-bullet"></span>
				</c:forEach>
			</div>
			<div class="swiper-wrapper" id="popBox2"
				style="transition-duration: 0ms; transform: translate3d(-0px, 0px, 0px);">
				<c:forEach items="${ listPopStay }" var="stay" varStatus="status">
					<div class="swiper-slide stay_box popStay"
						data-swiper-slide-index="${ status.index }" style="z-index: 1;">
						<c:forEach items="${ likeList }" var="like">
							<c:if test="${ like.stayNo eq stay.stayNo }">
								<c:set var="res" value="on"></c:set>
							</c:if>
						</c:forEach>
						<button type="button" class="btn_like ${ res }">
							<input type="hidden" name="likeStayNo" value="${ stay.stayNo }">
							<span>관심스테이</span>
						</button>
						<c:set var="res" value=""></c:set>
						<a href="/stay/room?stayName=${ stay.stayName }"><div
								role="img" aria-label="main_image" class="img"
								style="background: url(/resources/images/${stay.mainPic1.replace('\\','/')}) center center/cover no-repeat;">
								<span><div class="_badge_badge_wrapper__h9IsV">
										<div class="_badge_promo__vtoja">
											<span class="_badge_txt__fonwF">PROMO</span>
										</div>
										<div class="_badge_exclusive__prNZN">
											<span class="_badge_txt__fonwF">EXCLUSIVE</span>
										</div>
									</div></span>
							</div>
							<div class="name">${ stay.stayName }</div>
							<div class="other">
								<span>${ stay.stayLoc }</span><span>₩${ stay.minPrice } ~
									₩${ stay.maxPrice }</span>
							</div></a>
						<ul>
							<li class="btn_more"><a
								href="/stay/room?stayName=${ stay.stayName }"
								style="color: white">예약하기</a></li>
						</ul>
					</div>

				</c:forEach>

			</div>
		</div>
	</div>
</div>
<!-- 좋아요 리스트 받아오기 위함 -->
<input type="hidden" name="memberId" id="mainMemberId" value="${ sessionScope.memberId }">
<jsp:include page="common/footer.jsp" />