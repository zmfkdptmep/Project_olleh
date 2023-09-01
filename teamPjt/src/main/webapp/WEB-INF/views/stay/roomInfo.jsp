<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${roomInfo.STAYNAME }</title>
<link href="../resources/css/common/48ab7619b7161b1c.css"
	rel="stylesheet">
<link href="../resources/css//common/5f0d2e1da89b35fb.css"
	rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<!-- <script src="/resources/js/list/list.js"></script> -->
<script src="/resources/js/reserved/calendar.js"></script>

<script>
        window.addEventListener('load', function () {
            // 문의하기
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
            
            
            // 날짜 선택
            let dateBtn = document.querySelector('.booking_summary .dayday');
            dateBtn.addEventListener('click', () => {
            	console.log('aa');
            	document.querySelector('.booking_summary .modalOverlay').style.display='';
            })
            
            let btn_close = document.querySelector('.container .container .btn_close');
            btn_close.addEventListener('click', () => {
            	console.log('a');
            	document.querySelector('.booking_summary .modalOverlay').style.display='none';
            }) 
            
            
            // 객실 사진 넘겨서 보기
            let nextBtn = document.querySelector('.swiper-button-next');
            let prevBtn = document.querySelector('.swiper-button-prev');
            let roomPic = document.querySelectorAll('.swiper-wrapper li .img');
            let pt = document.querySelector('.swiper-wrapper li');

            var idx = 0;
            nextBtn.addEventListener('click', ()=>{
            	console.log(idx);
                idx = (idx + 1) % roomPic.length;
                pt.innerHTML = roomPic[idx].outerHTML;
            })
            
            
			prevBtn.addEventListener('click', ()=>{
 		        console.log(idx);
				
 				if(idx == 0){
                	idx = roomPic.length;
	                --idx;
 		           	console.log(idx);
                	pt.innerHTML = roomPic[idx].outerHTML;
                }else if(idx == roomPic.length){
	                --idx;
                	pt.innerHTML = roomPic[idx].outerHTML;
                }else{
	 				idx--;
    	        	pt.innerHTML = roomPic[idx].outerHTML;
                }
            })
            
			
	
			
			let reservedBtn = document.querySelector('.btn-number-search');
            reservedBtn.addEventListener('click', function(){
				
				checkIn = document.querySelector('#reserved_checkIn').value.replaceAll('-','/');
				console.log(checkIn);
				checkOut = document.querySelector('#reserved_checkOut').value.replaceAll('-','/');
				console.log(checkOut);
			    
			    document.querySelector('.booking_summary .modalOverlay').style.display='none';
			    
			    
			    
			    document.querySelector('.btn_select').innerHTML = checkIn + ' ~ ' + checkOut + '   (' + document.querySelector('#reserved_day').value + '박)';
			});
            
            
           
            
            
            
			
			document.getElementById('paymentButton').addEventListener('click', function () {
			    // 파라메터로 checkIn / checkOut값을 받아 왔을 때
			    let checkInValue = "${param.checkIn}";
    			let checkOutValue = "${param.checkOut}";
			    
    			if(checkInValue != '' && checkOutValue != ''){
				    document.querySelector('#reserved_checkIn').value = checkInValue.split('/').join('-');
				    document.querySelector('#reserved_checkOut').value = checkOutValue.split('/').join('-');
    			}
			    // URL 생성
			    
			    const url = '/reserved/reserved?roomNo='+${roomInfo.ROOMNO}+'&checkIn='+document.querySelector('#reserved_checkIn').value.replaceAll('-','/')+'&checkOut='+document.querySelector('#reserved_checkOut').value.replaceAll('-','/');
			    
			    location.href = url;

			});
            
            
			// 파라매터로 받아온 날짜 차이 계산 함수
			function calculateDateDifference() {
				console.log("${param.checkIn}")
		        let checkInDate = new Date("${param.checkIn}");
		        let checkOutDate = new Date("${param.checkOut}");

		        // 날짜 차이 계산 (밀리초 단위)
		        let timeDifference = checkOutDate - checkInDate;
		        console.log(timeDifference);

		        // 일 단위로 변환
		        let daysDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
		        console.log(daysDifference);

		        // 출력 엘리먼트에 결과 표시
		        let dateDifferenceElement = document.getElementById("dateDifference");
		        dateDifferenceElement.innerHTML = '('+daysDifference+'박)';
		    }

		    // 함수 호출하여 날짜 차이 계산
		    calculateDateDifference();
        });
</script>
</head>
<body>
	<%@include file="../common/header.jsp"%>
	<div id="contents" class="findstay-room-detail">
		<div class="container sub_title">
			<div class="tit">BOOKING</div>
		</div>
		<div class="container">
			<div class="booking_wrap">
				<div class="booking_summary">
					<div class="name">${roomInfo.STAYNAME }</div>
					<c:if test="${param.checkIn eq null && param.checkOut eq null }">
					<div class="dayday" role="presentation">
						<div class="btn_select ">날짜를 선택해주세요.</div>
					</div>
					</c:if>
					<c:if test="${param.checkIn != null && param.checkOut != null }">
					<div class="dayday" role="presentation">
						<div class="btn_select ">${param.checkIn } ~ ${param.checkOut } <span id="dateDifference"></span></div>
					</div>
					</c:if>
					<%-- <a href="/reserved/reserved?stayName=${roomInfo.STAYNAME }&roomName=${roomInfo.ROOMNAME }&roomNo=${roomInfo.ROOMNO}"><button type="button" class="btn_bk pc_only">결제하기</button></a> --%>
					<c:set var="isMember" value="${sessionScope.memberId == roomInfo.MEMBERID}" />
					<c:if test="${isMember}">
						<a href="/editroom?roomNo=${roomInfo.ROOMNO }"><button type="button" class="btn_bk pc_only" id="paymentButton">수정하기</button></a>
					</c:if>
					<c:if test="${not isMember}">
						<button type="button" class="btn_bk pc_only" id="paymentButton">결제하기</button>
					</c:if>
					
					<%-- <a href="/reserved/reserved?roomNo=${roomInfo.ROOMNO}"><button type="button" class="btn_bk pc_only">결제하기</button></a> --%>




					<div class="modalOverlay" style="display: none">
						<div class="modalWrapper">
							<div class="modalInner">
								<div class="container">
									<div class="shared-calendar">
										<div class="DatePicker_calendar_wrap">
											<div class="DateRangePicker DateRangePicker_1">
												<div class=""
													style="width: 1080px; height: 450px; /*border: 1px solid #e4e4e4;*/ background: #fff; border-radius: 5px;">
													<div class="calendar-wrap" style="padding-top: 0px; margin-top: 60px;">
														<div class="calendar-middle-wrap" style="height: 400px;">
															<div class="cal_nav">
																<a href="javascript:;" class="nav-btn go-prev"></a> <span
																	class="year-month start-year-month">2023.08</span> <a
																	href="javascript:;" class="nav-btn go-next"></a>
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
                                                              <div class="cal_nav">
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
                                                                  <label id="check_out_day" class="check_day_count" style="font-size: 20px;"></label>
                                                                </p>
                                                      
                                                              </div>
                                                            </div>
                                                            <div id="buttonBtn">
                                                                
                                                                  <input type="hidden" id="reserved_day" name="reserved_day" value="">
                                                                  <input type="hidden" id="reserved_checkIn" name="reserved_checkIn" value="">
                                                                  <input type="hidden" id="reserved_checkOut" name="reserved_checkOut" value="">
                                                        
                                                                  <div class="btn-wrapper" style="position:absolute; bottom:5%; left:35%;">
                                                                    <button style=" border:0px; cursor: pointer;" type="submit" onclick="" class="btn-number-search">예약하기</button>
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
									<div class="btn_close" role="presentation" ></div>
								</div>
							</div>
						</div>
					</div>
				</div>





				<div class="booking_room">
					<div class="left room_info">
						<p class="tit">ROOM INFORMATION</p>
						<p class="name">${roomInfo.ROOMNAME }</p>
						<p class="price">-</p>
					</div>
 					<div class="room_img">
                        <div class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events swiper-container-autoheight"
                            id="findstay-room-detail-swiper" style="width: 950px">
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-button-next"></div>
                            <ul class="swiper-wrapper" style="transition-duration: 0ms; height: 540px; transform: translate1d(-950px, 0px, 0px);">
                                	<c:forEach items="${picList}" var="picList" step="1">
                                <li class="swiper-slide swiper-slide-duplicate swiper-slide-prev"
                                    data-swiper-slide-index="23" style="width: 950px;">
	                                    <div class="img"
	                                        <%-- style="background-image: url(&quot;${picList.field}&quot;); background-repeat: no-repeat; background-position: center center; background-size: cover; "> --%>
	                                        style="background-image: url(/resources/images/${picList.fileName.replace('\\','/')}); background-repeat: no-repeat; background-position: center center; background-size: cover; ">
	                                    </div>
                                </li>
                                	</c:forEach>
							</ul>
						</div>
					</div>
<%-- 					<div class="room_img">
						<div id="carouselExample" class="carousel slide">
							<div class="carousel-inner">
								<c:forEach items="${picList}" var="picList" step="1">
								<div class="carousel-item active">
									<img src="${picList.field}" class="d-block w-100" alt="..." style="width:100%; height: 540px;">
								</div>
								</c:forEach>
							</div>
							<button class="carousel-control-prev" type="button"
								data-bs-target="#carouselExample" data-bs-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Previous</span>
							</button>
							<button class="carousel-control-next" type="button"
								data-bs-target="#carouselExample" data-bs-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Next</span>
							</button>
						</div>
					</div> --%>
					
					
					
					<div class="left room_txt">
						${roomInfo.ROOMINFO }
<!-- 						<div class="plan-wrapper pc" role="presentation">
							<div class="plan"></div>
							<div class="txt">
								ROOM<br>PLAN
							</div>
						</div>
						<div class="plan-wrapper mo" role="presentation">
							<div class="plan"></div>
							<div class="txt">
								ROOM<br>PLAN
							</div>
						</div> -->
					</div>
					<div class="left room_etc">
 						<div class="tag">
 							<c:if test="${roomInfo.PET eq 'Y'}">
								<span>#애견 동반</span>
							</c:if>
 							<c:if test="${roomInfo.OVERPERSON > 4 }">
								<span>#고재가구</span>
							</c:if>
							<c:if test="${roomInfo.ROOMNAME eq 'A동' }">
								<span>#욕조</span>
							</c:if>
							<c:if test="${roomInfo.KITCHEN eq 'Y' }">
								<span>#조리가능</span>
							</c:if>
							<c:if test="${roomInfo.ROOMNAME eq 'A동'}">
								<span>#샤워부스</span>
							</c:if>
						</div>
						<div class="option">
							<p>체크인 16:00 / 체크아웃 12:00</p>
							<p>기준 인원 ${roomInfo.STDPERSON }명 (최대 인원 ${roomInfo.OVERPERSON }명)</p>
							<p>침대 ${roomInfo.BED }개</p>
						</div>
					</div>
				</div>
				<div class="room_service">
					<div class="row">
						<div class="tit">FEATURES</div>
						<ul class="service_list">
							<c:if test="${roomInfo.OVERPERSON > 4 }">
								<li><i class="icon-dogrib-kicin"></i>독립 키친</li>
							</c:if>
							<c:if test="${roomInfo.BATHROOM eq 'Y'}"> 
								<li><i class="icon-dogrib-hwajangsil"></i>독립 화장실</li>
							</c:if>
							
							<c:if test="${roomInfo.BEAMPROJECTOR eq 'Y'}">
								<li><i class="icon-bim-peurojegteo"></i>빔 프로젝터</li>
							</c:if>
							
							<c:if test="${roomInfo.PARKING eq 'Y'}"> 
								<li><i class="icon-juca"></i>주차</li>
							</c:if>
							
							<c:if test="${roomInfo.OVERPERSON > 4 }">
								<li><i class="icon-bigteibeul"></i>빅테이블</li>
							</c:if>
							
							<c:if test="${roomInfo.KITCHEN eq 'Y'}">
								<li><i class="icon-dogrib-kicin"></i>개인주방</li>
							</c:if>
							
							<c:if test="${roomInfo.ROOMNAME eq 'A동' }">
								<li><i class="icon-falseceontang"></i>노천탕</li>
							</c:if>
							
							<c:if test="${roomInfo.BABIQU }"> 
								<li><i class="icon-gaebyeol-bbqdekeu"></i>바비큐</li>
							</c:if>
							
							<c:if test="${roomInfo.TERRACE eq 'Y'}">
								<li><i class="icon-teraseu"></i>테라스</li>
							</c:if>
							
							<c:if test="${roomInfo.PET eq 'Y'}">
								<li><i class="icon-sancaegro"></i>산책로</li>
							</c:if>

						</ul>
					</div>
					<div class="row">
						<div class="tit">AMENITIES</div>
						<ul class="service_list">
							<li>TV</li>
							<li>냉장고</li>
							<li>세탁기</li>
							<li>헤어드라이어</li>
							<li>스피커</li>
							<li>전기포트</li>
							<li>전자레인지</li>
							<li>샴푸</li>
							<li>컨디셔너</li>
							<li>바디워시</li>
							<li>치약</li>
							<li>칫솔</li>
							<li>타월</li>
							<li>샤워가운</li>
							<li>빗</li>
							<li>바디스펀지</li>
							<li>생수</li>
							<li>토스터기</li>
							<li>핸드드립커피</li>
							<li>캡슐커피머신</li>
							<li>룸슬리퍼</li>
							<li>빅테이블</li>
						</ul>
					</div>
				</div>
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
												<b style="color: #888; font-weight: bolder;"> &nbsp; 정확한
													객실 요금은 일정 선택 후 확인할 수 있습니다. &nbsp; </b>
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
													<td style="color: #888; font-size: 12px;">${roomInfo.STAYNAME } / ${roomInfo.ROOMNAME }</td>
													<td style="color: #888; font-size: 12px;">최소
														${roomInfo.STDPERSON }인 / 최대 ${roomInfo.OVERPERSON }인</td>
													<td style="color: #888; font-size: 12px;">${roomInfo.PRICE }
														~</td>
												</tr>
											</tbody>
										</table>
										<ul>
											<li>기준인원 ${list.STDPERSON}인이며, 최대 인원
												${list.OVERPERSON}인(영유아포함)까지 이용 가능한 숙소입니다.</li>
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
	<%@include file="../common/footer.jsp"%>
</body>
</html>