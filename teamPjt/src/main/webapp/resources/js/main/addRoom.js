	let regex = /^\s*$/;

	window.addEventListener('load', ()=>{
		
		let inputRoomName = document.querySelector('input[name=roomName]');
		let selectStdPerson = document.querySelector('select[name=stdPerson]');
		let selectOverPerson = document.querySelector('select[name=overPerson]');
		let selectBed = document.querySelector('select[name=bed]');
		let inputPrice = document.querySelector('input[name=price]');
		let inputInfo = document.querySelector('input[name=info]');
		let textareaRoomInfo = document.querySelector('textarea[name=roomInfo]');
		let inputFiles = document.querySelector('input[name=files]');
		
		// input 요소 클릭 시 backgroundColor = white
		let inputList = document.querySelectorAll('form[name=addRoomForm] input');
		console.log(inputList);
		inputList.forEach( e => {
			e.addEventListener('click', ()=>{
				e.style.backgroundColor='white';
			})
		})
		
		// area 요소 클릭 시 backgroundColor = white
		let areaList = document.querySelectorAll('form[name=addRoomForm] textarea');
		areaList.forEach( e => {
			e.addEventListener('click', ()=>{
				e.style.backgroundColor='white';
			})
		})
		
		// select 요소 클릭 시 backgroundColor = white
		let selectList = document.querySelectorAll('form[name=addRoomForm] select');
		selectList.forEach( e => {
			e.addEventListener('click', ()=>{
				e.style.backgroundColor='white';
			})
		})
		
		selectOverPerson.addEventListener('click', ()=>{
			liOverPerson.style.width='53%';
			divOverPerson.style.width='200px';
			selectOverPerson.firstElementChild.innerHTML='선택해 주세요';
		})
		
		// room 등록 버튼 클릭 이벤트
		btnAddRoom.addEventListener('click', (e)=>{
			e.preventDefault();
			
			if(valueCheck(inputRoomName, '객실 이름을 입력해주세요.')){
				return;
			}else{
				let regex1 = new RegExp("^.{1,30}$");
				if(valueLengthCheck(regex1, inputRoomName, '객실 이름은 30자 이내로 입력해야 합니다.')){
					return;
				}
			}
			
			if(valueCheck(selectStdPerson, '기준 인원을 선택해주세요.')){
				return;
			}
			
			if(valueCheck(selectOverPerson, '최대 인원을 선택해주세요.')){
				return;
			}
			
			// 최대 인원이 기준 인원보다 작으면 return
			if(selectOverPerson.value < selectStdPerson.value){
				selectOverPerson.value = '';
				liOverPerson.style.width='78%';
				divOverPerson.style.width='400px';
				document.querySelector('select[name=overPerson]').firstElementChild.innerHTML='최대인원은 기준인원보다 크거나 같아야 합니다.';
				document.querySelector('select[name=overPerson]').firstElementChild.selected=true;
				selectOverPerson.style.backgroundColor='#eee';
				selectOverPerson.focus();
				return;
			}
			
			if(valueCheck(selectBed, '침구 갯수를 선택해주세요.')){
				return;
			}
			
			if(valueCheck(inputPrice, '1박 가격을 입력해주세요. (가격은 숫자로만 입력해주세요.)')){
				return;
			}else{
				let regex2 = new RegExp('^[1-9][0-9]{0,9}$', 'm');
				if(valueLengthCheck(regex2, inputPrice, '가격은 숫자로만 입력할 수 있고, 10자리를 넘길 수 없습니다.')){
					return;
				}
			}
			
			if(valueCheck(inputInfo, '객실 소제목을 입력해주세요.')){
				return;
			}else{
				let regex3 = new RegExp('^.{1,50}$');
				if(valueLengthCheck(regex3, inputInfo, '객실 소제목은 50글자 이내로 입력해야 합니다.')){
					return;
				}
			}
			
			if(valueCheck(textareaRoomInfo, '객실 소개를 입력해주세요.')){
				return;
			}else{
				let regex4 = new RegExp("^.{10,300}$","s");
				if(valueLengthCheck(regex4, textareaRoomInfo, '객실 소개는 10자 이상 300자 이내로 입력해주세요.')){
					return;
				}
			}
			
			if(inputFiles.value == '' && document.querySelector('#image_container').children[1] == null){
				picCheck('사진 파일을 업로드 해주세요.');
				return;
			}
			
			// roomOption 체크박스 확인
			let optionCheck = document.querySelectorAll("input[type=checkbox]");
			// option 체크박스 돌면서
			optionCheck.forEach((option)=>{
				// 체크되어있지 않으면
				if(!option.checked){
					// value를 N으로 바꾸고
					option.value='N';
					// checked설정
					option.checked=true;
				}
			})
			
			addRoomForm.submit();
			
		})
	})
	
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
		
		if(fileList.length > 10){
			picCheck('스테이 사진은 최대 10장 등록  가능합니다.');
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
