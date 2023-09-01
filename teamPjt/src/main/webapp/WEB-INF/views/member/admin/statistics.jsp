<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>statistics</title>
    <link rel="stylesheet" href="./css/admin.css">
    
    <!-- 차트 링크 -->
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	  <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
  
</head>

    <body style="">
    
    <!-- 헤더 -->
	<%@ include file="../../common/header.jsp" %>
    
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ" height="0" width="0"
                title="googletagmanager-iframe" style="display:none;visibility:hidden"></iframe></noscript>
        <div id="fb-root" class=" fb_reset">
            <script async="" src="https://connect.facebook.net/en_US/all.js"></script>
            <div style="position: absolute; top: -10000px; width: 0px; height: 0px;"></div>
        </div>
       
        <script src="/static/js/common.js"></script>
        <div id="__next" data-reactroot="">
            <div>
                <div class=""></div>
                <div id="gnbBgColor">
                </div>
                <div id="contents">
                    <div class="container sub_title">
                        <div class="tit">ADMIN</div>
                    </div>
                    <div class="container mypage_wrap">
                        <div class="mypage_myinfo">
                            <!-- =================================== admin  =================================== -->
                            <div class="tit"> 관리자</div>
                            <div class="my-count" role="link" tabindex="0">USER MANAGEMENT</div>
                        </div>
                        <div class="newmypage_menu pc_only">
                            <ul>
                                <li class=""><a href="./stayadmin">숙소 관리</a></li>
                                <li class=""><a href="./useradmin">사용자 관리 </a></li>
                                <li class=""><a href="./hosthelp">호스트 지원</a></li>
                                <li class="active"><a href="./staticPage">통계 및 분석</a></li>
                            </ul>
                        </div>
                        
                        
                        <div class="mypage_content">
                            <div class="reserv_wrap mypage-reservation-info" style="border-bottom: none;">
                                <div class="reserv_box accepted">
                                    <!-- script -->
                                     
										<!-- 차트1 -->
										<h6 style="font-weight:bold; width:100%">연령대별 이용자 현황</h6>
										<div style="margin:0px; margin-right:0px; width : 600px; display:flex">
										    <div style="width: 350px; height: 350px; margin-top : 20px; margine-left:30px">
											<canvas id="myChart"></canvas>
										</div>
										
										<!-- 차트2 -->
										<div style="margin:0px; margin-right:0px; width : 600px; display:flex; margin-left:100px">
											<h6 style="font-weight:bold; width:100%">성비</h6>
										    <div style="width: 350px; height: 350px; margin-top : 20px; margine-left:30px">
											<canvas id="myGender"></canvas>
										</div> 
										
									
									    <script type="text/javascript">
									
									        $(document).ready(function(){
									            getGraph();
									        });
									
									        function getGraph(){
									            let ageList = [];
									            let ageCount = [];
									            
									            
									            $.ajax({
									                url:"/member/admin/statistics",
									                type:"get",
									                data:{ },
									                dataType:"json",
									                success:function(data){
									                    console.log("data : " , data)
									                    for(let i=0; i<data.length; i++){
									                        ageList.push(data[i].age_group);
									                        ageCount.push(data[i].count)
									                    }
									                    console.log("ageList : ", ageList);
									                    console.log("ageCount : " , ageCount);
									                    new Chart(document.getElementById("myChart"),{
									                        type:'doughnut',
									                        data : {
									                            labels: ageList,
									                            datasets : [{
									                                data: ageCount,
									                                label: '연령대별 이용자 현황',
									                                fill: false,
									                                backgroundColor: [
									                                    //색상
									                                    'rgba(255, 99, 132, 0.2)',
									                                    'rgba(75, 192, 192, 0.2)',
									                                    'rgba(255, 159, 64, 0.2)'
									                                ],
									                                borderColor: [
									                                    //경계선 색상
									                                    'rgba(255, 99, 132, 0.2)',
									                                    'rgba(75, 192, 192, 0.2)',
									                                    'rgba(255, 159, 64, 0.2)'
									                                ],
									                                borderWidth: 1 //경계선 굵기
									                            }]
									                        },
									                        options: {
									                        scales: {
									                            yAxes: [
									                                
									                            ]
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
									    
									    <!-- 두번째차트 -->
									   <script type="text/javascript">
									
									        $(document).ready(function(){
									            getGender();
									        });
									
									        function getGender(){
									            let genderList = [];
									            let countList = [];
									            
									            
									            $.ajax({
									                url:"/member/admin/gender",
									                type:"get",
									                data:{ },
									                dataType:"json",
									                success:function(data){
									                    console.log("data : " , data)
									                    for(let i=0; i<data.length; i++){
									                    	genderList.push(data[i].gender_group);
									                    	countList.push(data[i].gender_Count)
									                    }
									                    
									                    console.log("genderList : ", genderList);
									                    console.log("countList : " , countList);
									                    
									                    new Chart(document.getElementById("myGender"),{
									                        type:'doughnut',
									                        data : {
									                            labels: genderList,
									                            datasets : [{
									                                data: countList,
									                                label: '남녀 성비',
									                                fill: false,
									                                backgroundColor: [
									                                    //색상
									                                    'rgba(34, 80, 150, 0.315)',
									                                    'rgba(194, 93, 26, 0.205)'
									                                ],
									                                borderColor: [
									                                    //경계선 색상
									                                    'rgba(34, 80, 150, 0.2)',
									                                    'rgba(194, 93, 26, 0.2)'
									                                ],
									                                borderWidth: 1 //경계선 굵기
									                            }]
									                        },
									                        options: {
									                        scales: {
									                            yAxes: [
									                                
									                            ]
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
                
            </div><button class="custom-button-1"></button>
        </div>
        
        <!-- 푸터 -->
		<%@ include file="../../common/footer.jsp" %>
		
    </body>
</html>