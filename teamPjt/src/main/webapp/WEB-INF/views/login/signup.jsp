<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<jsp:include page="../common/header.jsp" />
<html>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- ?v=<new java.util.Date().getTime()>을 붙이면 수정사항이 바로바로 새로고침 됨-->
<script src="/resources/js/member/signupCheck.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<head>
<link rel="stylesheet" href="/resources/css/login/signup.css">

<meta charset="UTF-8">
<title>SIGN UP</title>
</head>

<script>
window.addEventListener('load',function(){

	document.querySelector('#naverIdLogin_loginButton>img').height=0;
	
    // 입력 필드에 변경 사항이 있을 때 유효성 검사를 실행
    var inputFields = document.querySelectorAll('input');
    inputFields.forEach(function (input) {
        input.addEventListener('input', function () {
            validateInput(this);
        });
    });
});

	// 입력 유효성 검사와 오류 메시지 표시를 처리하는 함수
	function validateInput(tag) {
	    var name = tag.getAttribute('name');
	    var value = tag.value.trim();
	    
	    
	    // 'pw' 필드 유효성 검사
	    if (name === 'pw') {
	        var pwStatus = signup.pw_status(value);
	        var pwMessageDiv = document.querySelector('#signUpPw + .valid');
	        pwMessageDiv.textContent = pwStatus.desc;
	        pwMessageDiv.style.display = pwStatus.code === 'valid' ? 'none' : 'block';
	    }
	
	    // 'pw_ck' 필드(비밀번호 확인) 유효성 검사
	    if (name === 'pw_ck') {
	        var pwCkStatus = signup.pw_ck_status(value);
	        var pwCkMessageDiv = document.querySelector('#pwCheck + .valid');
	        pwCkMessageDiv.textContent = pwCkStatus.desc;
	        pwCkMessageDiv.style.display = pwCkStatus.code === 'valid' ? 'none' : 'block';
	    }
	}

$(document).ready(function() {
	// 아이디 중복 검사 
	// 버튼 클릭 시 함수 실행
	$('#btnid').on('click', function() {
		idCheck();
	});
	
	//유효성 검사
	$('.chk').on('keyup', function(){

		if($(this).attr('name') == 'memberId') {
			if(event.keyCode == 13) { idCheck(); }
			else {
				$(this).removeClass('chked');
				validate( $(this) );
			}
		} else {
			validate($(this));
		}
	})
}); 
	// 아이디 체크 
	function idCheck() {
		var $id = $('[name=memberId]').eq(1);
		// 올바른 아이디 입력 형태인지 파악하여 
		// 유효한 아이디의 경우 서버에서 중복확인
		if($id.hasClass('chked')) return;
		console.log('go check');
		
		var data = signup.tag_status($id);
		console.log(data);
		console.log("data.code : ",data.code);
		// 유효하지 않다면 중복확인 불필요
		if(data.code != 'valid') {
			$id.focus();
			 $('.valid').eq(0).html(data.desc);
			return;
		}
		   $.ajax({
		        type: 'post',
		        url: '/idCheck',
		        contentType: 'application/json', // 데이터 전송 형식을 JSON으로 설정
		        data: JSON.stringify({memberId: $id.val()}), // 아이디 정보를 JSON 형식으로 변환하여 전송
		        success: function(res) {
		           	console.log("res.success : ",res.success);
		           	console.log("res.result : ",res.result);
		           	console.log("res.msg : ",res.msg);
		           	console.log("res : ", res);
	
		            data = signup.id_usable(res);
		            console.log(res);
		            
		            // 중복 확인 결과에 따라 아이디 입력란 옆에 메시지를 표시
		            $('#validplz').html(res.msg);
		            let valClass = '';
		            if(res.result == 'success'){
		            	valClass = 'valid';
		            } else {
		            	valClass = 'invalid'
		            }
		            $('#validplz').removeClass();
		            $('#validplz').addClass(valClass);
		            //display_status($('#validplz'), data);
		            $id.addClass('chked');
		        },
		        error: function(req, text) {
		            alert(text + ': ' + req.status);
		        }
		    });
	}

	// 입력 요소를 검증하고 검증 결과에 따라 상태를 업데이트
	function validate(t) {
		var data = signup.tag_status(t);
		display_status(t.siblings('div'), data);
	}
	
	// 요소의 내용과 클래스를 업데이트
	function display_status(div, data) {
		div.text(data.desc);
		// 이전에 적용된 클래스들 모두 제거
		div.removeClass();
		div.addClass(data.code)
	}
	
	
	// 생년월일 데이터 합산
	function combineDate() {
	  const birth_year = document.getElementById("birth-year").value;
	  const birth_month = document.getElementById("birth-month").value;
	  const birth_day = document.getElementById("birth-day").value;
	  const birthday = birth_year + "-" + birth_month + "-" + birth_day;
	  document.getElementById("birthday").value = birthday;
	}
	
	// 이메일 데이터 합산
	function combineEmail() {
		  const emailTxt = document.getElementById("email-txt").value;
		  const domainTxt = document.getElementById("domain-txt").value;
		  const memberEmail = emailTxt + "@" + domainTxt;
		  document.getElementById("memberEmail").value = memberEmail;
		}


	// 로그인 폼 제출
	function go_join() {
	    if ($('[name=memberName]').val() == '') {
	        alert('이름을 입력하세요.');
	        $('[name=memberName]').focus();
	        return;
	    }
	
	    // 필수 항목의 유효성을 판단
	    // 중복 확인한 경우
	    if ($('[name=memberId]').eq(1).hasClass('chked')) {
	        // 이미 사용중인 경우는 회원가입 불가
	        if ($('#validplz').hasClass('invalid')) {
	            alert('회원가입 불가\n' + signup.id.unusable.desc);
	            $('[name=memberId]').focus();
	            //event.preventDefault(); // 폼 제출 막기
	            return;
	        }
	        
	    } else {
	        // 중복 확인 하지 않은 경우
	        if (!item_check(signup.tag_status($('[name=memberId]')))	
	        ) return;	
	        else {
	            alert('회원가입 불가\n'+data.desc);
	            $('[name=memberId]').focus();
	            return;
	        }
	    }
	    
 	// 이메일 유효성 검사
    var emailInput = document.getElementById("email-txt");
    var emailValue = emailInput.value;

    var domainInput = document.getElementById("domain-txt");
    var domainValue = domainInput.value;

    if (emailValue.trim() === "" || domainValue.trim() === "") {
        alert("이메일을 입력해주세요.");
        return;
    }

    
    // 필수 약관 동의 검사
    if (!checkRequiredAgreements()) {
        alert('필수 약관에 동의해야 회원가입이 가능합니다.');
        return;
    }
    function checkRequiredAgreements() {
        var serviceAgree = $("#check_service").prop("checked");
        var privacyAgree = $("#check_privacy").prop("checked");
        var aboveAgree = $("#check_above").prop("checked");

        return serviceAgree && privacyAgree && aboveAgree;
    }
       
    
	function item_check(item) {
	    var data = item;
	    if (data.code == 'invalid') {
	        alert('회원가입 불가합니다. \n' + data.desc);
	        item.focus();
	        return ;
	    } else return true;
	}

    if (!item_check(signup.tag_status($('[name=pw]')))) return;
    if (!item_check(signup.tag_status($('[name=pw_ck]')))) return;
    
	//form 데이터를 서버로 제출 
    $('form').submit();
  
}


</script>
<body>
	<div id="contents">
		<div class="container sub_title">
			<div class="tit">JOIN</div>
			<div class="txt">회원가입</div>
		</div>
	<form action="/login/signupAction" name='signupForm' method="post">
		<div class="container">
			<div class="login_wrap">
					<div class="form_wrap">
<p class="w-pct60 right" style="margin: 0 auto; padding-bottom: 5px; font-size: 11px; align-text: left;">*는 필수 입력 항목입니다.</p>
						<div class="input_box">
							<table>
							  <tr>
							    <th class="tit">아이디 *</th>
							    <td>
							    <div style="display: flex">
							      <input type="text" name="memberId" id="signUpId" class="chk" placeholder="아이디를 입력하세요." value="">
							      <a id="btnid" style="width: 80px;" class='btn-fill-s'>중복확인</a><br>
							    </div>  
							      <div id="validplz" class='valid'>아이디를 입력하세요(영문 소문자, 숫자만 입력 가능)</div>
							    </td>
							  </tr>
							  <tr>
							    <th class="tit">이름 *</th>
							    <td>
							      <input type="text" name="memberName" id="signUpName" placeholder="이용자 본인의 이름을 입력하세요." value="">
							      <div class="valid">이름을 입력해 주세요</div>
							    </td>
							  </tr>
							  <tr>
							    <th class="tit">비밀번호 *</th>
							    <td>
							      <input type="password" id="signUpPw" name="pw" placeholder="비밀번호를 입력하세요." value="" >
							     <div class="valid">영문 대/소문자, 숫자를 모두 포함, 8자 이상 20자 미만</div>
							      
							    </td>
							  </tr>
							  <tr>
							      <th class="tit">비밀번호 확인 *</th>
							      	<td>
							        	<input type="password" id="pwCheck" name="pw_ck" class="chk" placeholder="비밀번호를 한 번 더 입력하세요." value="">
							        	<div class="valid">비밀번호를 한 번 더 입력하세요.</div>
							    	</td>
							   </tr> 	
							  <!-- 생년월일 -->
							  <tr>
							    <th class="tit">생년월일</th>
							    <td>
							      <div class="info" id="info__birth">
							        <select class="box" id="birth-year" onchange="combineDate()">
							          <option disabled selected value="birth_year" id="birth-year">출생연도</option>
							        </select>
							        <select class="box" id="birth-month" onchange="combineDate()">
							          <option disabled selected value="birth_month" id="birth-month">월</option>
							        </select>
							        <select class="box" id="birth-day" onchange="combineDate()">
							          <option disabled selected value="birth_day" id="birth-day">일</option>
							        </select>
							        <input type="hidden" name="birthday" id="birthday" value="">
							      </div>
							    </td>
							  </tr>
							  <!-- 성별 체크 -->
							  <tr>
							    <th class="tit">성별</th>
							    <td id="genderForm" style="line-height: 80px;">
							      <label style="margin-right: 15px;">
							      <input type="radio" name="gender" value="M">남</label>
							      <label>
							      <input type="radio" name="gender" value="F" checked>여</label>
							    </td>
							  </tr>
							<!-- 이메일 체크 -->
							  <tr>
							    <th class="tit">이메일 *</th>
							    <td>
							    <div style="display: flex">
							      <input class="box" name="memberemail" id="email-txt" type="text" style="width: 120px; height: 35px;" onchange="combineEmail()"/>
							       <span style="font-weight:bold; font-size:1.2em; margin-left:10px; margin-right:10px; padding-top:8px;">@</span>
							        <input class="box" name="memberdomain" id="domain-txt" type="text" style="width: 120px; height: 35px;" onchange="combineEmail()"/>
							      <select class="box" id="domain-list" name="test"style="width: 120px; height: 35px;" onchange="updateEmailDomain()">
							        <option value="type">직접 입력</option>
							        <option value="naver.com">naver.com</option>
							        <option value="gmail.com">gmail.com</option>
							        <option value="hanmail.net">hanmail.net</option>
							        <option value="nate.com">nate.com</option>
							      </select>
							       <input type="hidden" name="memberEmail" id="memberEmail" value=""/>
							      </div>
							    </td>
							  </tr>
							  <tr>
							    <th class="tit">호스트이신가요?*</th>
							    <td id="genderForm">
							    	<div style="line-height: 80px;">
							      	<input type="radio" name="hostyn" value="n" checked>아니요, 일반이용자입니다.
							     
							      	<input type="radio" name="hostyn" value="y"> 네,숙소 호스트입니다.
							      	</div>
							    </td>
							  </tr>
							</table>
						</div>
					</div>
				<!--사용자 약관-->
				<div class="agree_box signup-agree">
					<ul class="board_fold" id="listFold">
						<li class="agree_all"><label class="check_skin" for="check_all">
						 <input type="checkbox" id="check_all" value="all"> 
							<span>사용자 약관 전체 동의 *</span>
						</label></li>
						<li><label class="check_skin" for="check_service"> <input
								type="checkbox" id="check_service" value="serviceAgree">
								<span>서비스 이용 약관 동의 (필수)</span></label>
							<div class="agree_arrw_down" role="presentation"></div>
							<div class="view" style="display: none;">
								<br> 개인정보 수집 및 이용 동의<br> 1. 수집항목: [필수] 이름, 연락처, 이메일주소,
								인원정보<br> 2. 수집 및 이용목적: 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리
								등 민원 처리, 분쟁조정 해결을 위한 기록보존<br>
							</div></li>
						<li><label class="check_skin" for="check_privacy"> 
						<input type="checkbox" id="check_privacy" value="privacyAgree">
								<span>개인정보처리방침 동의 (필수)</span></label>
							<div class="agree_arrw_down" role="presentation"></div>
							<div class="view" style="display: none;">
								제 1조 (총칙)<br>1. 개인정보란 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명,
								주민등록번호 등의 사항에 의하여 당해 개인을 식별할 수 있는 정보 (당해 정보만으로는 특정 개인을 식별할 수
								없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함합니다.) 를 말합니다.<br>2.
								스테이올래는 귀하의 개인정보 보호를 매우 중요시하며, ‘정보통신망 이용촉진 및 정보보호에 관한 법률’ 상의
								개인정보 보호규정 및 정보통신부가 제정한 ‘개인정보 보호지침’을 준수하고 있습니다.<br>3.
								스테이올래는 개인정보처리방침을 정하고 이를 귀하께서 언제나 쉽게 확인할 수 있게 공개하도록 하고 있습니다.<br>
							</div></li>
						<li><label class="check_skin" for="check_above">
						<input type="checkbox" id="check_above" value="aboveAgree">
						<span>만 14세 이상 확인 (필수)</span></label>
							<div class="agree_arrw_down" role="presentation"></div>
							<div class="view" style="display: none;">
								정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 만 14세 미만 아동의 개인정보 수집 시 법정대리인의 동의를
								받도록 규정하고 있습니다.<br> 만 14세 미만 아동이 법정대리인 동의 없이 회원가입을 할 경우 회원탈퇴
								또는 서비스 이용에 제한이 있을 수 있습니다.
							</div></li>
						<li><label class="check_skin" for="check_lifetime"> 
						<input type="checkbox" id="check_lifetime" value="lifeTimeAgree">
								<span>평생회원제동의 (선택)</span></label>
							<div class="agree_arrw_down" role="presentation"></div>
							<div class="view" style="display: none;">
								평생회원제에 동의할 경우 1년 이상 서비스를 이용하지 않아도<br> 휴면 처리되지 않습니다.
							</div></li>
						<li><label class="check_skin" for="check_marketing">
								<input type="checkbox" id="check_marketing" value="marketingAgree">
								 <span>쿠폰,이벤트 등 혜택 알림 동의 (선택)</span>
						</label>
							<div class="agree_arrw_down" role="presentation"></div>
							<div class="view" style="display: none;">
								스테이올래에서 제공하는 이벤트 및 혜택 등 다양한 정보를 문자메시지, 이메일 등으로 볼 수 있습니다.<br>
								마케팅 정보 수신 및 활용 동의 여부와 관계없이 회원가입 및 서비스를 이용하실 수 있습니다.<br>
							</div></li>
					</ul>
				</div>
				<div class="login_btns">
					<button type="button" class="btn_bk" id="btnSignup" onclick="go_join()">회원가입</button>
				</div>
				<div id='signupMsg'></div>
        <div class="sns_login">
            <div class="tit">SNS 계정으로 로그인하기</div>
            <ul id="snsLogin">
                <li>
                    <a id="naverIdLogin" class="btn_naver" href="#" style="margin: right;">네이버</a>
                </li>
                <li> 
                    <a id="kakaoIdLogin" class="btn_kakao" onclick="kakaoLogin();"
                    href="javascript:void(0)">카카오</a>
                </li>
            </ul>
          </div>
			</div>
		</div>
	</form>
	</div>
	
<script>	
  // '출생 연도' 셀렉트 박스 option 목록 동적 생성
  const birthYearEl = document.querySelector('#birth-year')
	  // option 목록 생성 여부 확인
	  isYearOptionExisted = false;
	  birthYearEl.addEventListener('focus', function () {
	  // year 목록 생성되지 않았을 때 (최초 클릭 시)
	  if(!isYearOptionExisted) {
	      isYearOptionExisted = true
	      for(var i = 1940; i <= 2022; i++) {
	      // option element 생성
	      const YearOption = document.createElement('option')
	      YearOption.setAttribute('value', i)
	      YearOption.innerText = i
	      // birthYearEl의 자식 요소로 추가
	      this.appendChild(YearOption);
	      }
	  }
  });

	// Modify the code for Month dropdown
	  const birthMonthEl = document.querySelector('#birth-month');
	  isMonthOptionExisted = false;
	  birthMonthEl.addEventListener('focus', function () {
	    if (!isMonthOptionExisted) {
	      isMonthOptionExisted = true;
	      for (let i = 1; i <= 12; i++) {
	        const MonthOption = document.createElement('option');
	        const formattedMonth = i.toString().padStart(2, '0'); // Add leading zero
	        MonthOption.setAttribute('value', formattedMonth);
	        MonthOption.innerText = formattedMonth;
	        this.appendChild(MonthOption);
	      }
	    }
	  });

	  // Modify the code for Day dropdown
	  const birthDayEl = document.querySelector('#birth-day');
	  isDayOptionExisted = false;
	  birthDayEl.addEventListener('focus', function () {
	    if (!isDayOptionExisted) {
	      isDayOptionExisted = true;
	      for (let i = 1; i <= 31; i++) {
	        const DayOption = document.createElement('option');
	        const formattedDay = i.toString().padStart(2, '0'); // Add leading zero
	        DayOption.setAttribute('value', formattedDay);
	        DayOption.innerText = formattedDay;
	        this.appendChild(DayOption);
	      }
	    }
	  });

     // 이메일 도메인 입력 처리 
    function updateEmailDomain() {
        var domainList = document.getElementById("domain-list");
        var selectedDomain = domainList.value;
        var domainTxt = document.getElementById("domain-txt");
        var emailTxt = document.getElementById("email-txt");
        var memberEmail = document.getElementById("memberEmail");

        if (selectedDomain === "type") {
            domainTxt.value = "";
            domainTxt.removeAttribute("disabled");
            memberEmail.value= emailTxt.value + "@"+ domainTxt
            
        } else {
            domainTxt.value = selectedDomain;
            domainTxt.setAttribute("disabled", "disabled");
            memberEmail.value= emailTxt.value + "@"+ selectedDomain
        }

    }
     // 약관 세부 내용 펼침 
     // 페이지의 모든 구성 요소가 로드된 후에 JavaScript 코드 실행 
    document.addEventListener("DOMContentLoaded", function() {
        const foldButtons = document.querySelectorAll(".agree_arrw_down");

        foldButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                const view = this.nextElementSibling;
                view.style.display = (view.style.display === 'none') ? 'block' : 'none';
            });
        });
    });
	// 네이버 로그인
    var naverLogin = new naver.LoginWithNaverId(
            {
                clientId: "oBTXRKlWIJxCsXbBSgGL",
                  // 본인의 Client ID로 수정, 띄어쓰기는 사용하지 마세요.
                callbackUrl: "http://localhost:8080/naverAction",
                  // 본인의 callBack url로 수정하세요.
                isPopup: false,
                loginButton: {color: "green", type: 1, height: 40}
                  // 네이버 로그인버튼 디자인 설정. 한번 바꿔보세요:D
            }
        );
    naverLogin.init();
    
    // 카카오 로그인
    function kakaoLogin() {
		$.ajax({
			url: '/login/kakaoActionUrl',
			type: 'get',
			async: false,
			dataType: 'text',
			success: function (res) {
				console.log(res);
				location.href = res;
			}
		});
	}


        
</script>
</body>
<jsp:include page="../common/footer.jsp" />
</html>