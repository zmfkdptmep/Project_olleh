<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>useradmin</title>
<link rel="stylesheet" href="./css/admin.css">


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>부트스트랩 테이블</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	
<style type="text/css">
	.btn-outline-secondary:hover {
    background-color: black; 
    color: white; 
}
</style>

<script type="text/javascript">
	window.addEventListener('DOMContentLoaded', function(){
		const searchBtn = document.querySelector('.col-auto .btn-outline-dark');
		
		searchBtn.addEventListener('click', () => {
			event.preventDefault();
			
			let searchField = document.getElementsByName("searchField")[0].value;
			let searchWord = document.getElementsByName("searchWord")[0].value;
			
			console.log("searchField : ", searchField);
			console.log("searchWord : ", searchWord);
			let data = {
					searchField: searchField,
					searchWord: searchWord
			      };
        	
        	fetch("/adminRest/search", {
		        method : 'post', 
		        headers : {
		          'Content-Type': 'application/json'
		        },
		        body : JSON.stringify(data)
		      })
		      .then(response => response.json())
		      .then(map => keywordList(map));
		      //.then(map => {console.log(map);});
			
		}); 
		
		
		function keywordList(map){
			const keyList = map.list;
			console.log("keyList : " , keyList);
			//console.log("[0] : "keyList[0].memberName);
			
			let pageBlock = '';
			memberList.innerHTML = '';
			
			
			if(keyList != 0){
				keyList.forEach((list, index)=>{         
					pageBlock
					+= '<tr style="line-height:50px;">                                             '
					+ '	<td>                                                                   '
					+ '		<label class="check_skin">                                         '
					+ '		<input type="checkbox"name="memberId" value="'+list.memberId+'"> '
					+ '		<span style="font-size: 12px"></span>                              '
					+ '		</label>                                                           '
					+ '	</td>                                                                  '
					+ '	<td>'+list.memberId+'</td>                                           '
					+ '	<td>'+list.memberName+'</td>                                         '
					+ '	<td>'+list.memberEmail +'</td>                                        '
					+ '	<td>'+list.registraionDate+'</td>                                    '
					+ '</tr>                                                                      ';
				});   
				
			} // if
				memberList.innerHTML += pageBlock;
		} // function
		
	});  // window
	
		function deleteMember(){
		 	delNoList = document.querySelectorAll("[type=checkbox]:checked");
		 	
		 	let memberId = "";
		 	
		 	delNoList.forEach((checkbox) =>{
		 		memberId += checkbox.value + ',';
		 	});
		 	
		 	memberId = memberId.substr(0, memberId.length-1);
		 	console.log(memberId);
		 	
		 	memberFrm.action = "/member/admin/delete";
		 	memberFrm.submit();  
	 }
</script>
</head>


<body>

	<!-- 헤더-->
	<%@ include file="../../common/header.jsp"%>

	<noscript>
		<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M24ZFBJ"
			height="0" width="0" title="googletagmanager-iframe"
			style="display: none; visibility: hidden"></iframe>
	</noscript>
	<div id="fb-root" class=" fb_reset">
		<script async="" src="https://connect.facebook.net/en_US/all.js"></script>
		<div
			style="position: absolute; top: -10000px; width: 0px; height: 0px;">
			<div></div>
		</div>
	</div>

	<div id="__next" data-reactroot="">
		<div>
			<div class=""></div>
			<div id="gnbBgColor"></div>
			<div id="contents">
				<div class="container sub_title">
					<div class="tit">ADMIN</div>
				</div>
				<div class="container mypage_wrap">
					<div class="mypage_myinfo">
						<!-- =================================== admin  =================================== -->
						<div class="tit">관리자</div>
						<div class="my-count" role="link" tabindex="0">USER MANAGEMENT</div>
					</div>
					<div class="newmypage_menu pc_only">
						<ul>
							<li class=""><a href="./stayadmin">숙소 관리</a></li>
							<li class="active"><a href="./useradmin">사용자 관리 </a></li>
							<li class=""><a href="./hosthelp">호스트 지원</a></li>
							<li class=""><a href="./staticPage">통계 및 분석</a></li>
						</ul>
					</div>
					<div class="mypage_content">
						<div class="reserv_wrap mypage-reservation-info">
							<div class="reserv_box accepted">

								<!-- ========================= 회원 목록 조회 =================== -->
								
								<div class="container">
								
								<h6 style="line-height: 60px">회원목록</h6>
								
								<form method="post" name="searchForm">
									<!-- 가운데 정렬 -->
										<div class="row g-3 justify-content-center">
										 	 <div class="col-auto" >
												<select name="searchField" class="form-select" aria-label="Default select example">
												  <option value="memberId" >회원 아이디</option>
												  <option value="memberName" >회원명</option>
												</select>
										  </div>
										  <!-- col-sm-5 : 칸 넓게 -->
										  <div class="col-sm-5" style="padding:0px">
											    <label for="searchWord" class="visually-hidden">text</label>
											    <input type="text" class="form-control" id="searchWord" name="searchWord" placeholder="Search Text" >
										  </div>
										  <div class="col-auto">
										  		<button type="button" class="btn btn-outline-dark">Search</button>
										  </div>
									  </div>
								</form>
								
								<div style="height:50px"></div>
								
									<form action="./delete" name="memberFrm" >
										<table class="table">
											<thead>
												<tr>
													<th></th>
													<th>회원 아이디</th>
													<th>회원명</th>
													<th>이메일</th>
													<th>회원가입일</th>
												</tr>
											</thead>
											<tbody id="memberList">
												<!-- ▶▶▶  forEach ▶▶▶  -->
												<c:forEach items="${member}" var="member" step="1">
													<tr style="line-height:50px;">
														<td>
															<label class="check_skin">
															<input type="checkbox"name="memberId" value="${member.memberId }">
															<span style="font-size: 12px"></span>
															</label>
														</td>
														<td style="overflow:hidden">${member.memberId }</td>
														<td>${member.memberName }</td>
														<td>${member.memberEmail }</td>
														<td>${member.registraionDate }</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</form>
								</div>
								
								<!-- 삭제 버튼 -->
								<button type="checkbox" id="deleteBtn" class="btn btn-outline-dark btn-sm"
									 onclick="deleteMember()" style="float: right;">회원 삭제</button>
							</div>
						</div>

						<!-- =============================== 페이징 ============================================-->
						<div class="paging">
							<a href="/" class="prev" title="이전 페이지">이전 페이지</a><a href="/"
								class="on">1</a><a href="/" class="next" title="다음 페이지">다음
								페이지</a>
						</div>
					</div>
				</div>
			</div>

		</div>
		<button class="custom-button-1"></button>
	</div>

	<!-- 푸터 -->
	<%@ include file="../../common/footer.jsp"%>

</body>

</html>