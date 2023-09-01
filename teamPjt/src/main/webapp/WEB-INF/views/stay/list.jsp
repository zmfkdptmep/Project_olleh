<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FIND STAY</title>
<link rel="shortcut icon" type="image⁄x-icon" href="https://www.stayfolio.com/web/images/logo.png">
<link href="../resources/css/list/list.css" rel="stylesheet">
<link href="../resources/css/common/48ab7619b7161b1c.css" rel="stylesheet">
<link href="../resources/css//common/5f0d2e1da89b35fb.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<!-- <script src="/resources/js/list/list.js"></script> -->


<style>
        .open {
            visibility: visible;
            opacity: 1;
            transition: all .2s;
            top: 10px;
        }

        ._selector_selected__ciPbE {
            color: #333;
            font-weight: 600
        }

        ._open_toggle {
            visibility: visible;
            opacity: 1;
            transition: all .2s;
            top: 32px;
        }

        .active {
            color: #fff;
            background: #000;
            border-radius: 100px;
            box-shadow: 6px 7px 15px 0 rgba(0, 0, 0, .3);
        }

        .btn_like_after {
            background-position: 100%;
            opacity: 0;
        }
        .modal_hidden {
            visibility: hidden;
            opacity: 0;
            transition: visibility .3s ease-out, opacity .3s ease-out;
        }
        
    </style>
    <script>
    window.onload = function() {
    	
    		// 체크 인/아웃으로 검색 후 처리
    		
    		var isCheckTime = '${param.reserved_checkIn}';
    		if(isCheckTime!=''){
    			
    			$('.DateInput Input:eq(0)').val('${param.reserved_checkIn}');
    			$('.DateInput Input:eq(1)').val('${param.reserved_checkOut}');
    			
    			
    			searchFrom.submit();
    		}
    		
    	

            // 국내여행 버튼 띄우기
            travelbtn.addEventListener('click', function () {
                document.querySelector("#areaSelect").style.display = 'block';
            })

            // 국내 여행 모달창 클릭
            let searchbtn = document.querySelectorAll('#regionModal li button');
           
            searchbtn.forEach(button => {
                // 버튼이 클릭되면
                button.addEventListener('click', () => {
                    console.log('a');
                    // 클릭된 버튼만 active 클래스 추가, 나머지는 active 클래스 삭제
                    searchbtn.forEach(otherButton => {
                        if (otherButton === button) {
                            otherButton.classList.add('active');
                        } else {
                            otherButton.classList.remove('active');
                        }
                    });
                })
            })
            
            // 뷰 모달창 클릭
            let viewModalBtn = document.querySelectorAll('#viewModal li button');
            viewModalBtn.forEach(button => {
                // 버튼이 클릭되면
                button.addEventListener('click', () => {
                    console.log('a');
                    // 클릭된 버튼만 active 클래스 추가, 나머지는 active 클래스 삭제
                    viewModalBtn.forEach(otherButton => {
                        if (otherButton === button) {
                            otherButton.classList.add('active');
                        } else {
                            otherButton.classList.remove('active');
                        }
                    });
                })
            })

            // x창
            let clsbtn = document.querySelector('#clsbtn');
            clsbtn.addEventListener('click', function () {
            	if(document.querySelector('#viewModal #stayView.active').innerHTML === '전체'){
            		travelbtn.innerHTML = document.querySelector('#regionModal li button.active').value;
            	}else{
	            	travelbtn.innerHTML = document.querySelector('#regionModal li button.active').value + ' / ' + document.querySelector('#viewModal #stayView.active').innerHTML;
            	}
                document.querySelector("#areaSelect").style.display = '';
            })
/* 			let clsbtn2 = document.querySelector('.btn-number-search');
            clsbtn2.addEventListener('click', function () {
                document.querySelector("#areaSelect").style.display = '';
            }) */


            // 인원 버튼
            const btn2 = document.querySelectorAll('.btn_select')[2];
            btn2.addEventListener('click', function () {
                selectNumber.classList.add('open');
            })
            let clsbtn3 = document.querySelectorAll('.btn_close')[3];
            
            clsbtn3.addEventListener('click', function () {
                selectNumber.classList.remove('open');
                peopleNum.innerHTML = '성인 : ' + document.querySelectorAll('.input-num input')[0].value + ' / ' + '아동 : '+ document.querySelectorAll('.input-num input')[1].value;  
            })

            // 가격범위
            const btn3 = document.querySelectorAll('.btn_select')[3];
            btn3.addEventListener('click', function () {
                selectPrice.classList.add('open');
            })
            let clsbtn4 = document.querySelectorAll('.btn_close')[4];
            clsbtn4.addEventListener('click', function () {
                selectPrice.classList.remove('open');
                btn3.innerHTML = document.querySelector('#minPrice').value +'만원 ~ ' + document.querySelector('#maxPrice').value + '만원';
            })

            // 스테이 유형
            /* const btn4 = document.querySelectorAll('.btn_select')[4];
            btn4.addEventListener('click', function () {
                selectType.classList.add('open');
            })
            let clsbtn5 = document.querySelectorAll('.btn_close')[5];
            
            const checkedInputs = document.querySelectorAll('.check_list input:checked');
            const selectedValues = [];
            checkedInputs.forEach(input => {
                selectedValues.push(input.value);
            });
            selectedValues.join(', ');
            
            clsbtn5.addEventListener('click', function () {
                selectType.classList.remove('open');
                // btn4.innerHTML = document.querySelector('.check_list input:checked').value;
                btn4.innerHTML = selectedValues.join(', ');
            }) */
            
            
         	// 스테이 유형
            const btn4 = document.querySelectorAll('.btn_select')[4];
            const clsbtn5 = document.querySelectorAll('.btn_close')[5];

            btn4.addEventListener('click', function () {
                selectType.classList.add('open');
            });

            clsbtn5.addEventListener('click', function () {
                selectType.classList.remove('open');
                
                const checkedInputs = document.querySelectorAll('.check_list input:checked');
                const selectedValues = [];

                checkedInputs.forEach(input => {
                    selectedValues.push(input.value);
                });

                if (selectedValues.length > 0) {
                    if (selectedValues.includes("")) {
                        btn4.innerHTML = '전체';
                    } else if (selectedValues.length === 1) {
                        btn4.innerHTML = selectedValues[0];
                    } else {
                        const firstValue = selectedValues[0];
                        const otherValuesCount = selectedValues.length - 1;
                        btn4.innerHTML = firstValue + '외 ' + otherValuesCount + '건';
                    }
                } else {
                    btn4.innerHTML = '선택된 값 없음';
                }
            });
            
            
            
            
            

            // 편의시설
/*             const btn5 = document.querySelectorAll('.btn_select')[5];
            btn5.addEventListener('click', function () {
                selectTheme.classList.add('open');
            })
            let clsbtn6 = document.querySelectorAll('.btn_close')[6];            
            clsbtn6.addEventListener('click', function () {
                selectTheme.classList.remove('open');
            }) */
			
            
            
            
            
            
         	// 편의시설
            const btn5 = document.querySelectorAll('.btn_select')[5];
            const clsbtn6 = document.querySelectorAll('.btn_close')[6];         
			
            btn5.addEventListener('click', function () {
            	selectTheme.classList.add('open');
            });

            clsbtn6.addEventListener('click', function () {
            	selectTheme.classList.remove('open');
                
            	// checked된 요소 선택
                const checkedInputs = document.querySelectorAll('.findstay_check_list input:checked');
                const selectedValues = [];
	
                // 선택된 요소들 배열에 담아주기
                checkedInputs.forEach(input => {
                	const spanText = input.parentElement.querySelector('.convenient').textContent;
                    selectedValues.push(spanText);
                });
				
                // 배열에 넣고 조건에 맞게 뿌려주기
                if (selectedValues.length > 0) {
			        if (selectedValues.includes("")) {
			            btn5.innerHTML = '전체';
			        } else if (selectedValues.length === 1) {
			            btn5.innerHTML = selectedValues[0];
			        } else {
			            const firstValue = selectedValues[0];
			            const otherValuesCount = selectedValues.length - 1;
			            btn5.innerHTML = firstValue + '외 ' + otherValuesCount + '건';
			        }
			    } else {
			        btn5.innerHTML = '선택된 값 없음';
			    }
            });
            
            
            
            
            
            
            
            
            
            
            
			// 각 적용하기 버튼 모두 닫기
			let btnSearch = document.querySelectorAll('.btn-number-search');
			let searchModal = document.querySelectorAll('.searchModal');
			let DayPicker = document.querySelector('.DayPicker');
            
            btnSearch.forEach((button,index) => {
                button.addEventListener('click', () => {
								console.log('a');
                	btnSearch.forEach((otherbutton,idx) => {
							if(index == idx){
								console.log('a');
								console.log(idx);
								console.log(searchModal[idx]);
								if(idx === 0){
									if(document.querySelector('#viewModal #stayView.active').innerHTML === '전체'){
					            		travelbtn.innerHTML = document.querySelector('#regionModal li button.active').value;
					            	}else{
						            	travelbtn.innerHTML = document.querySelector('#regionModal li button.active').value + ' / ' + document.querySelector('#viewModal #stayView.active').innerHTML;
					            	}
									document.querySelector("#areaSelect").style.display = '';
								}else if(idx === 1){
									// 체크인 값
									let checkIn = document.querySelector('#reserved_checkIn').value;
						            console.log(checkIn);
						            // 체크아웃 값
						            let checkOut = document.querySelector('#reserved_checkOut').value;
						            console.log(checkOut);
						            
						            document.querySelectorAll('.DateInput input')[0].value = checkIn;
						            document.querySelectorAll('.DateInput input')[1].value = checkOut;
						            
									DayPicker.style.display = 'none';
								/* }else{
									searchModal[idx-1].classList.remove('open');
								} */
								}else if(idx === 2){
									peopleNum.innerHTML = '성인 : ' + document.querySelectorAll('.input-num input')[0].value + ' / ' + '아동 : '+ document.querySelectorAll('.input-num input')[1].value;
									searchModal[idx-1].classList.remove('open');
								}else if(idx === 3){
									btn3.innerHTML = document.querySelector('#minPrice').value +'만원 ~ ' + document.querySelector('#maxPrice').value + '만원';
									searchModal[idx-1].classList.remove('open');
								}else if(idx === 4){
									const checkedInputs = document.querySelectorAll('.check_list input:checked');
					                const selectedValues = [];

					                checkedInputs.forEach(input => {
					                    selectedValues.push(input.value);
					                });

					                if (selectedValues.length > 0) {
					                    if (selectedValues.includes("")) {
					                        btn4.innerHTML = '전체';
					                    } else if (selectedValues.length === 1) {
					                        btn4.innerHTML = selectedValues[0];
					                    } else {
					                        const firstValue = selectedValues[0];
					                        const otherValuesCount = selectedValues.length - 1;
					                        btn4.innerHTML = firstValue + '외 ' + otherValuesCount + '건';
					                    }
					                } else {
					                    btn4.innerHTML = '선택된 값 없음';
					                }
									searchModal[idx-1].classList.remove('open');
								}else if(idx === 5){
									// checked된 요소 선택
					                const checkedInputs = document.querySelectorAll('.findstay_check_list input:checked');
					                const selectedValues = [];
						
					                // 선택된 요소들 배열에 담아주기
					                checkedInputs.forEach(input => {
					                	const spanText = input.parentElement.querySelector('.convenient').textContent;
					                    selectedValues.push(spanText);
					                });
									
					                // 배열에 넣고 조건에 맞게 뿌려주기
					                if (selectedValues.length > 0) {
								        if (selectedValues.includes("")) {
								            btn5.innerHTML = '전체';
								        } else if (selectedValues.length === 1) {
								            btn5.innerHTML = selectedValues[0];
								        } else {
								            const firstValue = selectedValues[0];
								            const otherValuesCount = selectedValues.length - 1;
								            btn5.innerHTML = firstValue + '외 ' + otherValuesCount + '건';
								        }
								    } else {
								        btn5.innerHTML = '선택된 값 없음';
								    }
									searchModal[idx-1].classList.remove('open');
								}
							}
                    }) 
                })
            }) 
            
            
            
            
            
            
            
            
            
            // 인기순, 최신순, ..
           /*  const rightCategory = document.querySelectorAll('#listpick li');
            rightCategory.forEach(button => {
                button.addEventListener('click', () => {
                	rightCategory.forEach(otherButton => {
                        if (otherButton === button) {
                            otherButton.classList.add('oepn');
                        } else {
                            otherButton.classList.remove('oepn');
                        }
                    });
                })
            })
 */


            

            // 추천순, 인기순, ...
            const buttons = document.querySelectorAll('#listpick li');
            buttons.forEach(button => {
                button.addEventListener('click', () => {
                    buttons.forEach(otherButton => {
                        if (otherButton === button) {
                            otherButton.classList.add('_selector_selected__ciPbE');
                            otherButton.classList.add('oepn');
                        } else {
                            otherButton.classList.remove('_selector_selected__ciPbE');
                            otherButton.classList.remove('oepn');
                        }
                    });
                })
            })


			
            // 모든 스테이 버튼
            const allstaybtn = document.querySelector('._findstay_sort_selb__JhhC5 li button');
            let allstaylist = document.querySelector('._selector_layer_toggle__U_ckA');
            allstaybtn.addEventListener('click', () => {
            	if (allstaylist.classList.contains('_open_toggle')) {
                    allstaylist.classList.remove('_open_toggle');
                } 
            	else {
                    allstaylist.classList.add('_open_toggle');
                }
            })
            
            let dd = document.querySelectorAll('#motionList li');
            dd.forEach((button,idx)=>{
           		button.addEventListener('click', () => {
           			dd.forEach(otherButton => {
                        if (otherButton === button) {
                            otherButton.classList.add('_selector_selected__ciPbE');
                            otherButton.classList.add('oepn');
                            allstaylist.classList.remove('_open_toggle');
                        } else {
                            otherButton.classList.remove('_selector_selected__ciPbE');
                            otherButton.classList.remove('oepn');
                            allstaylist.classList.remove('_open_toggle');
                        }
                    });
           		})
           	})


            /* -------------------------------------------------------------- */
            let member = document.getElementById('memberId').value;
            console.log(member);

            //좋아요
            let likeBtn = document.querySelectorAll('.flist_box .btn_like');
            likeBtn.forEach((button,index) => {
                button.addEventListener('click', () => {
                	if(member === null || member === ""){
                		alertPopOn("로그인 후 이용하세요");
                    }else{
	                    likeBtn.forEach(otherButton => {
		                    //누른 버튼의 index 번호가 같고
		                    if(otherButton === button){
		                    	//클래스가 포함되어 있으면
		                        if(!button.classList.contains('on')){
		                        	button.classList.add('on');
		                        	
		                        	let data = {
		    	        					stayNo : document.querySelectorAll('.btn_like')[index].value,
		    	        					memberId: member
		    	        			      };
		                        	
		                        	fetch("/stst/insertLike", {
			        			        method : 'post', 
			        			        headers : {
			        			          'Content-Type': 'application/json'
			        			        },
			        			        body : JSON.stringify(data)
			        			      })
			        			      .then(response => response.json())
			        			      .then(map => {console.log(map);});
		                        }else{
		                            button.classList.remove('on');
		                            
		                            let data = {
		    	        					stayNo : document.querySelectorAll('.btn_like')[index].value,
		    	        					memberId: member
		    	        			      };
		                        	
		                        	fetch("/stst/deleteLike", {
			        			        method : 'post', 
			        			        headers : {
			        			          'Content-Type': 'application/json'
			        			        },
			        			        body : JSON.stringify(data)
			        			      })
			        			      .then(response => response.json())
			        			      //.then(map => keywordList(map));
			        			      .then(map => {console.log(map);});
		                    	}
	                    	}
	                    })
                    }
                })
            })
            
            
            // 모달창 띄우기
        	function alertPopOn(msg){
        		if(msg != ''){
        			alertTxt.innerHTML=msg;
        			alertPop.style.display='block';
        		}
        	}
            /* -------------------------------------------------------------- */
            
            
            
            
            
			// 프로모션 보여줬다 사라지기            
            const messageElement = document.getElementById('rightnow');
			function showElement() {
			    messageElement.classList.add('modal_hidden');
			}
			setTimeout(showElement, 3000);            

            
           
			// 날짜 선택 버튼
            let calendarContainer = document.querySelector('#iscalendar');
            let iscalendar = document.querySelectorAll('.DateInput input');
            let closeBtn222 = document.getElementById('closeBtn222');

            function toggleCalendar() {
	            if (calendarContainer.style.display === 'none') {
	                calendarContainer.style.display = '';
	            } else {
	                calendarContainer.style.display = 'none';
	            }
            }

            iscalendar.forEach(input => {
            input.addEventListener('click', toggleCalendar);
            });
            closeBtn222.addEventListener('click', toggleCalendar);
        
		
				
        		//  인원수 조정 버튼
	            let plusBtns = document.querySelectorAll('.btn_plus');
	            let minusBtns = document.querySelectorAll('.number_count .btn_minus');
	            let inputNums = document.querySelectorAll('.input-num input');
				let totalCnt = document.getElementById('stdPerson');
	
	            plusBtns.forEach((plusBtn, index) => {
		              plusBtn.addEventListener('click', () => {
		                let currentValue = parseInt(inputNums[index].value);
		                console.log(inputNums[index].value);
		                inputNums[index].value = currentValue + 1;
		                
		                calculateTotal();
	              	});
	            });
	           
	           
	            
	           minusBtns.forEach((minusBtn, index) => {
	            	minusBtn.addEventListener('click', () => {
		                let currentValue = parseInt(inputNums[index].value);
		                if (currentValue > 0) {
		                  inputNums[index].value = currentValue - 1;
		                  calculateTotal();
		                }
	              	});
	            }); 
	           
	           function calculateTotal() {
	        	   let sum = 0;
	        	   inputNums.forEach((input, index) => {
	        	     sum += parseInt(input.value);
	        	   });
	        	   totalCnt.value = sum;
	        	 }
	           
	           
	           		           	
	           	
        	};
        
        	
        	
        	
        	document.addEventListener('DOMContentLoaded', function() {

	        		// 슬라이드 이미지
		           	let slideBtn = document.querySelectorAll('.swiper-button-next');
					let idx = 0;
					
					slideBtn.forEach((button, index) => {
					    button.addEventListener('click', () => {
					        let slideImgList = document.querySelectorAll('.flist_img')[index]; // 해당 버튼의 이미지가 보이는 칸
					        let slideImgs = slideImgList.querySelectorAll('.swiper-wrapper li'); // 해당 칸의 이미지들
					        
					        if (idx < slideImgs.length-1) {
					            idx++;
					        } else {
					            idx = 1; // 인덱스가 이미지 개수를 넘어가면 초기화
					        }
					            // 현재 인덱스의 이미지 스타일을 가져옴
					            let slideImgStyle = slideImgs[idx].getAttribute('style');
					            
					            // 첫 번째 li 요소의 스타일을 변경하여 이미지를 바꿈
					            let img = document.querySelectorAll('.swiper-wrapper')[index];
					            let tmp = img.querySelectorAll('li')[0].getAttribute('style');
					            img.querySelectorAll('li')[0].setAttribute('style', slideImgStyle);
					            slideImgs[idx].setAttribute('style', tmp);
					            console.log(idx);
					    });
					});
					
 					let prev = document.querySelectorAll('.swiper-button-prev');
					
					prev.forEach((button, index) => {
					    button.addEventListener('click', () => {
					        let slideImgList = document.querySelectorAll('.flist_img')[index]; // 해당 버튼의 이미지가 보이는 칸
					        let slideImgs = slideImgList.querySelectorAll('.swiper-wrapper li'); // 해당 칸의 이미지들
					        
					        //idx = slideImgs.length-1;
					        
					        if (idx == 0) {
					        	idx = slideImgs.length-1; // 인덱스가 이미지 개수를 넘어가면 초기화
					        }
					            // 현재 인덱스의 이미지 스타일을 가져옴
					            let slideImgStyle = slideImgs[idx].getAttribute('style');
				
					            // 첫 번째 li 요소의 스타일을 변경하여 이미지를 바꿈
					            let img = document.querySelectorAll('.swiper-wrapper')[index];
					            let tmp = img.querySelectorAll('li')[0].getAttribute('style');
					            img.querySelectorAll('li')[0].setAttribute('style', slideImgStyle);
					            slideImgs[idx].setAttribute('style', tmp);
					            
					            idx--;
					       
					    });
					}); 
        		

        		
        	  		// 오른쪽 카테고리(인기순, 최신순, ...)
        			let listCategory = document.querySelectorAll('#listpick li');
        			listCategory.forEach(button => {
                        button.addEventListener('click', () => {
							let category = button.innerHTML;
							let categoryName = category.replace('•', '').trim();
							console.log(categoryName);
							let encodedCategoryName = encodeURIComponent(categoryName);
							
		        			fetch('/stst/category/'+ categoryName)
							.then(response => response.json())
							.then(map => {keywordList(map);
											likeBtnActive(); slideBtnActive();});
        				})
        			})
        			
     
        	  		// 왼쪽 카테고리
        			let promotionList = document.querySelectorAll('#motionList li');
        			promotionList.forEach(button => {
                        button.addEventListener('click', () => {
							let promotion = button.innerHTML;
							console.log(promotion);
							let encodedPromotion = encodeURIComponent(promotion);
							
		        			fetch('/stst/category/'+ encodedPromotion)
							.then(response => response.json())
							.then(map => {keywordList(map); likeBtnActive(); slideBtnActive();});
        				})
        			})
        			
	        	  // 검색폼	
	        	  let searchBtn = document.querySelector('.btn_search');
	        	  let insertList = document.querySelector('.flist_wrap');
	        	  let searchFrom = document.getElementById('searchFrom');
	
	        			
	        			
	        	  searchBtn.addEventListener('click', function() {
	        			event.preventDefault(); 
	        			console.log('a');
	        			
	        			
	        			// 숙소 이름
	        			let stayName = document.getElementById('stayName').value;
	        			if(stayName === null){
	        				stayView == "";
	        			}
	        			console.log(stayName);
	        			
						// 지역	        			
	        			let stayAdress = document.querySelector('#regionModal li button.active').value;
	        			if(stayAdress === null){
	        				stayAdress == "";
	        			}
	        			console.log(stayAdress);
	        			
	        			// 주변 뷰
	        			let stayView = document.querySelector('#viewModal li button.active').value;
	        			if(stayView === null){
	        				stayView == "";
	        			}
	        			console.log(stayView);
	        			
	        			// 기준 인원
	        			let stdPerson = document.getElementById('stdPerson').value;
	        			if(stdPerson === null){
	        				stdPerson == "";
	        			}
	        			console.log(stdPerson);
	        			
	        			// 최대값
	        			let maxPrice = document.getElementById('maxPrice').value * 10000;
	        			if(maxPrice === null){
	        				maxPrice == "";
	        			}
	        			console.log(maxPrice);
	        			
	        			// 숙소 유형
 	        			/* let stayType = document.querySelectorAll('#stayTypeList li label input');
	        			stayType.forEach((button) => {
							if(!button.checked){
								stayType == "";
							}else{
								stayType = button.value;
							}        				
	        			})
	        			console.log(stayType); */
	        			
	        			// 숙소 유형	
	        			let stayTypes = [];
	        			let stayTypeInputs = document.querySelectorAll('#stayTypeList li label input:checked');
						
	        			/* if(document.querySelectorAll('#stayTypeList li label input:checked')[0].value == ""){
	        				stayTypes = ['펜션', '한옥', '렌탈하우스', '민박', '호텔'];
	        			}else{ */
		        			stayTypeInputs.forEach(input => {
		        				stayTypes.push(input.value);
		        			});
	        			//}
	        			console.log(stayTypes);
	        			
	        			
	        			
	        			
	        			// 숙소 옵션
/* 	        			let roomOption = document.querySelectorAll('#roomOptionList li label input');
	        			roomOption.forEach((button) => {
							if(button.checked){
								roomOption = button.value;
							}else{
								roomOption == "";
							}        				
	        			})
	        			console.log(roomOption); */
	        			
	        			// 숙소 옵션
	        			let roomOptions = [];
	        			let roomOptionInputs = document.querySelectorAll('#roomOptionList li label input:checked');
							
	        			/* if(document.querySelectorAll('#roomOptionList li label input:checked')[0].value == ""){
	        				roomOptions = ['babiqu', 'pet', 'beamprojector', 'pool', 'terrace'];
	        			}else{ */
	        				roomOptionInputs.forEach(input => {
	        					roomOptions.push(input.value);
		        			});
	        			//}
	        			console.log(roomOptions);
	        			
	        			
	        			// 체크인
	        			//let findStartDate = document.querySelector('#reserved_checkIn').value.replaceAll('-','/');
	        			let findStartDate = document.querySelector('#reserved_checkIn').value;
	        			if(findStartDate === null){
	        				findStartDate == "";
	        			}
	        			console.log(findStartDate);
	        			
	        			// 체크아웃
	        			//let findEndDate = document.querySelector('#reserved_checkOut').value.replaceAll('-','/');
	        			let findEndDate = document.querySelector('#reserved_checkOut').value;
	        			if(findEndDate === ""){
	        				findEndDate == null;
	        			}
	        			console.log(findEndDate);
	        			
	        			
	        			let data = {
	        					stayName : stayName,
	        					stayAdress: stayAdress,
	        					stayView : stayView,
	        					stdPerson : stdPerson,
	        					maxPrice : maxPrice,
	        					stayTypes : stayTypes,
	        					roomOptions : roomOptions,
	        					findStartDate : findStartDate,
	        					findEndDate : findEndDate
	        			      };
								console.log(data);
	        			      
	        			      fetch("/stst/keyword", {
	        			        method : 'post', 
	        			        headers : {
	        			          'Content-Type': 'application/json'
	        			        },
	        			        body : JSON.stringify(data)
	        			      })
	        			      .then(response => response.json())
	        			      //.then(map => keywordList(map));
	        			      .then(map => {keywordList(map); likeBtnActive(); slideBtnActive();}); 
	        			});

        	 
        	
        	  
        	function keywordList(map){
        		let keyList = map.list;
        		let likeList = map.likeList;
        		let imgList = map.imgList;
        		
        		console.log(map);
        		console.log(likeList);
        		let id = document.querySelector('#memberId').value;
        		console.log(id);
        		
        		let pageBlock = '';
        		stayList.innerHTML = '';
        			if(keyList != 0){
	        			keyList.forEach((list, index)=>{

	        			console.log(list.mainPic1);	
	        				
	        			var mainPic1 = list.mainPic1.replace('\\', '/');	
	        			console.log(mainPic1);
	        			
	        			var savePath= encodeURIComponent(list.mainPic1);
	        			
	        			
	        			pageBlock
		        		+='<div class="flist_box">'
		 				+'	<a href="/stay/room?stayName='+list.stayName+'">'
		 				+'		<div class="info_container_wrapper">'
		 				+'			<div class="name info_container" role="presentation">'+list.stayName+'<span>'+list.stayType+'</span></div>'
		 				+'			<div class="clearfix"></div>'
		 				+'			<div class="flist_info" role="presentation">'
		 				+'				<p class="address info_container" role="presentation"><span>'+list.stayLoc+'</span><br>'
		 				+'					 기준 '+list.stdPerson+'명&nbsp;(최대 '+list.overPerson+'명)<br>₩'+list.minPrice+' ~ ₩'+list.maxPrice+'</p>'
		 				+'				<p class="btn_more " role="presentation" tabindex="-1" style="cursor: pointer;">예약하기</p>'
		 				+'			</div>'
		 				+'		</div>'
		 				+'      </a>'	
		 				+'		<div class="flist_img" role="presentation"style="padding-top: 0px;">'
		 				+'			<ul class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events slider1 flist_slider">'
		 				+'				<div class="swiper-button-prev" onclick="slideBtnActive()"></div>'
		 				+'				<div class="swiper-button-next" onclick="slideBtnActive()"></div>'
		 				+'				<a href="/stay/room?stayName='+list.stayName+'">'
		 				+'				<div class="swiper-wrapper">'
		 				
		 				imgList.forEach((img, index)=>{
			 				if(img.stayNo == list.stayNo){
			 					let file = img.fileName.replaceAll('\\','/');
			 				pageBlock			
							+='						<li class="swiper-slide img swiper-slide-active" style="background: url(/resources/images/'+file+') center center / cover no-repeat; cursor: pointer; width: 410px;">'
							+'						</li>'
			 				}
		 				})	
						
		 				pageBlock
		 				+='				</div>'
		 				+'      		</a>'	
		 				+'				<div class="_badge_badge_wrapper__h9IsV">'
		 				+'					<div class="_badge_exclusive__prNZN">'
		 				+'						<span class="_badge_txt__fonwF">'+list.badge+'</span>'
		 				+'					</div>'
		 				+'				</div>'
		 				+'			</ul>'
		 				+'		</div>';
		 				// 로그인이 안되어 있을 떄
 		 				if(id == null && id == ""){
		 					pageBlock
		 					+='	<button type="button" class="btn_like " value="'+list.stayNo+'" onclick="likeBtnActive()"><span>관심스테이</span></button>';
		 				// 로그인이 되어 있을 떄
		 				}else if(likeList != null && id != null){
		 					pageBlock
		 					+='	<button type="button" class="btn_like" value="'+list.stayNo+'" onclick="likeBtnActive()"><span>관심스테이</span></button>';
		 					likeList.forEach((like,idx)=>{
		 						console.log('like:' + like.stayNo);
			 					// 좋아요 값이 있을때
			 					if(list.stayNo == like.stayNo){
			 						pageBlock
				 					+='	<button type="button" class="btn_like on" value="'+list.stayNo+'" onclick="likeBtnActive()"><span>관심스테이</span></button>';
			 					}
		 					})
		 				}
 		 				pageBlock
 		 				+= '</div>';
 		 				/* pageBlock
 		 				+='	<button type="button" class="btn_like "><span>관심스테이</span></button>'
		 				+'</div>'; */
		       			});
        			}else{
        				pageBlock
	        			+='<div class="mypage_content">'
	        			+'	<div class="reserv_wrap mypage-reservation-info">'
	        			+'		<div style="text-align: center;">'
	        			+'			<img src="https://www.stayfolio.com/web/images/img-booking-waiting.png" class="img-booking-waiting" alt="img-booking-wating"><br>'
	        			+'			<p style="line-height: 1.5;">'
	        			+'				아직 예약 정보가 없습니다.<br class="mo_only"> 새로운 스테이를 찾아 떠나보세요.'
	        			+'			</p>'
	        			+'			<button type="button" class="btn_bk btn_sm findstay_btn" style="margin-top: 20px; margin-bottom: 20px; background-color: white; border:1px solid white; color: black; ">새로운 스테이를 찾아보세요~</button>'
	        			+'		</div>'
	        			+'	</div>'
	        			+'</div>'; 
	        		}
        			stayList.innerHTML += pageBlock;
        		}
        	
            
            
            // 모달창 띄우기
        	function alertPopOn(msg){
        		if(msg != ''){
        			alertTxt.innerHTML=msg;
        			alertPop.style.display='block';
        		}
        	}
        	
	        
            
            
            
            
            
            
     function likeBtnActive(){
         let member = document.getElementById('memberId').value;
         console.log(member);

         //좋아요
         let likeBtn = document.querySelectorAll('.flist_box .btn_like');
         likeBtn.forEach((button,index) => {
             button.addEventListener('click', () => {
             	if(member === null || member === ""){
             		alertPopOn("로그인 후 이용하세요");
                 }else{
	                    likeBtn.forEach(otherButton => {
		                    //누른 버튼의 index 번호가 같고
		                    if(otherButton === button){
		                    	//클래스가 포함되어 있으면
		                        if(!button.classList.contains('on')){
		                        	button.classList.add('on');
		                        	
		                        	let data = {
		    	        					stayNo : document.querySelectorAll('.btn_like')[index].value,
		    	        					memberId: member
		    	        			      };
		                        	
		                        	fetch("/stst/insertLike", {
			        			        method : 'post', 
			        			        headers : {
			        			          'Content-Type': 'application/json'
			        			        },
			        			        body : JSON.stringify(data)
			        			      })
			        			      .then(response => response.json())
			        			      .then(map => {console.log(map);});
		                        }else{
		                            button.classList.remove('on');
		                            
		                            let data = {
		    	        					stayNo : document.querySelectorAll('.btn_like')[index].value,
		    	        					memberId: member
		    	        			      };
		                        	
		                        	fetch("/stst/deleteLike", {
			        			        method : 'post', 
			        			        headers : {
			        			          'Content-Type': 'application/json'
			        			        },
			        			        body : JSON.stringify(data)
			        			      })
			        			      .then(response => response.json())
			        			      //.then(map => keywordList(map));
			        			      .then(map => {console.log(map);});
		                    	}
	                    	}
	                    })
                 }
             })
         })
     }
            
            
            
     function slideBtnActive(){
 		// 슬라이드 이미지
        	let slideBtn = document.querySelectorAll('.swiper-button-next');
			let idx = 0;
			
			slideBtn.forEach((button, index) => {
			    button.addEventListener('click', () => {
			        let slideImgList = document.querySelectorAll('.flist_img')[index]; // 해당 버튼의 이미지가 보이는 칸
			        let slideImgs = slideImgList.querySelectorAll('.swiper-wrapper li'); // 해당 칸의 이미지들
			        
			        if (idx < slideImgs.length-1) {
			            idx++;
			        } else {
			            idx = 1; // 인덱스가 이미지 개수를 넘어가면 초기화
			        }
			            // 현재 인덱스의 이미지 스타일을 가져옴
			            let slideImgStyle = slideImgs[idx].getAttribute('style');
			            
			            // 첫 번째 li 요소의 스타일을 변경하여 이미지를 바꿈
			            let img = document.querySelectorAll('.swiper-wrapper')[index];
			            let tmp = img.querySelectorAll('li')[0].getAttribute('style');
			            img.querySelectorAll('li')[0].setAttribute('style', slideImgStyle);
			            slideImgs[idx].setAttribute('style', tmp);
			            console.log(idx);
			    });
			});
			
			let prev = document.querySelectorAll('.swiper-button-prev');
			
			prev.forEach((button, index) => {
			    button.addEventListener('click', () => {
			        let slideImgList = document.querySelectorAll('.flist_img')[index]; // 해당 버튼의 이미지가 보이는 칸
			        let slideImgs = slideImgList.querySelectorAll('.swiper-wrapper li'); // 해당 칸의 이미지들
			        
			        //idx = slideImgs.length-1;
			        
			        if (idx == 0) {
			        	idx = slideImgs.length-1; // 인덱스가 이미지 개수를 넘어가면 초기화
			        }
			            // 현재 인덱스의 이미지 스타일을 가져옴
			            let slideImgStyle = slideImgs[idx].getAttribute('style');
		
			            // 첫 번째 li 요소의 스타일을 변경하여 이미지를 바꿈
			            let img = document.querySelectorAll('.swiper-wrapper')[index];
			            let tmp = img.querySelectorAll('li')[0].getAttribute('style');
			            img.querySelectorAll('li')[0].setAttribute('style', slideImgStyle);
			            slideImgs[idx].setAttribute('style', tmp);
			            
			            idx--;
			       
			    });
			}); 
			}
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        	});
    </script>
</head>

<body style="">
 	<%@include file="../common/header.jsp" %>
    <div role="presentation">
        <div class="container sub_title">
            <div class="tit">FIND STAY</div>
            <div class="txt">머무는 것 자체로 여행이 되는 공간</div>
            <input type="hidden" value="${sessionScope.memberId}" id="memberId">
        </div>
        <form name="searchFrom" id="searchFrom">
            <div class="container findstay_filter" role="presentation">
                <div class="flist_sorting">
                    <div class="row filter_day">
                        <div class="Keyword"><span class="tit">스테이/지역</span><input type="text" class="inp_keyword" name="stayName" id="stayName"
                                >
                        </div>
                        <div class="filter_area"><button type="button" class="btn_select" id='travelbtn' style='margin-top: 16px;'>국내 전체</button>

                            <button class='a'></button>
                            <div id="areaSelect" class="layer_pop" style="display: '';" id='areaSelect'>
                                <div class="layer_pop_wrap layer_area"><button type="button" class="btn_layer_close"
                                        id='clsbtn'>닫기</button>
                                    <h2 class="layer_title">어디로 떠날까요?</h2>
                                    <div class="area_cont">
                                        <div class="box">
                                            <div class="tit cate_stay" style="text-align: left;">국내</div>
                                            <ul class="clearfix" id="regionModal">
                                                <li><button type="button" class="active" name="stayAdress" id="stayAdress" value=""
                                                        style="cursor: pointer;">국내전체</button></li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="제주">제주</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="서울">서울</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="강원">강원</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="부산">부산</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="경기">경기</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="충청">충청</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="경상">경상</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="전남">전남</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="인천">인천</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="광주">광주</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="대전">대전</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" name="stayAdress" id="stayAdress" value="대구">대구</button>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="box">
                                            <div class="tit cate_stay" style="text-align: left;">주변 경치</div>
                                            <ul class="clearfix" id="viewModal">
                                             	<li><button type="button" class="active" style="cursor: pointer;" id="stayView" name="stayView" value="">전체</button>
                                                </li>
                                             	<li><button type="button" class="" style="cursor: pointer;" id="stayView" name="stayView" value="바다">바다</button>
                                                </li>
                                                <li><button type="button" class="" style="cursor: pointer;" id="stayView" name="stayView" value="산">산</button>
                                                </li>
                                             </ul>
                                        </div>
                                    </div>
									<button style=" border:0px; cursor: pointer; margin-left: 500px;" type="button" onclick="" class="btn-number-search regionBtn" >적용하기</button>
                                </div>
                            </div>
                        </div>
                        <div class="checkinout">
                            <ul class="sel_cld">
                                <li><span class="check_in ko">체크인</span></li>
                                <li><span class="check_out" style="right:162px">체크아웃</span></li>
                            </ul>
                            <div class="DateRangePicker DateRangePicker_1">
                                <div>
                                    <div
                                        class="DateRangePickerInput DateRangePickerInput_1 DateRangePickerInput__withBorder DateRangePickerInput__withBorder_2">
                                        <div class="DateInput DateInput_1"><input type="text"
                                                class="DateInput_input DateInput_input_1 DateInput_input__readOnly DateInput_input__readOnly_2 DateInput_input__focused DateInput_input__focused_3"
                                                aria-label="체크인" id="findStartDate" name="findStartDate"
                                                value="체크인" placeholder="체크인" autocomplete="off" readonly=""
                                                aria-describedby="DateInput__screen-reader-message-findStartDate" id="checkIn">
                                            <p class="DateInput_screenReaderMessage DateInput_screenReaderMessage_1"
                                                id="DateInput__screen-reader-message-findStartDate">Navigate forward to
                                                interact with the calendar and select a date. Press the question mark
                                                key to get the keyboard shortcuts for changing dates.</p>
                                        </div>
                                        <div class="DateRangePicker_picker DateRangePicker_picker_1 DateRangePicker_picker__directionLeft DateRangePicker_picker__directionLeft_2"
                                            style="top: 66px; left: 0px;">
                                            <div class="DayPicker DayPicker_1 DayPicker__horizontal DayPicker__horizontal_2 DayPicker__withBorder DayPicker__withBorder_3"
                                                style="width: 619px; display: none;" id='iscalendar'>
                                                <div>
                                                    <div class="searchModal" style="width: 618px; height: 450px; border: 1px solid #e4e4e4; background: #fff; border-radius: 5px;">

                                                        <div class="calendar-wrap " style="padding-top: 0px ">
                                                            <div class="calendar-middle-wrap" style='height: 400px;'>
                                                              <div class="cal_nav">
                                                                <a href="javascript:;" class="nav-btn go-prev"></a>
                                                                <span class="year-month start-year-month"></span>
                                                                <a href="javascript:;" class="nav-btn go-next"></a>
                                                              </div>
                                                              <div class="cal_wrap">
                                                                <div class="days">
                                                                  <div class="day">일</div>
                                                                  <div class="day">월</div>
                                                                  <div class="day">화</div>
                                                                  <div class="day">수</div>
                                                                  <div class="day">목</div>
                                                                  <div class="day">금</div>
                                                                  <div class="day">토</div>
                                                                </div>
                                                                <div class="dates start-calendar"></div>
                                                              </div>
                                                            </div>
                                                      
                                                            <div class="calendar-middle-wrap" style='height: 400px;'>
                                                              <div class="cal_nav">
                                                                <a href="javascript:;" class="nav-btn go-prev"></a>
                                                                <span class="year-month last-year-month"></span>
                                                                <a href="javascript:;" class="nav-btn go-next"></a>
                                                              </div>
                                                              <div class="cal_wrap">
                                                                <div class="days">
                                                                  <div class="day">일</div>
                                                                  <div class="day">월</div>
                                                                  <div class="day">화</div>
                                                                  <div class="day">수</div>
                                                                  <div class="day">목</div>
                                                                  <div class="day">금</div>
                                                                  <div class="day">토</div>
                                                                </div>
                                                                <div class="dates last-calendar"></div>
                                                              </div>
                                                            </div>
                                                      
                                                            <div class="checkInOutInfo" style="height:400px;">
                                                              <div>
                                                                <p>
                                                                  <span style="padding-bottom:15px">체크인</span>
                                                                  <label id="check_in_day_list" style='font-size: 20px;'></label>
                                                                </p>
                                                                <p class="space" style="color: #212529;font-size:2em;">~</p>
                                                                <p>
                                                                  <span>체크아웃</span>
                                                                  <label id="check_out_day_list" style='font-size: 20px;'></label>
                                                                </p>
                                                                <br><br>
                                                                <p>
                                                                  <span>총 예약일</span>
                                                                </p>
                                                                <p>
                                                                  <label id="check_out_day" class="check_day_count" style='font-size: 20px;'></label>
                                                                </p>
                                                      
                                                              </div>
                                                            </div>
                                                            <div id="buttonBtn">
                                                                <form action="/reserved/day" method="get" onsubmit="return false;">
                                                                  <input type="hidden" id="reserved_day" name="reserved_day" value="">
                                                                  <input type="hidden" id="reserved_checkIn" name="reserved_checkIn" value="">
                                                                  <input type="hidden" id="reserved_checkOut" name="reserved_checkOut" value="">
                                                        
                                                                  <div class="btn-wrapper" style="position:absolute; bottom:5%; left:35%;">
                                                                    <button style=" border:0px; cursor: pointer;" type="button"
                                                                      class="btn-number-search">적용하기</button>
                                                                  </div>
                                                                  <button
                                                                    style="padding-bottom:10px; background-color:white; border:0px; cursor: pointer; position:absolute; top:3%; right:2%;"
                                                                    type="button" id="closeBtn222">
                                                                    <img src="https://www.stayfolio.com/web/images/btn_layer_close.png">
                                                                  </button>
                                                                </form>
                                                              </div>
                                                              
                                                              
                                                            <!-- <script>
                                                      
                                                              window.addEventListener('load', function () {
                                                      
                                                                
                                                                // 예약 페이지에선 닫기 버튼 안보여주기
                                                                if($('.modalOverlay2').attr('style') == null){
                                                                    
                                                                  $('#closeBtn2').attr('style', 'display:none;');
                                                                    
                                                                }
                                                                
                                                      
                                                                if (checkInDate == '' || checkOutDate == '') {
                                                      
                                                                  $('.space').html('');
                                                      
                                                                }
                                                      
                                                      
                                                      
                                                      			 //초기화 버튼
                                                                 reload.addEventListener('click', function (e) {
                                                      
                                                                  e.preventDefault();            <button style="padding-bottom:10px; background-color:white; border:0px; cursor: pointer;"
                                                                      id="reload">초기화</button><br><br>
                                                      
                                                                  //window.location.reload();
                                                      
                                                                  // 달력 체크 인/아웃 값 초기화
                                                                  $('.checkIn').find('.check_in_out_p').html('');
                                                                  $('.checkOut').find('.check_in_out_p').html('');
                                                      
                                                                  $('.day').removeClass('checkIn');
                                                                  $('.day').removeClass('checkOut');
                                                                  $('.day').removeClass('selectDay');
                                                      
                                                      
                                                                  $('.checkInOutInfo label').html('')
                                                      
                                                      
                                                      
                                                                  checkInDate = '';
                                                                  checkOutDate = '';
                                                      
                                                                  // ~ 표시
                                                                  $('.space').html('');
                                                                }); */
                                                      
                                                                // 뒤로가기 버튼
                                                                back.addEventListener('click', function (e) {
                                                      
                                                                  e.preventDefault();
                                                      
                                                                  location.href = '/main';
                                                      
                                                                });
                                                      
                                                              });
                                                      
                                                              // 날짜 유효성 검사
                                                              function check(form) {
                                                      
                                                                if (checkInDate == "") {
                                                      
                                                      
                                                                  alert('체크인 날짜를 선택해 주세요');
                                                      
                                                                  return false;
                                                                }
                                                      
                                                                if (checkOutDate == "") {
                                                      
                                                      
                                                                  alert('체크아웃 날짜를 선택해 주세요');
                                                      
                                                                  return false;
                                                                }
                                                      
                                                                form.submit();
                                                      
                                                      
                                                      
                                                              }
                                                      
                                                            </script>
                                                       -->
                                                          </div>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                        <div class="DateRangePickerInput_arrow DateRangePickerInput_arrow_1"
                                            aria-hidden="true" role="presentation"><svg
                                                class="DateRangePickerInput_arrow_svg DateRangePickerInput_arrow_svg_1"
                                                focusable="false" viewBox="0 0 1000 1000">
                                                <path
                                                    d="M694 242l249 250c12 11 12 21 1 32L694 773c-5 5-10 7-16 7s-11-2-16-7c-11-11-11-21 0-32l210-210H68c-13 0-23-10-23-23s10-23 23-23h806L662 275c-21-22 11-54 32-33z">
                                                </path>
                                            </svg></div>
                                        <div class="DateInput DateInput_1"><input type="text"
                                                class="DateInput_input DateInput_input_1 DateInput_input__readOnly DateInput_input__readOnly_2"
                                                aria-label="체크아웃" id="findEndDate" name="findEndDate" value="체크아웃"
                                                placeholder="체크아웃" autocomplete="off" readonly=""
                                                aria-describedby="DateInput__screen-reader-message-findEndDate" id="checkOut">
                                            <p class="DateInput_screenReaderMessage DateInput_screenReaderMessage_1"
                                                id="DateInput__screen-reader-message-findEndDate">Navigate backward to
                                                interact with the calendar and select a date. Press the question mark
                                                key to get the keyboard shortcuts for changing dates.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row filter_other">
                        <div class="btn_layer mo_only" role="presentation"><button type="button" class="btn_select">국내
                                전체</button></div>
                        <div class="btn_layer" role="presentation"><button type="button" class="btn_select"
                                id='peopleNum'>인원</button>
                        </div>
                        <div class="btn_layer" role="presentation"><button type="button" class="btn_select">가격
                                범위</button></div>
                        <div class="btn_layer" role="presentation"><button type="button" class="btn_select">스테이
                                유형</button></div>
                        <div class="btn_layer" role="presentation"><button type="button"
                                class="btn_select">편의시설</button>
                        </div>
                    </div>
                    <div class="layer_wrap">
                        <div id="selectArea" class="layer_select area "><button type="button"
                                class="btn_close">닫기</button>
                            <div class="tit">국내</div>
                            <ul class="check_list">
                                <li class="area_mobile_active ko"><button type="button" class="active"
                                        style="cursor: pointer;">국내 전체</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">제주</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">서울</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">강원</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">부산</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">경기</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">충청</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">경상</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">전남</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">인천</button></li>
                                <li class="area_mobile ko"><button type="button" class=""
                                        style="cursor: pointer;">광주</button></li>
                            </ul>
                            <div class="tit" style="margin-top: 20px;">해외</div>
                            <ul class="check_list">
                                <li class="area_mobile"><button type="button" class="" style="cursor: pointer;">해외
                                        전체</button></li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">베트남</button>
                                </li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">태국</button>
                                </li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">대만</button>
                                </li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">인도네시아</button></li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">싱가포르</button></li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">라오스</button>
                                </li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">일본</button>
                                </li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">필리핀</button>
                                </li>
                            </ul>
                            <div class="tit" style="margin-top: 20px;">브랜드</div>
                            <ul class="check_list">
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">아만</button>
                                </li>
                                <li class="area_mobile"><button type="button" class="" style="cursor: pointer;">호시노
                                        리조트</button></li>
                                <li class="area_mobile"><button type="button" class=""
                                        style="cursor: pointer;">UDS</button>
                                </li>
                            </ul>
                        </div>
                        <div id="selectNumber" class="layer_select number searchModal"><button type="button"
                                class="btn_close">닫기</button>
                            <div class="tit">인원</div>
                            <dl>
                                <dt style="float: left; margin: 12px 0px 0px;"><span>성인</span></dt>
                                <dd class="">
                                    <div class="number_count"><button type="button" class="btn_minus"
                                            >빼기</button><span class="input-num"><input type="number"
                                                value="0"><span class="person-count">명</span></span><button
                                            type="button" class="btn_plus">더하기</button></div>
                                </dd>
                                <dt style="float: left; margin: 12px 0px 0px;">
                                    <span>아동</span>
                                </dt>
                                <dd class="">
                                    <div class="number_count"><button type="button" class="btn_minus"
                                            >빼기</button><span class="input-num"><input type="number"
                                                value="0" id="person"><span class="person-count">명</span></span><button
                                            type="button" class="btn_plus">더하기</button></div>
                                </dd>
                            </dl>
                            <input type="hidden" name="stdPerson" id="stdPerson" value="0">
                            <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
                        </div>
                        <div id="selectPrice" class="layer_select price searchModal"><button type="button"
                                class="btn_close">닫기</button>
                            <div class="tit">가격 범위</div>
                            <div class="price_wrap">
                                <!-- <div class="price_slid">
                                    <div aria-disabled="false" class="input-range">
                                        <span class="input-range__label input-range__label--min">
                                            <span class="input-range__label-container">0</span>
                                        </span>
                                        <div class="input-range__track input-range__track--background">
                                            <div class="input-range__track input-range__track--active"
                                                style="left: 0%; width: 100%;"></div>
                                            <span class="input-range__slider-container"
                                                style="position: absolute; left: 0%;">
                                                <span class="input-range__label input-range__label--value">
                                                    <span class="input-range__label-container">0</span>
                                                </span>
                                                <div aria-valuemax="100" aria-valuemin="0" aria-valuenow="0"
                                                    class="input-range__slider" draggable="false" role="slider"
                                                    tabindex="0"></div>
                                            </span><span class="input-range__slider-container"
                                                style="position: absolute; left: 100%;"><span
                                                    class="input-range__label input-range__label--value"><span
                                                        class="input-range__label-container">100</span></span>
                                                <div aria-valuemax="100" aria-valuemin="0" aria-valuenow="100"
                                                    class="input-range__slider" draggable="false" role="slider"
                                                    tabindex="0"></div>
                                            </span>
                                        </div><span class="input-range__label input-range__label--max"><span
                                                class="input-range__label-container">100</span></span>
                                    </div>
                                </div> -->
                            </div>
                            <div class="price_input">
                                <div class="input"><small>최저 요금</small><span><input type="text" pattern="[0-9]*"
                                            value="0"
                                            style="width: 85px; font-size: 14px; text-align: right; height: 32px; vertical-align: middle; padding-bottom: 5px;" naame="minPrice" id="minPrice">만원</span>
                                </div><span class="divider" style="border: none; padding: 25px 5px 5px;">-</span>
                                <div class="input"><small>최고 요금</small><span><input type="text" pattern="[0-9]*"
                                            value="100"
                                            style="width: 85px; font-size: 14px; text-align: right; height: 32px; vertical-align: middle; padding-bottom: 5px;" name="maxPrice" id="maxPrice">만원~</span>
                                </div>
                            </div>
                            <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
                        </div>
                        <div id="selectType" class="layer_select type searchModal"><button type="button"
                                class="btn_close">닫기</button>
                            <div class="tit">스테이 유형</div>
                            <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
                            <ul class="check_list" id="stayTypeList">
                                <li class="ko"><label class="check_skin" for="all"><input type="checkbox" 
                                			id="all" name="staytype" value="" checked=""><span>전체</span></label></li>
                                <li class="ko"><label class="check_skin" for="pension"><input type="checkbox"
                                            id="pension" name="staytype" value="펜션"><span>펜션</span></label></li>
                                <li class="ko"><label class="check_skin" for="hanok"><input type="checkbox"
                                            id="hanok" name="staytype" value="한옥"><span>한옥</span></label></li>
                                <li class="ko"><label class="check_skin" for="hostel"><input type="checkbox"
                                            id="hostel" name="staytype" value="렌탈하우스"><span>렌탈하우스</span></label></li>
                                <li class="ko"><label class="check_skin" for="bnb"><input type="checkbox"
                                            id="bnb" name="staytype" value="민박"><span>민박</span></label></li>
                                <li class="ko"><label class="check_skin" for="hotel"><input type="checkbox"
                                            id="hotel" name="staytype" value="호텔"><span>호텔</span></label></li>
                            </ul>
                        </div>
                        <div id="selectTheme" class="layer_select theme searchModal">
                        <button type="button" class="btn_close">닫기</button>
                            <div class="tit">편의시설</div>
                            <div class="btn-wrapper"><button type="button" class="btn-number-search">적용하기</button></div>
                            <ul class="findstay_check_list" id="roomOptionList">
                                 <li class="ko"><label class="check_skin" for="all_theme"><input type="checkbox"
                                            id="all_theme" name="roomOption" value="" checked><span class="convenient">전체</span></label></li>
                                <li class="ko"><label class="check_skin" for="bbq_theme"><input type="checkbox"
                                            name="roomOption" id="bbq_theme" value="babiqu"><span  class="convenient">바베큐</span></label></li>
                                <li class="ko"><label class="check_skin" for="pets_theme"><input type="checkbox"
                                            name="roomOption" id="pets_theme" value="pet"><span class="convenient">반려동물</span></label></li>
                                <li class="ko"><label class="check_skin" for="display_theme"><input type="checkbox"
                                            name="roomOption" id="display_theme" value="beamprojector"><span class="convenient">빔프로젝터, TV</span></label></li>
                                <li class="ko"><label class="check_skin" for="pool_theme"><input type="checkbox"
                                            name="roomOption" id="pool_theme" value="pool"><span class="convenient">풀장</span></label></li>
                                <li class="ko"><label class="check_skin" for="kitchenette_theme"><input type="checkbox"
                                            name="roomOption" id="kitchenette_theme" value="terrace"><span class="convenient">테라스</span></label></li>
                            </ul>
                        </div>
                    </div>
                    <div class="sel_map">
                        <!-- <div class="map_img_off" role="presentation"></div> -->
                    </div>
                    <!-- <a href=""><button type="button" class="btn_reset" id="refreshButton">초기화</button></a> -->
                    <a href="/stay/list" class="btn_reset">초기화</button></a>
                    <div class="search_btn_wrapper"><button type="submit" class="btn_search">SEARCH</button>
                    </div>
        </form>



        <!-- 목록 리스트 버튼 -->
        <div class="_findstay_findstay_list__1KB6H">
            <div class="_findstay_sort_wrap__JLD12">
                <ul class="_findstay_sort_selb__JhhC5">
                    <li><button type="button" class="_findstay_btn_sort__h6PXi btn_toggle" style="background-size: 15px 15px;">모든 스테이</button>
                        <div class="_tooltips_balloon_desc_black__Xv4MX " id='rightnow'>
                            <div class="_tooltips_alert_cont__K8tDm ">지금 특별 프로모션이 진행 중인 스테이를 만나보세요.</div>
                        </div>
                    </li>
                    <li class="_findstay_mo_only__ojbXn"><button type="button"
                            class="_findstay_btn_sort__h6PXi btn_toggle">추천순</button></li>
                </ul>
                <div class="_selector_layer_toggle__U_ckA _selector_layer_sort__dTSl4 " role="button" tabindex="0">
                    <div class="_selector_layer_cover___d3pB">
                        <ul class="_selector_filter_list__UUNfp" id="motionList">
                            <li class="_selector_selected__ciPbE">모든 스테이</li>
                            <li class="">프로모션</li>
                            <li class="">핫해 핫해</li>
                        </ul>
                    </div>
                </div>
                <div class="_selector_layer_toggle__U_ckA _selector_layer_sort__dTSl4" role="button" tabindex="0">
                    <div class="_selector_layer_cover___d3pB">
                        <ul class="_selector_filter_list__UUNfp">
                            <li class="">최신순</li>
                            <li class="">인기순</li>
                            <li class="">높은 가격순</li>
                            <li class="">낮은 가격순</li>
                        </ul>
                    </div>
                </div>
                <ul class="_selector_pc_only__XruVD _selector_sort_list__ypbY1" id="listpick">
                    <li class="_selector_selected__ciPbE">• 최신순</li>
                    <li class="">• 인기순</li>
                    <li class="">• 높은 가격순</li>
                    <li class="">• 낮은 가격순</li>
                </ul>
            </div>
        </div>
    </div>
    </div>
    </div>
    

    
	<div class="container findstay_list  ">
		<div class="flist_wrap" id="stayList">
			<c:forEach items="${list}" var="list" step="1">
				<div class="flist_box">
					<a href="/stay/room?stayName=${list.stayName}">
						<div class="info_container_wrapper">
							<div class="name info_container" role="presentation">${list.stayName }<span>${list.stayType }</span></div>
							<div class="clearfix"></div>
							<div class="flist_info" role="presentation">
								<p class="address info_container" role="presentation"><span>${list.stayLoc }</span><br>
									 기준 ${list.stdPerson }명&nbsp;(최대 ${list.overPerson }명)<br>₩${list.minPrice } ~ ₩${list.maxPrice }</p>
								<p class="btn_more " role="presentation" tabindex="-1" style="cursor: pointer;">예약하기</p>
							</div>
						</div>
						</a>
						
						<div class="flist_img" role="presentation" style="padding-top: 0px;">
							<ul class="swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events slider1 flist_slider">
							
								<div class="swiper-button-prev" onclick="slideActiveBtn()"></div>
								<div class="swiper-button-next" onclick="slideActiveBtn()"></div>
								
								<a href="/stay/room?stayName=${list.stayName}">
								<div class="swiper-wrapper">
									<%-- <li class="swiper-slide img swiper-slide-active"
										style="background: url(/resources/images/${list.mainPic1.replace('\\','/')}) center center / cover no-repeat; cursor: pointer; width: 410px;">
									</li> --%>
 									
<%--  									<c:forEach items="${stayImg}" var="img" step="1">
										<c:if test="${img.stayNo == list.stayNo}">
<!-- 											<li class="swiper-slide img swiper-slide-active" style="background-img: url(/resources/images/벵디.jpg) center center / cover no-repeat; cursor: pointer; width: 410px;"></li> -->
											<li class="swiper-slide img" style="background: url(/resources/images/${img.fileName.replace('\\','/')}) center center / cover no-repeat; cursor: pointer; width: 410px;"></li>
										</c:if>
									</c:forEach> --%>
									
									<%-- <c:forEach items="${stayImg}" var="imgList" step="1">
										<c:if test="${imgList.stayNo eq list.stayNo}">
											<li class="swiper-slide img swiper-slide-active"
												style="background: url(/resources/images/${imgList.fileName.replace('\\','/')}) center center / cover no-repeat; cursor: pointer; width: 410px;">
											</li>
										</c:if>
									</c:forEach> --%>
									
									<c:forEach items="${stayImg}" var="imgList" step="1">
    									<c:if test="${list.stayNo eq imgList.stayNo}">
    										<li class="swiper-slide img swiper-slide-active"
												style="background: url(/resources/images/${imgList.fileName.replace('\\','/') }) center center / cover no-repeat; cursor: pointer; width: 410px;">
											</li>
    									</c:if>
									</c:forEach>
								</div>
								</a>
								<div class="_badge_badge_wrapper__h9IsV">
									<div class="_badge_exclusive__prNZN">
										<span class="_badge_txt__fonwF">${list.badge }</span>
									</div>
								</div>
							</ul>
						</div>
						<c:if test="${sessionScope.memberId == null}">
							<button type="button" class="btn_like " value="${list.stayNo }"><span>관심스테이</span></button>
						</c:if>
						<c:if test="${likeList != null and sessionScope.memberId != null}">
							<button type="button" class="btn_like " value="${list.stayNo }"><span>관심스테이</span></button>
							<c:forEach items="${likeList}" var="likeList" step="1">
								<c:if test="${likeList.stayNo eq  list.stayNo}" var="res">
									<button type="button" class="btn_like on" value="${list.stayNo }"><span>관심스테이</span></button>
								</c:if>
							</c:forEach>
						</c:if>
				</div>
			</c:forEach>
		
			<!-- 페이지 -->
			<div class="paging false">
				<!-- <a href="/" class="prev" title="이전 페이지">이전 페이지</a><a href="/"
					class="on">1</a><a href="/" class="">2</a><a href="/" class="">3</a><a
					href="/" class="">4</a><a href="/" class="">5</a><a
					href="/" class="next" title="다음 페이지">다음 페이지</a> -->
			</div>
		</div>
		</div>
		<%@include file="../common/footer.jsp"%>
</body>
</html>