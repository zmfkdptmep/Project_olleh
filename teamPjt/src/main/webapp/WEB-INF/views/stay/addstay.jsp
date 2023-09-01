<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../common/header.jsp" />
<link href="/resources/main/add.css">
<style>

input ::placeholder{
	font-style: italic;
}

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7f4e3f6830b08acddb284ad285c5c0d&libraries=services"></script>
<script type="text/javascript" src="/resources/js/main/addStay.js"></script>
<style>
	
</style>
<div id="contents">
	<div class="container sub_title">
		<div class="txt">Stay 등록</div>
	</div>
	<div class="store_apply">
		<form name="addStayForm" method="post" enctype="multipart/form-data" action="/addStayAction">
			<div class="store_apply_form">
				<ul class="form_dl">
					<div class="_contactus_divider__BZ5eb"></div>
					<li style="flex-direction: row"><span class="left">스테이
							정보</span><span class="right">* 필수 입력 항목</span></li>
					<li><div class="dt">스테이 이름 *</div>
						<div class="dd">
							<input type="text" class="form_style" name="stayName" value=""
								placeholder="스테이 이름을 입력해 주세요. (30자 이내)">
						</div></li>
					
					<!-- 우편번호 검색 -->
					<jsp:include page="joosoSearch.jsp"/>

					<li><div class="dt">웹사이트 및 SNS 주소</div>
						<div class="dd">
							<textarea class="form_style" name="sns"
								placeholder="스테이 공간 / 브랜드를 살펴볼 수 있는 instagram 주소를 기재해 주세요."></textarea>
						</div></li>
					<li><div class="dt">숙박업 사업자 등록 여부 *</div>
						<div class="dd">
							<label for="radioCheck3" class="radio_skin"><input
								type="radio" id="radioCheck3" name="not_register"><span
								style="font-size: 12px">준비 중</span></label><label for="radioCheck4"
								class="radio_skin"><input type="radio" id="radioCheck4"
								name="register"><span style="font-size: 12px">등록
									완료</span></label>
						</div></li>
					<li><div class="dt">분류 *</div>
						<div class="dd">
							<select style="width: 100%" class="form_style" name="stayType"><option
									selected="" value="" disabled="" hidden="">선택해 주세요</option>
								<option value="펜션">펜션</option>
								<option value="한옥">한옥</option>
								<option value="렌탈하우스">렌탈하우스</option>
								<option value="민박">민박</option>
								<option value="호텔">호텔</option></select>
						</div></li>
						
					<li><div class="dt">스테이 뷰 *</div>
						<div class="dd">
							<label for="mountain" class="radio_skin"> <input
								type="radio" id="mountain" name="stayView" value="산"> <span
								style="font-size: 12px">산</span>
							</label> <label for="ocean" class="radio_skin"> <input
								type="radio" id="ocean" name="stayView" value="바다"> <span
								style="font-size: 12px">바다</span>
							</label> <input type="button"
								onclick="radioCancle()" value="선택취소"
								class="d_btn">
						</div></li>
					<li><div class="dt">스테이 소개 *</div>
						<div class="dd">
							<textarea rows="5" class="form_style" name="stayInfo"
								placeholder="공간의 구조, 컨셉, 스토리 등을 자유롭게 작성해 주세요. (최소 10자, 최대 150자)"></textarea>
						</div></li>
					<li><div class="dt">뱃지 *</div>
						<div class="dd">
							<input type="text" class="form_style" name="badge" value=""
								placeholder="뱃지는 ... 입니다.">
						</div></li>
					<div class="_contactus_divider__BZ5eb"></div>
					
					<li><div class="left">이미지 제출</div></li>
					<div class="container text-start lh-base" style="background-color: white">
						<div class="row g-1">
							<div class="col-6">
								<div class="p-1 bg-white">
									<img
										src="https://images.stayfolio.com/system/pictures/images/000/026/062/original/6be1c115d15928bfd8cdece979778e183b380f30.jpg?1523266043"
										style="width: 100%;">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-white">
									<img alt=""
										src="https://www.stayfolio.com/_next/image?url=http%3A%2F%2F%2F%2Fimages.stayfolio.com%2Fsystem%2Fpictures%2Fimages%2F000%2F187%2F276%2Foriginal%2Fc0769ad4ba823cca80805714a5c6734a6421f10b.jpg%3F1688627296&w=3840&q=75"
										style="width: 100%">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-white">
									<img alt=""
										src="https://www.stayfolio.com/_next/image?url=https%3A%2F%2Fimages.stayfolio.com%2Fsystem%2Fpictures%2Fimages%2F000%2F013%2F971%2Foriginal%2F39825fb5a1aa7be5ef4a72f3ae2cd000e453583a.jpg%3F1481683602&w=2048&q=75"
										style="width: 100%">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-">
									<p class="_contactus_guide_title__ZyIpA">이미지 제출 가이드</p>
									<p class="_contactus_guide_list__ogEdb">• 숙소 이미지 제출은 필수 사항 입니다.</p>
									<p class="_contactus_guide_list__ogEdb">• 숙소 이미지는 최대 5장까지 제출 할 수 있습니다.</p>
									<p class="_contactus_guide_sub_list__srBT5">￮ 전체으로 나온 숙소의 사진</p>
									<p class="_contactus_guide_sub_list__srBT5">￮ 숙소에 있는 대표 room의 사진</p>
								</div>
							</div>
						</div>
					</div>

					<li><div class="dt">파일 첨부 *</div>
						<div class="dd">
							<div class="file_wrap">
								<div class="form_style" style="padding: 0; align-items: center" role="presentation"
									tabindex="0" id="image_container" onclick="fileUpload()">
									<div class="drag" role="button" style="cursor: pointer"
										tabindex="0">
										<i class="ico_addfile"></i>첨부파일 올리기/미리보기
									</div>
								</div>
								<div class="file_desc">
									0
									<!-- -->
									MB / 30 MB
									<div class="file_att" style="margin-top: -7px">
										<label for="file_attach"><img alt="file_upload_button"
											src="https://www.stayfolio.com/web/images/file_upload_button.svg"
											style="margin-bottom: 2px; margin-right: 6px">이미지
											첨부</label><input type="file" name="files" id="file_attach" multiple onchange="setThumbnail(event)"
											accept="image/png,image/gif,image/jpg,image/jpeg,image/webp,image/tif,image/tiff,image/bmp,video/mp4,application/pdf,video/quicktime">
									</div>
								</div>
								<p class="lh-base" style="font-size: 12px; margin-top: 15px; color: #808080">*
									대용량 파일의 경우 업로드까지 3분 이상 소요될 수 있습니다.<br>
									* 숙소사진 2장은 필수 입니다.<br>
									* 최대 등록 가능 사진 수는 5장 입니다.</p>
							</div>
						</div></li>
				</ul>
			</div>
			<div class="store_apply_agree">
				<div class="box">
					<div class="tit">개인정보 수집 및 이용 동의</div>
					<div class="desc">
						(주)올래갈래는 아래의 목적으로 개인정보를 수집 및 이용하며, 신청인의 개인정보를 안전하게 취급하는데 최선을
						다합니다.<br> <br>1. 수집 항목 : 스테이 이름, 상세 주소, 담당자 성함, 전화번호, 메일
						주소, 스테이 소개, 첨부 자료<br>2. 수집 및 이용 목적 : 입점에 따른
						정보 확인, 입점 가능 여부 전달 및 문의사항 대응<br>3. 보유 및 이용 기간 : 입점 및 문의를
						위해 검토 완료 후, 3개월 간 보관하며 이후 해당 정보는 파기됩니다.<br> <br> <span>이외
							기타 사항은 별도 고지하는 [<a target="_blank" rel="noreferrer"
							style="display: inline" class="bold_contactus"
							href="https://stayfolio.notion.site/Ver-2-1-1b8348dda5aa42419ed16a27381e8ad6">개인정보
								처리방침</a>]을 참고해 주시기 바랍니다.
						</span><br>
					</div>
				</div>
				<label for="check-policy1" class="check_skin"
					style="width: 100%; display: flex; justify-content: center; margin-top: 34px"><input
					type="checkbox" id="check-policy1"><span
					class="check_policy">개인정보 수집 및 이용에 동의합니다. [필수]</span><span
					class="check_box"></span></label>
			</div>
			<div class="bt_btns">
				<button type="submit" class="btn_bk" id=btnAddStay>등록하기</button>
				<button type="reset" class="btn_bk">초기화</button>
			</div>
			<!--  -->
			<input type="hidden" name="memberId" value="${ empty sessionScope.memberId ? 'host1' : sessionScope.memberId}">
			<input type="hidden" name="stayLoc" value="">
			<input type="hidden" name="latitude" value="">
			<input type="hidden" name="longitude" value="">
			<input type="hidden" name="registrationYN" value="Y">
		</form>
	</div>
</div>

<jsp:include page="../common/footer.jsp" />