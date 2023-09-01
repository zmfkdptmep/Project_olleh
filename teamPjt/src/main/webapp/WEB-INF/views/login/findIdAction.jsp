<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>        
<jsp:include page="../common/header.jsp" />
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>                                                                                                                    
var path = "${pageContext.request.contextPath }";                                                                           
                                                                                            
$(document).ready(function() {                                                                                            
                                                                                            
});                                                                                                                       
                                                                                    
</script>       	
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<div id="contents">
	<div class="container sub_title">
		<div class="tit" style="font-weight:bold;">FIND ID</div>
		<div class="txt" style="font-weight:bold;">아이디 찾기</div>
	</div>
	<div class="container" style="line-height: 30px;">
		<div class="login_wrap">
			<div class="w3-content w3-container w3-margin-top">
				<div class="w3-container w3-card-4">
					<div class="w3-center w3-large w3-margin-top">
					<div>
						<div class="text-center">            <br>                                                     
					        <h1 class="h4 text-gray-900 mb-2">CHECK YOUR ID</h1><br><br><br>                    
					        <c:choose>                                                                          
					            <c:when test="${empty memberId}">                                                 
					                <p class="mb-4">조회결과가 없습니다.</p>                                        
					            </c:when>                                                                         
					            <c:otherwise>                                                                     
					                <p class="mb-4" style="font-size: 20px"> ${memberId}</p>                                              
					            </c:otherwise>                                                                    
					        </c:choose>                                                                         
					    </div>    
					</div>
						<p class="w3-center findidBtn" style="display: flex; align-items: center; justify-content:center; margin:5em;" >
						<a href="/login/login">
						<button type="button" id="loginbtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
								style="width: 250px; height: 40px; border: 1px solid #ebebeb; background-color: black; color: white; border-radius:20px; margin-right:15px;">LOGIN
						</button></a>
						
						<a href="/login/findPw">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" 
								style="width: 250px; height: 40px; border: 1px solid #ebebeb; background-color: #fff; border-radius:20px; margin: right;">FIND PASSWORD
						</button></a>
						</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
<jsp:include page="../common/footer.jsp" />
</html>