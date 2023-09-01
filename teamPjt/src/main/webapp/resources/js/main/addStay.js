// 정규표현식(띄어쓰기만 있는 경우)
let regex = /^\s*$/;

window.addEventListener('load', ()=>{
	
	let inputStayName = document.querySelector('input[name=stayName]');
	let inputPostCode = document.querySelector('#postcode');
	let inputStayAdress = document.querySelector('input[name=stayAdress');
	let inputSns = document.querySelector('textarea[name=sns]');
	let notRegister = document.querySelector('input[name=not_register]');
	let register = document.querySelector('input[name=register]');
	let inputStayType = document.querySelector('select[name=stayType]');
	let textareaStayInfo = document.querySelector('textarea[name=stayInfo]');
	let inputBadge = document.querySelector('input[name=badge]');
	let inputFiles = document.querySelector('input[name=files]');
	
	// input 요소 클릭 시 backgroundColor = white
	let inputList = document.querySelectorAll('form[name=addStayForm] input');
	console.log(inputList);
	inputList.forEach( e => {
		e.addEventListener('click', ()=>{
			e.style.backgroundColor='white';
		})
	})	
	
	// area 요소 클릭 시 backgroundColor = white
	let areaList = document.querySelectorAll('form[name=addStayForm] textarea');
	areaList.forEach( e => {
		e.addEventListener('click', ()=>{
			e.style.backgroundColor='white';
		})
	})
	
	inputStayType.addEventListener('click', ()=>{
		inputStayType.style.backgroundColor='white';
	})
		
	// 등록 버튼 눌렸을 때의 이벤트. 유효성 검사, 좌표 저장, 지역저장, submit 처리
	btnAddStay.addEventListener('click', (e)=>{
		e.preventDefault();
		
		
		console.log(regex.test(inputStayName.value));
		if(valueCheck(inputStayName, '스테이 이름을 입력해주세요.')){
			return;
		}else{
			let regex1 = new RegExp("^.{1,30}$");
			if(valueLengthCheck(regex1, inputStayName, '스테이 이름은 30자 이내로 입력해야 합니다.')){
				return;
			}
		}
		
		if(valueCheck(inputPostCode, '우편번호를 입력해주세요.')){
			inputPostCode.style.width='250px';
			return;
		}
		
		if(valueCheck(inputStayAdress, '주소를 입력해주세요.')){
			return;
		}

		let regex2 = new RegExp("^.{1,50}$");
		if(inputSns.value!=''){
			if(valueLengthCheck(regex2, inputSns, 'sns 주소를 확인해주세요. (입력값이 너무 큽니다.)')){
				return;
			}
		}
		// 숙소 사업자 등록
		if(!notRegister.checked && !register.checked){
			notRegister.focus(); /* 메시지 입력 해주어야 함 */
			return;
		}
		
 		if(valueCheck(inputStayType, '')){
 			inputStayType.firstChild.innerHTML = '스테이 타입을 선택해주세요.';
			return;
	 	} 
		
 		if(valueCheck(textareaStayInfo, '스테이 소개를 입력해주세요.')){
 			return;
 		}else{
 									// s가 있어야 줄바꿈되어도 인식됨
 			let regex3 = new RegExp("^.{10,150}$","s");
 			if(valueLengthCheck(regex3, textareaStayInfo, '스테이 소개는 10자 이상 150자 이내로 입력해주세요.')){
 				return;
 			}
 		}
 		
 		if(valueCheck(inputBadge, '뱃지를 입력해주세요.')){
 			return;
 		}else{
 			let regex1 = new RegExp("^.{1,20}$");
 			if(valueLengthCheck(regex1, inputBadge, '뱃지는 20글자 이내로 입력해주세요.')){
 				return;
 			}
 		}
 		
 		if(inputFiles.value == '' && document.querySelector('#image_container').children[1] == null){
 			picCheck('사진 파일을 업로드해 주세요.')
 			return;
 		}
 		
		// 개인정보 수집 동의 체크 유효성 검사
		if(!document.querySelector("input[id=check-policy1]").checked){
			alertPopOn('개인정보 수집 및 이용 동의에 체크 해주세요.')
			return;
		} 
		
		if(!document.querySelectorAll('input[name=stayView]')[0].checked && !document.querySelectorAll('input[name=stayView]')[1].checked){
			document.querySelector('input[name=stayView]').value = '';
			document.querySelector('input[name=stayView]').checked=true;
		}
		
		if(radioCheck3.checked){
			document.querySelector('input[name=registrationYN]').value = 'N';
		}
		
		// 좌표를 받아오기 위해 주소 value 변수에 저장
		let address = document.querySelector("#address").value;
		console.log('address', address);
		
		// 주소에서 앞 2글자로 지역저장
		document.querySelector("input[name=stayLoc]").value = address.substr(0,2);
		console.log(document.querySelector("input[name=stayLoc]").value);
		// 좌표 받아오고 서브밋
		getXY(address);
		
	})
	
	radioCheck3.addEventListener('change', ()=>{
		console.log('와우')
		if(radioCheck3.checked){
			radioCheck4.checked=false;
		} 
	})
	radioCheck4.addEventListener('change', ()=>{
		if(radioCheck4.checked){
			radioCheck3.checked=false;
		}
	}) 
	
})

function getXY(address){
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	    if (status === kakao.maps.services.Status.OK) {
			
	    	// 좌표를 input에 저장
	    	document.querySelector("input[name=latitude]").value = result[0].y;
			document.querySelector("input[name=longitude]").value = result[0].x;
			
			// 서브밋.
			addStayForm.submit();
	    }
	})
}

// 업로드 사진 미리보기
function setThumbnail(event) {
	document.querySelector("div.drag").style.display='none';
	document.querySelector('div[class=form_style]').style.backgroundColor='white';
	// 기존 사진 제거
	let imageContainer = document.querySelector("div#image_container");
	let images = document.querySelectorAll("#image_container img");
	images.forEach((image) => {
		imageContainer.removeChild(image);
	})
	
	var fileList = event.target.files;
	// 업로드 파일이 없으면 div.drag display:block;
	if(fileList.length == 0){
		document.querySelector("div.drag").style.display='block';
	}
	
	// 사진 파일 검사
	let regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif|webp)")
	for(let i=0; i<fileList.length; i++){
		if(!regex.test(fileList[i].name) && fileList.length!=0){
			picCheck('사진파일만 업로드 가능합니다.');
			return;
		}
	}
	
	if(fileList.length < 2){
		picCheck('사진은 최소 2장 업로드 해야 합니다.');
		return;
	}
	
	if(fileList.length > 5){
		picCheck('스테이 사진은 최대 5장 등록 가능합니다.');
		return;
	}
	
	var totalSize = 0;
	for(let i=0; i<fileList.length; i++){
        var reader = new FileReader();

        reader.onload = function(event) {
          var img = document.createElement("img");
          img.setAttribute("src", event.target.result);
          img.setAttribute("id", 'thumnailImg'+i);
          img.style='width:150px; height:85px; padding:5px; border-radius:12px';
       	  //document.querySelector("div#image_container").
          document.querySelector("div#image_container").appendChild(img);
        };
        totalSize += event.target.files[i].size;
        reader.readAsDataURL(event.target.files[i]);
    }
	console.log('totalSize', totalSize);
	totalSize = (totalSize/(1024*1024)).toFixed(3);
	if(totalSize >= 30){
		picCheck('업로드 가능 용량이 초과되었습니다(30MB)');
		totalSize = 0;
		return;
	}
	document.querySelector("div[class=file_desc]").firstChild.textContent=totalSize;
	
}

// 사진 체크 후 조건에 걸렸을 때 실행될 함수
function picCheck(msg){
	document.querySelector('div[class=drag]').innerHTML = msg;
	document.querySelector("div.drag").style.display='block';
	document.querySelector('div[class=drag]').focus();
	document.querySelector('input[name=files]').value='';
	document.querySelector('div[class=form_style]').style.backgroundColor='#eee';
}

// input value 빈문자열 혹은 띄어쓰기만 있는 경우 체크
function valueCheck(doc, msg){
	if(doc.value == '' || regex.test(doc.value)){
		doc.value = '';
		doc.placeholder=msg;
		doc.style.backgroundColor='#eee';
		doc.focus();
		return true;
	}
}

// input value 길이 체크
function valueLengthCheck(regex, doc, msg){
	if(!regex.test(doc.value)){
		doc.value = '';
		doc.placeholder=msg;
		doc.focus();
		doc.style.backgroundColor='#eee';
		return true;
	}
}

// 사진 업로드 미리보기 창 클릭 시 input:file 실행
function fileUpload(){
	file_attach.click();
}

function radioCancle(){
	mountain.checked=false;
	ocean.checked=false;
}