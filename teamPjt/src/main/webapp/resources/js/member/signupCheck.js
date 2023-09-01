/**
 * 회원가입시 각 항목에 대한 입력 유효성 판단 
 */
var space = /\s/g;
var title = "";
var signup = {
	common: {
		empty: {code: 'invalid', desc: title + '입력란이 비어있습니다.'},
		space: {code: 'invalid', desc: '공백 없이 입력하세요.'},
		min: {code: 'invalid', desc: '최소 5자 이상 입력하세요.'},
		max: {code: 'invalid', desc: '최대 10자 이내로 입력하세요.'}
	},
	
	id: {
		valid: { code:'valid', desc: '아이디를 중복 확인하세요.' },
		invalid: { code:'invalid', desc: '아이디는 영문 소문자, 숫자만 입력하세요.' },
		usable: { code: 'valid', desc: '사용 가능한 아이디입니다.'},
		unusable: { code: 'invalid', desc: '이미 사용 중인 아이디입니다.' }
	},
	
	id_usable: function(data) {
		if(data.code=='vaild'){
			return this.id.usable;
		} else {
			return this.id.unusable;
		}
	},
	
	id_status: function(id) {
		console.log("id : ", id)
		var reg = /[^a-z0-9]/g;
		title = $('[name=memberId]').attr('title');
		if(id == '') { 
			return this.common.empty;
		} else if(id.match(space)) {
			return this.common.space;
		} else if(reg.test(id)) {
			return this.id.invalid;
		} else if(id.length < 5) {
			return this.common.min;
		} else if(id.length > 10) {
			return this.common.max;
		} else {
			return this.id.valid;
		}
	},
	
	pw: {
		valid: { code:'valid', desc: '사용 가능한 비밀번호입니다.' },
		invalid: { code:'invalid', desc: '비밀번호는 영문 대/소문자, 숫자만 입력하세요.' },
		lack: { code:'invalid', desc: '비밀번호는 영문 대/소문자, 숫자를 모두 포함해야 합니다.' },
		equal: { code: 'valid', desc: '비밀번호가 일치합니다.' },
		notEqual: { code: 'invalid', desc: '비밀번호가 일치하지 않습니다.' },
		min: {code: 'invalid', desc: '최소 8자 이상 입력하세요.'}, 
		max: {code: 'invalid', desc: '최대 20자 이내로 입력하세요.'}
		
	},
	
	pw_status: function(pw) {
		var reg = /[^a-zA-Z0-9]/g;
		title = $('[name=pw]').attr('title');
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g;
		if(pw == '') return this.common.empty;
		else if(pw.match(space)) return this.common.space;
		else if(reg.test(pw)) return this.pw.invalid;
		else if(pw.length < 8) return this.pw.min;
		else if(pw.length > 20) return this.pw.max;
		else if ( !upper.test(pw) || !lower.test(pw) || !digit.test(pw) ) return this.pw.lack;
		else return this.pw.valid;
	},
	
	pw_ck_status: function(pw_ck) {
		title = $('[name=pw_ck]').attr('title');
		if ( pw_ck=='' ) return this.common.empty;
		else if(pw_ck == $('[name=pw]').val() ) return this.pw.equal;
		else return this.pw.notEqual; 
	},
	tag_status: function(tag) {
		console.log("tag :", tag)
		console.log("tag :", tag.val())
	    var data;
	    if (tag.attr('name') == 'memberId') {
	        data = this.id_status(tag.val());
	    } else if (tag.attr('name') == 'pw') {
	        data = this.pw_status(tag.val());
	    } else if (tag.attr('name') == 'pw_ck') {
	        data = this.pw_ck_status(tag.val());
	    }
	    return data;
	}
}


// 사용자 약관체크(script)
document.addEventListener("DOMContentLoaded", function() {
    // 사용자 약관 전체 동의 체크 박스를 클릭했을 때
    var checkAll = document.getElementById("check_all");
    checkAll.addEventListener("click", function() {
        // 전체 동의 체크 박스의 상태를 가져옴
        var isChecked = checkAll.checked;

        // 개별 약관 동의 체크 박스들의 상태를 전체 동의 체크 박스와 같은 상태로 반영
        var listFoldCheckboxes = document.querySelectorAll("#listFold input[type='checkbox']");
        for (var i = 0; i < listFoldCheckboxes.length; i++) {
            listFoldCheckboxes[i].checked = isChecked;
        }
    });

    // 개별 약관 동의 체크 박스를 클릭했을 때
    var individualCheckboxes = document.querySelectorAll("#listFold input[type='checkbox']:not(#check_all)");
    for (var i = 0; i < individualCheckboxes.length; i++) {
        individualCheckboxes[i].addEventListener("click", function() {
            // 개별 동의 체크 박스들 중 하나라도 체크되지 않았는지 확인
            var isAnyUnchecked = false;
            for (var j = 0; j < individualCheckboxes.length; j++) {
                if (!individualCheckboxes[j].checked) {
                    isAnyUnchecked = true;
                    break;
                }
            }

            // 개별 동의 체크 박스들 중 하나라도 체크되지 않았으면 사용자 약관 전체 동의 체크 박스의 체크를 해제
            checkAll.checked = !isAnyUnchecked;
        });
    }
});


