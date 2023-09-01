<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>stayhost</title>
    <link rel="stylesheet" href="./css/host/host.css">
    
<script type="text/javascript">

window.addEventListener('load', function(){
    var roomView = document.getElementById('roomView');
    var roomViewBtn = document.getElementById('roomViewBtn');
    // 기본값 보여주지 않기
    var isRoomViewVisible = false;

    roomView.style.display = 'none';

    roomViewBtn.addEventListener('click', function(){ 
        if (isRoomViewVisible) {
            roomView.style.display = 'none';
        } else {
            roomView.style.display = '';
        }
        
        // 버튼 누를 때 마다 true / false 변경
        isRoomViewVisible = !isRoomViewVisible;
    });
    
 
    // roomName
    const deleteButtons = document.querySelectorAll('[data-bs-toggle="modal"][data-bs-target="#deleteModal"]');
    const deleteModalButton = document.getElementById("delete");
    
    console.log("deleteButtons",deleteButtons);
    console.log("deleteModalButton",deleteModalButton);

    deleteButtons.forEach(button => {
        button.addEventListener("click", function() {
            const roomNo = button.getAttribute("data-roomno");  // 삭제할 roomNo
            console.log("roomNo", roomNo);
            deleteModalButton.setAttribute("data-roomno", roomNo);
        });
    });


    deleteModalButton.addEventListener("click", function() {
        const selectedRoomNo = deleteModalButton.getAttribute("data-roomno");
        if (selectedRoomNo !== "") {
            const form = document.forms["deleteFrm"];
            //const roomNoInput = form.querySelector('input[name="deleteNo"]');
            //roomNoInput.value = selectedRoomNo;
			
            document.querySelector('input[name=delNo]').value = selectedRoomNo;
            
            form.submit();
        }
    });  
    
 	
    
});


</script>

<style>
.photo-container:hover .photo {
    filter: brightness(70%); 
}

.image-overlay {
    position: absolute; 
    top: 50%; 
    left: 50%; 
    transform: translate(-50%, -50%); 
    padding: 10px; 
    text-align: center; 
    display: none;
}

.image-overlay p {
    color: white; 
    margin: 0; 
    font-size:15px;
    font-weight:bold;
}   
 
.custom-modal {
  border-radius: 0;
  border: 1px solid #ced4da; 
  box-shadow: none; 
}

.photo-container:hover .image-overlay {
    display: block;
}
</style>


</head>
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
                           <!-- =================================== user 이름 !!!! =================================== -->
                           <div class="tit">HOST ${sessionScope.memberId}</div>
                           <div class="my-count" role="link" tabindex="0">MY ACCOMMODATION</div>
                       </div>
                       <div class="newmypage_menu pc_only">
                           <ul>
                               <li class="active"><a href="./stayhost">숙소 관리</a></li>
                               <li class=""><a href="./reservation">예약 관리 </a></li>
                               <li class=""><a href="./income">수입 현황</a></li>
                               <li class=""><a href="./guide">호스트가이드</a></li>
                               <li class=""><a href="./infoHost">회원 정보 수정</a></li>
                               <li class=""><a href="./message">메시지</a></li>                               
                           </ul>
                       </div>
                       <div class="mypage_content">
                           <div class="reserv_wrap mypage-reservation-info"">
                           	   <!-- ▶▶▶  forEach ▶▶▶  -->
                               <c:forEach items="${list}" var="vo" step="1">
                               <c:if test="${sessionScope.memberId == vo.memberId}">

                               <div class="reserv_box accepted">
                                   <div class="reserv_name">
                                   	   <label>
	                                       <!-- =============================== 숙소이름  ============================================-->
	                                       <p class="name"><span class="ellipsis">${vo.stayName }</span></p>
                                       </label>
                                   </div>
                                   <div class="stay_view">
                                       <div class="photo" 
                                           style="background-image: url('/display?fileName=${vo.mainPic1.replace('\\','/')}'); background-repeat: no-repeat; background-position: center center; background-size: cover;">
                                            <a href="../../editstay?stayNo=${vo.stayNo}">
                                            <span class="view">스테이 수정</span></a></div>
                                   </div>
                                       <div class="reserv_info">
                                           <!-- =============================== 숙소 분류 ============================================-->
                                           <div class="stay">${vo.stayType } / ${vo.stayLoc }</div>
                                           <p></p>
                                               <!-- =============================== 숙소 설명 ============================================-->
                                           <div class="option" style="line-height: 1.5;">${vo.stayInfo}<br></div>
                                           <div style="display: flex; gap: 10px;">
	                                           <button type="button" class="btn_bk btn_sm findstay_btn" style=" width:130px; margin-left:0px; margin-top:30px; background-color:white">
	                                           <a href="/addroom?stayNo=${vo.stayNo}" style='color: black;'>객실 추가 등록</a></button>
                                           </div>
                                           <button id="roomViewBtn" style="margin-top:20px; text-decoration: underline;">객실 보기</button>
                                       </div>
                               </div>
                               </c:if>
                               </c:forEach>
                            </div>
                                <form name= "deleteFrm" method="post" action="/member/host/deleteRoom">
	                                <div class="reserv_wrap mypage-reservation-info" style="width:1200px; border-bottom: none;">
		                                <!-- 객실 정보 -->
		                                <!-- ▶▶▶  forEach ▶▶▶  -->
		                                <div class="stay_view" id="roomView" style="display:flex;width:100%;">
		                               		<c:forEach items="${room}" var="room" step="1">
		                               			
			                                	<div id="divRoom" style="width:350px; margin: 0px; display: inline-block;">
			                                		<div class="photo-container">
					                                	<a href="../../../stay/roomInfo?stayName=${room.stayName }&roomName=${room.roomName}" style="display:flex;">
					                                       <div class="photo" style="background-image: url('/display?fileName=${room.roomPhoto.replace('\\','/')}'); background-repeat: no-repeat;
					                                        background-position: center center; background-size: cover; width: 330px; height: 200px; margin-top:50px;">
					                                        	 <div class="image-overlay"><p>객실 보기</p></div>
					                                        </div>
					                                    </a>  
				                                    </div>
			                                        <div class="reserv_info" style="margin-top:10px;">
			                                           <div class="stay" style= "font-size:15px;font-weight:bold;display:flex; justify-content:center">
			                                           	  <button type="button" data-bs-toggle="modal" data-bs-target="#deleteModal" data-roomno="${room.roomNo }">${room.roomName }</button></div>
					                                           <!-- Modal -->
																<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-top:100px">
																  <div class="modal-dialog" style="width:500px">
																    <div class="modal-content">
																      <div class="modal-header" style="background-color: black; color: white;">
																        <h2 class="modal-title fs-5" id="exampleModalLabel">객실 삭제</h2>
																        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
																      </div>
																      <div class="modal-body" style="height:70px; text-align:center; font-size:16px; padding-top:30px">
																        	객실을 삭제하시겠습니까?
																      </div>
																      <div class="modal-footer">
																        <button type="button" class="btn btn-light" data-bs-dismiss="modal">아니오</button>
																        <button type="button" class="btn btn-dark" style="width:60px" id="delete" data-roomno="">네</button>
																      </div>
																    </div>
																  </div>
																</div>
			                                           <p></p>
			                                           <div class="option" style="line-height: 2.5;display:flex; justify-content:center">${room.roomInfo }<br></div>
			                                        </div>
			                                    </div>
		                                	</c:forEach>
		                                	<input type="hidden" name="delNo" value="">
			                             </div>
		                             </div>
	                           </form>


                           <!-- =============================== 페이징 ============================================-->
                           <!-- <div class="paging"><a href="/" class="prev" title="이전 페이지">이전 페이지</a><a href="/"
                                   class="on">1</a><a href="/" class="next" title="다음 페이지">다음 페이지</a></div>  -->
                                  
                       </div>
                   </div>
               </div>
               
           </div><button class="custom-button-1"></button>
       </div>
   
    <!-- 푸터 -->
	<%@ include file="../../common/footer.jsp" %>
   
   </body>
</html>
</html>
</html>