<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <footer id="footer">
        <div class="container_wide">
            <div class="footer_cont">
                <div class="logo"><img src="/resources/images/stayNameImg/stay2_footer.PNG" alt="STAYFOLIO"></div>
                <div class="menu-cs">
                    <ul class="menu">
                        <li><a target="_self" rel="noreferrer" href="#none">ABOUT</a></li>
                        <li><a target="_self" rel="noreferrer" href="#none">4 POINT APPROACH</a></li>
                        <li><a target="_self" rel="noreferrer"
                                href="#none">NEWSLETTER</a></li>
                        <li><a target="_self" rel="noreferrer" href="#none">CAREERS</a></li>
                    </ul>
                    <div class="cs">
                        <div style="display:flex;align-items:center;margin-top:18px">
                            <div class="cs-tit">고객센터</div>
                            <div class="cs-time" style="margin:0px 0px 0px 4px">(10:00 ~ 18:00)</div>
                        </div>
                        <div class="cs-btns" style="margin-top:26px"><button type="button" class="gry">1:1
                                문의</button><button type="button" class="wh"><a rel="noreferrer">입점
                                    문의</a></button><button type="button" class="wh"><a rel="noreferrer">컨설팅
                                    문의</a></button></div>
                        <div class="cs-btns" style="margin-top:7px"><button type="button" class="wh"><a target="_blank"
                                    rel="noopener noreferrer">마케팅 제휴</a></button><button type="button" class="wh"><a
                                    rel="noreferrer">B2B 구매</a></button></div>
                        <div class="cs-temp" style="margin-top:13px"><a
                                href="#none"
                                target="_self" rel="noreferrer">이용약관</a><a
                                href="#none"
                                target="_self" rel="noreferrer" class="bold">개인정보 처리방침</a></div>
                    </div>
                </div>
                <ul class="sns">
                    <li><a href="https://www.facebook.com" target="_blank" rel="noreferrer"
                            class="facebook">facebook</a></li>
                    <li><a href="https://www.instagram.com" target="_blank" rel="noreferrer"
                            class="instagram">instagram</a></li>
                    <li><a href="https://blog.naver.com" target="_blank" rel="noreferrer"
                            class="naver">naver</a></li>
                    <li><a href="https://www.youtube.com" target="_blank"
                            rel="noreferrer" class="youtube">youtube</a></li>
                </ul>
                <div class="copyright">Copyright©STAYOLLAE</div>
            </div>
            <div class="footer_address"><span class="info" style="word-break:keep-all">상호명 (주) 스테이올래<!-- --> |<!-- -->
                    <!-- --> <!-- -->대표자 올래갈래<!-- --> | <!-- -->주소 서울특별시 중앙정보처리학원<!-- --> | <!-- -->전화
                    1234-5678<!-- --> |<!-- --> <!-- -->go@naver.com<br>사업자등록번호 123-45-6789<!-- --> |<!-- -->
                    <!-- -->통신판매업신고 제2023-서울종로-0499호<a class="info"
                        href="http://www.ftc.go.kr/bizCommPop.do?wrkr_no=6768700055" target="_blank"
                        rel="noreferrer">[사업자정보확인]</a> <!-- -->| <!-- -->관광사업자등록 일반여행업 2023-000049호(종로구청)<!-- -->
                    <div class="info">(주)스테이올래는 통신판매 중개자로서 통신판매의 당사자가 아니며 상품의 예약, 이용 및 환불 등과 관련한 의무와 책임은 각 판매자에게 있습니다.
                    </div>
                </span></div>
        </div>
    </footer>
	<nav id="moMenu" class="mo-samll-only">
		<ul>
			<li><a class="" href="/stay/list"><span>FIND STAY</span></a></li>
	<!-- 		<li><a class="" href="/promotions"><span>PROMOTION</span></a></li>
			<li><a class="" href="/journal"><span>JOURNAL</span></a></li>
			<li><a class="" href="/preorder"><span>PRE-ORDER</span></a></li> -->
			<c:if test="${ sessionScope.role_id eq '[admin]' }" var="res">
				<li><a class=" false" href="/member/admin/hosthelp"><span>MESSAGE</span></a></li>
			</c:if>
			<c:if test="${ sessionScope.role_id eq '[user]' }">
				<li><a class=" false" href="/member/mypage/message"><span>MESSAGE</span></a></li>
			</c:if>
			<c:if test="${ sessionScope.role_id eq '[host]' }">
				<li><a class=" false" href="/member/host/message"><span>MESSAGE</span></a></li>
			</c:if>
		</ul>
	</nav>
<!-- bootstrap script -->

<button id="msgBtn" class="custom-button-1"></button>
<script>
	
	$(function(){
		
		$("#msgBtn").click(function(){
			
			
			if('${sessionScope.memberId}'== null 
					|| '${sessionScope.memberId}' == ''){
				
				alertPopOn('로그인이 필요한 서비스입니다');
				return false;
			} else {
				
				location.href='/chat/chat';
				
			}
			
		});
		
		
	});
	
	
</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</body>
</html>