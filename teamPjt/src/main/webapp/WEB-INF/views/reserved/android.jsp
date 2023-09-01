<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>hi</h1>

	
	
<script>
		//위치 정보를 얻을 때 호출되는 함수
		function getLocation() {
		    if (navigator.geolocation) { // Geolocation API를 지원하는지 체크
		        navigator.geolocation.getCurrentPosition(showPosition, showError); // 현재 위치 정보 요청
		    } else {
		        alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.");
		    }
		}
		
		// 위치 정보를 성공적으로 얻었을 때 호출되는 함수
		function showPosition(position) {
		    alert("Latitude: " + position.coords.latitude + "\nLongitude: " + position.coords.longitude);
		}
		
		// 위치 정보를 얻는 데 실패했을 때 호출되는 함수
		function showError(error) {
		    switch(error.code) {
		        case error.PERMISSION_DENIED:
		            alert("사용자가 위치 정보 접근을 거부했습니다.");
		            break;
		        case error.POSITION_UNAVAILABLE:
		            alert("위치 정보를 사용할 수 없습니다.");
		            break;
		        case error.TIMEOUT:
		            alert("위치 정보 요청 시간이 초과되었습니다.");
		            break;
		        case error.UNKNOWN_ERROR:
		            alert("알 수 없는 오류가 발생했습니다.");
		            break;
		    }
		}
		
		// 함수 호출
		getLocation();

</script>
</body>
</html>