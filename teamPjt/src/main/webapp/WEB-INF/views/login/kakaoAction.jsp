<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h5>카카오 로그인</h5>
<script type="text/javascript">
    // 카카오 최초 로그인시 DB에 정보넣기
    $(document).ready(function() {
        // 인가코드 가져오기
        let codeURL = new URL(window.location.href);
        let code= codeURL.searchParams.get('code');
console.log(code);
        // 인가코드 유무 확인
        if(code != null){
            console.log("codeURL: " + codeURL);
            console.log("code: " + code);

            /* 토큰 가져오기 */
            function selectMyAccessTocken() {
                let param = {"code" : code}

                $.ajax({
                    url  : '/selectMyAccessTocken',
                    type : 'get',
                    data : param,    // 인가코드 보내기
                    contentType: "application/json; charset=UTF-8",
                    success : function(res){
                        location.href="/main"    // 연동 성공 시 메인페이지로 이동
                    },
                    error: function(xhr, type){
                        console.log(xhr);
                        console.log(type);
                    }
                });
            }
            selectMyAccessTocken();
        }else {
            console.log("코드 존재하지 않음")
        }

    })
</script>
</body>
</html>