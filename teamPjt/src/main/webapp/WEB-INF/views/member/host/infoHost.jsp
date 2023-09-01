<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
    <!-- fetchGet, fetchPost -->
    <script type="text/javascript" src="/resources/js/common.js"></script>
    
    <script type="text/javascript">
    window.addEventListener('load', function(){
    	
	    $("#newpww").on("focusout", function() {
	        checkPWMatch();
	    });

	    function checkPWMatch() {
	        var pw = $("#newpww").val();
	        var hasUppercase = /[A-Z]/.test(pw); // 대문자 포함 여부 검사
	        var hasLowercase = /[a-z]/.test(pw); // 소문자 포함 여부 검사
	        var hasNumber = /\d/.test(pw); // 숫자 포함 여부 검사

	        if (pw.length < 8 || pw.length > 20) {
	            signupMsg.innerHTML = "8자리 ~ 20자리 이내로 입력해주세요.";
	            return false;
	        }

	        if (pw.search(/\s/) != -1) {
	            signupMsg.innerHTML = "비밀번호는 공백 없이 입력해주세요.";
	            return false;
	        }

	        if (!hasUppercase) {
	            signupMsg.innerHTML = "대문자를 최소한 1자 이상 포함하여 입력해주세요.";
	            return false;
	        }

	        if (!hasLowercase) {
	            signupMsg.innerHTML = "소문자를 최소한 1자 이상 포함하여 입력해주세요.";
	            return false;
	        }

	        if (!hasNumber) {
	            signupMsg.innerHTML = "숫자를 최소한 1자 이상 포함하여 입력해주세요.";
	            return false;
	        }

	        signupMsg.innerHTML = "";
	        return true;
	    }

	    
    	
	    changeInfo.addEventListener('click', function(e){
	    	
	    	 if (!checkPWMatch()) {
	    	        e.preventDefault();
	    	        signupMsg.innerHTML = "비밀번호를 제대로 입력해주세요";
	    	        return false;
	    	    }
	   	 
		   	let memberEmail = email.value;
		   	let pw = newpww.value;
		   	let newpw= newpwCheck.value;
		   	let profile = imgFile.value;
		   	let memberId = id.value;
		   	
		     if(!memberEmail){
		   	  signupMsg.innerHTML="이메일을 입력해주세요";
		   	  return;
		     }
		     if(!pw){
		   	  signupMsg.innerHTML="비밀번호를 입력해주세요";
		   	  return;
		     }
		     if(!newpw){
		   	  signupMsg.innerHTML="비밀번호를 다시 한번 입력해주세요";
		   	  return;
		     }
		     
		     if(newpww.value == newpwCheck.value){
		    	 infoFrm.submit();
		    	 
		     } else{
		    	 signupMsg.innerHTML = "비밀번호가 일치하지 않습니다";
		    	 newpww.focus();  // 비밀번호 재입력 포커스
		    	 newpww.value='';  
		    	 newpwCheck.value='';
	       		 return;
		     }

    	});
	    
	    
	    // 비밀번호 보기
        $('.togglePW').on('click', function(){
        	// 이전 input 요소의 type이 password 인지 확인
            var input = $(this).prev('input');
            var isPassword = input.attr('type') === 'password';
            
            console.log("pw", isPassword);
            
            // true면 input 요소 text 저장해서 pw 보이게 
            if (isPassword) {
                input.attr('type', 'text');
                $(this).find('img').attr('src', '/resources/images/eye.svg');
            } else {
                input.attr('type', 'password');
                $(this).find('img').attr('src', '/resources/images/eyeoff.svg');
            }
        });
	    
	    
        
    });
    
    function result(map){
    	console.log('map.result : ', map.result);
		if(map.result == 'success'){   
  			location.href='/member/mypage/info?msg='+map.msg;
		} else{
			signupMsg.innerHTML="회원 정보 수정에 실패하였습니다";
		}	
    }
    
    
 	// 회원 탈퇴
	function memberQuit(url){
		memberId = document.querySelector('[id=id]').value
 		
		infoFrm.action = url;
		infoFrm.memberId.value=memberId;
		infoFrm.submit();
		
	};

    </script>

<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
</head>

<body style="overflow: visible;">
    <!-- 헤더 -->
    <%@ include file="../../common/header.jsp" %>
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ"
            height="0" width="0" title="googletagmanager-iframe"
            style="display:none;visibility:hidden"></iframe></noscript>
    <div id="fb-root" class=" fb_reset">
        <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
        <div style="position: absolute; top: -10000px; width: 0px; height: 0px;">
            <div></div>
        </div>
    </div>
   
    <script src="/static/js/common.js"></script>
    
    <div id="__next" data-reactroot="">
        <div>
                <div class="container sub_title">
                    <div class="tit">MY PAGE</div>
                </div>
                <div class="container mypage_wrap">
                    <div class="mypage_myinfo">
    					   <div class="tit">HOST ${sessionScope.memberId}</div>
                           <div class="my-count" role="link" tabindex="0">MEMBERSHIP INFORMATION</div>
                    </div>
                    <div class="newmypage_menu pc_only">
                           <ul>
                               <li class="active"><a href="./stayhost">숙소 관리</a></li>
                               <li class=""><a href="./reservation">예약 관리 </a></li>
                               <li class=""><a href="./income">수입 현황</a></li>
                               <li class=""><a href="./guide">호스트가이드</a></li>
                               <li class="active"><a href="./infoHost">회원 정보 수정</a></li>
                               <li class=""><a href="./message">메시지</a></li>                               
                           </ul>
                       </div>
                    <div class="mypage_content">
                        <div class="myedit_wrap">
                            <h3 class="my_tit pc_only">회원 정보 수정</h3>
                             <!-- ▶▶▶  forEach ▶▶▶  -->
                             <c:forEach items="${mem}" var="member" step="1">
                             <c:if test="${sessionScope.memberId == member.memberId}">
                             
                            <!--  프로필 form -->
                            <form id="infoFrm" name="infoFrm" method="post" action="/member/host/infoFrm"  enctype="multipart/form-data">
                                  <input type="hidden" name="memberId" value="${member.memberId }" id ='id'>
                                  <!-- 프로필 사진 -->
                                  <div class="profile_photo">
                                    <div class="input_box">
                                    		<input type="file" id="imgFile" name="files" title="프로필 사진" class="photo" 
                                    			style="width: 150px; height: 150px; background-size: cover; border-radius: 50%;" value="${sessionScope.member.profile}">
                                        	<input type="button" onclick="imgFile.click()" id="imgFile2" name="imgFile2" title="프로필 사진" class="btn_photo"
                                            	accept="image/jpeg, image/png">
                                 	</div>
                                            
                                    	 	
                                   <script>
                                    	$(function(){
                                    		let imgURL = "${file.profile.replace('\\','/')}";
                                    		
                                    		if(imgURL){
												if('${sessionScope.member.snsCk}' == 'Y'){
													
	                                    			$('#imgFile').attr("style", "background-image: url('${sessionScope.member.profile}'); background-size : cover;");
												
												} else {
													
	                                    			$('#imgFile').attr("style", "background-image: url(/member/mypage/display?fileName="+imgURL+"); background-size : cover;");
												}
                                    		}
                                    			
                                    		
                                    		$('#imgFile').change(function(){
                                    			
                                    			fileCheck();
                                    			
                                    			
                                    			var input = document.getElementById("imgFile");

                                    			var fReader = new FileReader();

                                    			fReader.readAsDataURL(input.files[0]);

                                    			fReader.onloadend = function(event){

                                    			    var img = event.target.result;

	                                    			console.log("img : ", img);
	                                    			
	                                    			$('#imgFile').attr("style", "background-image: url("+img+"); background-size : cover;");
	                                    			
                                    			}
                                    			
                                    		});
                                    		
                                    	});
                                    </script>
                                    <script type='text/javascript'>
										//1MB(메가바이트)는 1024KB(킬로바이트)
										var maxSize = 2048;
										
										function fileCheck() {
											//input file 태그.
											var file = document.getElementById('imgFile');
											//파일 경로.
											var filePath = file.value;
											//전체경로를 \ 나눔.
											var filePathSplit = filePath.split('\\'); 
											//전체경로를 \로 나눈 길이.
											var filePathLength = filePathSplit.length;
											//마지막 경로를 .으로 나눔.
											var fileNameSplit = filePathSplit[filePathLength-1].split('.');
											//파일명 : .으로 나눈 앞부분
											var fileName = fileNameSplit[0];
											//파일 확장자 : .으로 나눈 뒷부분
											var fileExt = fileNameSplit[1];
											//파일 크기
											var fileSize = file.files[0].size;
											
											console.log('파일 경로 : ' + filePath);
											console.log('파일명 : ' + fileName);
											console.log('파일 확장자 : ' + fileExt);
											console.log('파일 크기 : ' + fileSize);
										} 
									</script>
                                </div>   
                                <div class="myedit_box">
                                    <div class="input_box">
                                        <div class="tit">이메일</div>
                                        <div class="input">
                                        <input type="email" name="memberEmail" placeholder="@이메일 형식으로 입력해주세요"
                                                style=" -webkit-text-fill-color: black; margin-left: 12px;" value=${member.memberEmail } id='email'>
                                        </div>
                                    </div>
                                    <div class="input_box">
                                        <div class="tit">이름</div>
                                        <div class="input">
                                        	<input type="text" name="memberName" id='name'
                                                value=${member.memberName } style="color: rgb(128, 128, 128); -webkit-text-fill-color: rgb(128, 128, 128); margin-left: 12px;" readonly>
                                        </div>
                                    </div>
                                   
                                    <div class="input_box">
                                        <div class="tit">비밀번호</div>
                                        
                                        <div class="input">
	                                        <label style="display: flex;">
		                                        <input class="mypage_account_edit_password" type="password" id="newpww"
		                                                    name="pw" placeholder="변경할 비밀번호" style="margin-left: 8px;">
	                                            <button type="button"  class="togglePW" style="margin-right: -15px;"><img src="/resources/images/eyeoff.svg" alt=""></button>
	                                        </label>
                                        </div>
                                        
                                        <div class="input">
	                                        <label style="display: flex;">
		                                        <input class="mypage_account_edit_password" type="password" id="newpwCheck"
		                                                    name="newpw" placeholder="변경할 비밀번호 확인" style="margin-left: 8px;">
	                                            <button type="button"  class="togglePW" style="margin-right: -15px;"><img src="/resources/images/eyeoff.svg" alt=""></button>
	                                        </label>
                                        </div>
                                    </div>
                                    <div id="signupMsg" style="display: flex; justify-content: center; color:gray; font-weight:bold"></div>  <!-- msg 출력 -->
                                    <div class="bt_btns btn_submit">
                                    	<button type="button" class="btn_bk btn_sm" style="margin: 20px 0px; width: 100%;" id='changeInfo'>회원정보 변경</button>
                                    </div>
                                </div>
                             </form>
                      			
               				</c:if>
                            </c:forEach>
                               
                             
                            <div class="tit" style="padding-top: 22px; margin-left: 8px;"></div>
                            <div class="agree_box">
       					</div>
                          	<button type="button" class="btn_txt btn_quit" onclick="memberQuit('/member/mypage/memberQuit')" style="text-underline-position: under;">회원 탈퇴</button>
        		</div>
        	</div>
        </div>
    </div>
    </div>
    <!-- 푸터 -->
	<%@ include file="../../common/footer.jsp" %> -->
    <script src="/static/js/channelService.js"></script>
