<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>qaList</title>
    <link rel="stylesheet" href="./css/admin.css">

    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
    <title>부트스트랩 테이블</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>


<body>

<!-- 헤더-->
<%@ include file="../../common/header.jsp" %>

<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
            title="googletagmanager-iframe" style="display:none;visibility:hidden"></iframe></noscript>
    <div id="fb-root" class=" fb_reset">
        <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
        <div style="position: absolute; top: -10000px; width: 0px; height: 0px;">
            <div></div>
        </div>
    </div>
   
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
                        <!-- =================================== host  =================================== -->
                        <div class="tit">HOST ${sessionScope.memberId}</div>
                        <div class="my-count" role="link" tabindex="0">HOST GUIDE</div>
                    </div>
                    <div class="newmypage_menu pc_only">
                        <ul>
                           <li class=""><a href="./stayhost">숙소 관리</a></li>
                             <li class=""><a href="./reservation">예약 관리 </a></li>
                             <li class=""><a href="./income">수입 현황</a></li>
                             <li class="active"><a href="./guide">호스트가이드</a></li>
                             <li class=""><a href="./message">메세지</a></li>
                        </ul>
                    </div>
                    <div class="mypage_content">
                        <div class="reserv_wrap mypage-reservation-info">
                            <div class="reserv_box accepted" style="margin-bottom:0px">
                                
                            <!-- ========================= 회원 목록 조회 =================== -->
                            <div class="container">
                            	<h3 class="my_tit pc_only">문의 목록</h3>
                                
                                <table class="table">
                                  <thead>
                                    <tr>
                                      <th style="width:15%">문의 번호</th>
                                      <th style="width:35%">문의 제목</th>
                                      <th style="width:25%; text-align:center">문의 내용</th>
                                      <th style="width:15%">문의 작성일</th>
                                      <th style="width:15%; text-align:center">답변</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                  
                                  <!-- ▶▶▶  forEach ▶▶▶  -->
                                  <c:forEach items="${list}" var="qa" step="1">
                                  <c:if test="${sessionScope.memberId == qa.memberId}">
                                  
                                    <tr style="line-height: 40px">
                                        <td>${qa.queNo }</td>
                                        <td><a href="/member/host/answer?queNo=${qa.queNo }">${qa.title }</a></td>
                                        <td style="text-align:center">${qa.content }</td>
                                        <td>${qa.contentDate }</td>
                                        <td style="font-weight:bold">
	                                        <c:if test="${qa.answerYN eq 'Y'}">
	                                        	답변 완료
	                                        </c:if>
                                        </td>
                                    </tr>
                                    
                                    </c:if>
                                    </c:forEach>
                                    
                                    </tbody>
                                  </table>
                                </div>
                            </div>
                        </div>

                        <!-- =============================== 페이징 ============================================-->
                        <div class="paging"><a href="/" class="prev" title="이전 페이지">이전 페이지</a><a href="/"
                                class="on">1</a><a href="/" class="next" title="다음 페이지">다음 페이지</a></div>
                    </div>
                </div>
            </div>
            
        </div><button class="custom-button-1"></button>
    </div>
    
    <!-- 푸터 -->
	<%@ include file="../../common/footer.jsp" %>
    
</body>

</html>