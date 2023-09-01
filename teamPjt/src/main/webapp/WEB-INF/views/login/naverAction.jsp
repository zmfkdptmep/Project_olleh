<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
 
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script>
    var naverLogin = new naver.LoginWithNaverId({
        clientId: "oBTXRKlWIJxCsXbBSgGL", // 본인걸로 수정, 띄어쓰기 금지.
        callbackUrl: "http://localhost:8080/naverSave", // 아무거나 설정
        isPopup: false,
        callbackHandle: true
    });
    naverLogin.init();
 
    window.addEventListener('load', function () {
    naverLogin.getLoginStatus(function (status) {
 
    if (status) {
        /* console.log(naverLogin.user); */
        var age = naverLogin.user.getAge();
        var birthday = naverLogin.user.getBirthday();
        var email = naverLogin.user.getEmail();
        var gender = naverLogin.user.getGender();
        var id = naverLogin.user.getId();
        var name = naverLogin.user.getName();
        var nickName = naverLogin.user.getNickName();
 		var photo = naverLogin.user.getProfileImage();
        
        $.ajax({
            type: 'post',
            url: '/naverSave',
            data: {'memberId':id, 'memberName':nickName, 'birthday':birthday ,'profile':photo, 'gender':gender, 'memberEmail':email, 'snsCk':'Y'},
            dataType: 'text',
            success: function(res) {
            	console.log(res);
                if(res == '{"result":"ok"}') {
                	console.log(res);
                    console.log('네이버 로그인 성공');
                    alert('네이버 로그인 성공');
                    location.href='/main';
                } else if(res =='{"result":"no"}') {
                	console.log(res);
                    console.log('네이버 로그인 실패');
                    alert('네이버 로그인 실패');
                    location.href='/main';
                } else if(res == '{"msg":"네이버 회원가입 성공"}'){
                    
                    alert('네이버 회원가입 성공');
                    location.href='/main';

                } else if(res == '{"msg":"네이버 회원가입 실패"}'){
                	
                    alert('네이버 회원가입 실패');
                    location.href='/main';

                }
            },
            error: function(result) {
                console.log('오류 발생');
                alert('네이버 로그인 중 오류 발생');
                location.href='/main';
            }
        })
 
    } else {
        console.log("callback 처리에 실패하였습니다.");
    }
    });
});
</script>
</body>
</html>