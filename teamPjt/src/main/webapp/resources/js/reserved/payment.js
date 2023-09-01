

	
		/* 결제 */
		function purchased(pg){
		
		
				console.log('pg', pg);
				console.log('paymentNo', paymentNo);
				console.log('purchaseName', purchaseName);
				console.log('purchaseAmount', purchaseAmount);
				console.log('buyer_name', buyer_name);
			
				IMP.init('imp31246282');
				IMP.request_pay({
				    pg : pg,
				    pay_method : 'card', //생략 가능
				    merchant_uid : 'merchant_'+paymentNo, // 상점에서 관리하는 주문 번호
				    name : purchaseName,
				    amount : purchaseAmount,
				    buyer_email : 'iamport@siot.do',
				    buyer_name : buyer_name,
				    buyer_tel : '010-1234-5678',
				    buyer_addr : '서울특별시 강남구 삼성동',
				    buyer_postcode : '123-456',
				    m_redirect_url : '/'
				    
				    
				}, function(rsp){
					
					
					console.log(rsp.merchant_uid);
					console.log(rsp.imp_uid);
					console.log(rsp.success);
					console.log(rsp.pg_provider);
					
					rsp.checkIn = r_checkIn;
					rsp.checkOut = r_checkOut;
					rsp.roomNo = roomNo;
					rsp.memberCount = memberCount;
					rsp.reservationNo = reservationNo;
					rsp.memberId = memberId;
					rsp.talkSome = talkSome;
					
					console.log("rsp : ", rsp);
					
					
					if(rsp.imp_uid!=null && rsp.imp_uid!=""){
						
					
					
					$.ajax({
						
						type: "POST"
						, url : "/payment/verify/"+rsp.imp_uid
						, contentType : "application/json"
						, data : JSON.stringify(rsp)
						
					}).done(function(data){
						
						console.log("data : ", data);
						
						if(data.response!=null && data.response != ''){
									
							if(rsp.paid_amount == data.response.amount){
								
								
								alert("결제 및 결제 검증 완료");
								
							} else {
								alert("결제 및 결제 검증 실패 : "+ rsp.error_msg);
								return false;
							}
						} else {
							
							alert("결제가 취소되었습니다.");
							return false;
						}
					});
					

					if(rsp.success){
						
						var msg = '결제가 완료되었습니다.';
						//msg += '고유ID : '+ rsp.imp_uid;
						//msg += '상점 거래ID : '+ rsp.merchant_uid;
						//msg += '결제 금액 : '+ rsp.paid_amount;
						//msg += '카드 승인번호 : '+ rsp.apply_num;
							
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '\n에러내용 : '+ rsp.error_msg;
					}
					
				
						alert(msg);
						location.href='/member/mypage/reservation';
					
				
				
				} else {
					alert('[결제 오류] 사용량이 많습니다.\n받아들이고 다시 시도해 주세요');
					console.log(rsp.error_msg);
					alert('rsp.error_msg : '+rsp.error_msg);
					//alert('[결제 오류] 거래 번호(imp_uid)가 존재하지 않습니다.\n다시 시도해 주세요!');
					location.href='/member/mypage/reservation';
				}
			})
		}
		
		
		  /* 환불 */
		  function canclePayFunction() {
			  
			  if(canclePay==null || canclePay==''
				  || realAmount == null || realAmount == ''){
				  
				  alert('값을 모두 적어주세요.')
				  return false;
			  }
			  
			  
			  
			  let imp_uid = canclePay;
			  let merchant_uid = '375'; // 필요 음슴..
			  let amount;
			  
			  // 원래 가격을 checksum에 넣어 검수하기 위한 ajax
			  $.ajax({
				 "url" : "/payment/payInfoAction"
				 , "type" : "post"
				 , "contentType" : "application/json"
				 , "data" : imp_uid
			  }).done(function(res){
				  
				  if(res.message!=null){
					  alert(res.message);
					  return false;
				  }
				  
				  console.log("original amount : ",res.vo.amount)
				  amount = res.vo.amount;
				  
				    $.ajax({
				      // 예: http://www.myservice.com/payments/cancel
				      "url": "/payment/canclePay/"+amount+"", 
				      "type": "post",
				      "contentType": "application/json",
				      "data": JSON.stringify({
				    	"imp_uid" : imp_uid,
				        "merchant_uid": merchant_uid, // 예: ORD20180131-0000011
				        "cancel_request_amount": realAmount, // 환불금액
				        "checksum" : amount, // 검증 가격
				        "reason": "테스트 결제 환불", // 환불사유
				        // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
				        "refund_holder": "홍길동", 
				        // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
				        "refund_bank": "88", 
				        // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
				        "refund_account": "110516493052" 
				      }),
				      "dataType": "json"
				    }).always(function(res){
				    	
				    	console.log(res);
				    	
				    	if(res.responseText == 'success'){
				    		alert('환불 요청 완료');
				    		location.href='/member/mypage/cancel';
				    	} else if (res.responseText == 'dup'){
				    		alert('이미 처리된 건입니다.');
				    	} else {
				    		alert('환불 처리 중 오류 발생');
				    		
				    	}
				    })
			  });
			  
		  }
		  
		  
		  
		  /* 결제 정보를 console에 찍어주는 스크립트 
		    	노쓸모 */
		  function payInfoConsole() {
			  
			  	if(payInfo == null || payInfo == ''){
			  		
			  		alert('값을 모두 적어주세요');
			  		return false;
			  		
			  	}
			  
			  	
			  	let buyerName = payInfo;
			  
			    $.ajax({
			      // 예: http://www.myservice.com/payments/cancel
			      "url": "/member/payInfo", 
			      "type": "post",
			      "contentType": "application/json",
			      "data": buyerName
			    }).done(function(data){
			    	
			    	console.log('list : ', data);
			    	
			    });
			  }

