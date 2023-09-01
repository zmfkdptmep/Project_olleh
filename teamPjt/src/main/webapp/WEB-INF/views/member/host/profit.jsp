<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>profit</title>
    <link rel="stylesheet" href="./css/host/host.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
</head>


<body style="">

<!-- 헤더 -->
<%@ include file="../../common/header.jsp" %><noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
            title="googletagmanager-iframe" style="display:none;visibility:hidden"></iframe></noscript>
    <div id="fb-root" class=" fb_reset">
       
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
                        <div class="my-count" role="link" tabindex="0">IMPORTS</div>
                    </div>
                    <div class="newmypage_menu pc_only">
                        <ul>
                            <li class=""><a href="./stayhost">숙소 관리</a></li>
                            <li class=""><a href="./reservation">예약 관리 </a></li>
                            <li class="active"><a href="./income">수입 현황</a></li>
                            <li class=""><a href="./guide">호스트가이드</a></li>
                            <li class=""><a href="./infoHost">회원 정보 수정</a></li>
                            <li class=""><a href="./message">메시지</a></li>
                        </ul>
                    </div>
                    
                          <div class="mypage_content">
                          <div class="reserv_wrap mypage-reservation-info">
                              <div class="reserv_box accepted">
                                   
								<!--차트-->
								<div style="margin-left: 5%;">
									<h6 style="font-weight:bold; ">월별 수익 현황</h6>
								    <div style="width: 850px; height: 600px; margin-top : 20px;">
									<canvas id="myChart"></canvas>
								</div>
							
							    <script type="text/javascript">
							
							        $(document).ready(function(){
							            getGraph();
							        });
							
							        function getGraph(){
							            let monthList = [];
							            let priceList = [];
							            
							            
							            $.ajax({
							                url:"/member/host/profit",
							                type:"get",
							                data:{ },
							                dataType:"json",
							                success:function(data){
							                    console.log("data : " , data)
							                    for(let i=0; i<data.length; i++){
							                    	monthList.push(data[i].month);
							                    	priceList.push(data[i].total_price)
							                    }
							                    
							                    console.log("monthList : ", monthList);
							                    console.log("priceList : " , priceList);
							                    
							                    new Chart(document.getElementById("myChart"),{
							                        type:'line',
							                        data : {
							                            labels: monthList,
							                            datasets : [{
							                                data: priceList,
							                                label: '월별 수익 현황',
							                                fill: false,
							                                backgroundColor: [
							                                    //색상
							                                    'rgb(95, 91, 91)',
							                                ],
							                                borderColor: [
							                                    //경계선 색상
							                                    'rgb(95, 91, 91)',
							                                ],
							                                borderWidth: 1 //경계선 굵기
							                            }]
							                        },
							                        options: {
							                        scales: {
							                            yAxes: [
							                                {
							                                    ticks: {
							                                        beginAtZero: true
							                                    }
							                                }
							                            ]
							                        },
							                        elements: {
							                            line: {
							                                tension: 0 // 곡선 정도를 0으로 설정하여 직선처럼 표현
							                            }
							                        }
							                    }
							        
							                    }); // 그래프
							                },
							                error:function(){
							                    alert("실패")
							                }
							            })
							        }
							    </script>
                              </div>
                          </div>

                      </div>
                  </div>
              </div>
            
        </div><button class="custom-button-1"></button>
    </div>
  
   <!-- 푸터 -->
<%@ include file="../../common/footer.jsp" %>
</body>

</html>