<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<link href="/resources/main/add.css">
<script type="text/javascript" src="/resources/js/main/addRoom.js"></script>
<div id="contents">
	<div class="container sub_title">
		<div class="txt">room 수정</div>
	</div>
	<div class="store_apply">
		<form name="addRoomForm" method="post" enctype="multipart/form-data" action="/editRoomAction">
			<div class="store_apply_form">
				<ul class="form_dl">
					<div class="_contactus_divider__BZ5eb"></div>
					<li style="flex-direction: row"><span class="left">room 정보</span>
					<span class="right">* 필수 입력 항목</span></li>
					<li><div class="dt">room 이름 *</div>
						<div class="dd">
							<input type="text" class="form_style" name="roomName" value="${ map.roomVO.roomName }"
								placeholder="room 이름을 입력해 주세요. (30자 이내)">
						</div></li>
					<li style="width:53%"><div class="dt">기준인원 *</div>
						<div class="dd" style="width:200px">
							<select style="width: 100%" class="form_style" name="stdPerson"><option
									selected="" value="">선택해 주세요</option>
								<c:forEach begin="1" end="10" step="1" var="i">
									<option value=${ i } ${ map.roomVO.stdPerson eq i ? 'selected' : '' }>${ i }</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li style="width:53%" id="liOverPerson">
						<div class="dt">최대인원 *</div>
						<div class="dd" style="width:200px" id="divOverPerson">
							<select style="width: 100%" class="form_style" name="overPerson">
								<option selected="" value="">선택해 주세요</option>
								<c:forEach begin="1" end="10" step="1" var="i">
									<option value=${ i } ${ map.roomVO.overPerson eq i ? 'selected' : '' }>${ i }</option>
								</c:forEach>
							</select>
						</div>
					</li>
					<li><div class="dt">옵션 *</div>
						<div class="dd">
							<label for="bathroom" class="check_skin">
								<input type="checkbox" id="bathroom" value="Y" name="bathroom"
											${ map.roomOption.bathroom eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">화장실</span>
								</label>
							<label for="babiqu" class="check_skin">
								<input type="checkbox" id="babiqu" value="Y" name="babiqu"
											${ map.roomOption.babiqu eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">바비큐</span>
								</label>
							<label for="kitchen" class="check_skin">
								<input type="checkbox" id="kitchen" value="Y" name="kitchen"
											${ map.roomOption.kitchen eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">부엌</span>
								</label>
							<label for="pet" class="check_skin">
								<input type="checkbox" id="pet" value="Y" name="pet"
											${ map.roomOption.pet eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">반려동물</span>
								</label>
							<label for="pool" class="check_skin">
								<input type="checkbox" id="pool" value="Y" name="pool"
											${ map.roomOption.pool eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">풀장</span>
								</label>
							<label for="terrace" class="check_skin">
								<input type="checkbox" id="terrace" value="Y" name="terrace"
											${ map.roomOption.terrace eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">테라스</span>
								</label>
							<label for="parking" class="check_skin">
								<input type="checkbox" id="parking" value="Y" name="parking"
											${ map.roomOption.parking eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">주차장</span>
								</label>
							<label for="beamProjector" class="check_skin">
								<input type="checkbox" id="beamProjector" value="Y" name="beamProjector"
											${ map.roomOption.beamProjector eq 'Y' ? 'checked' : '' }>
									<span style="font-size: 12px">빔프로젝터</span>
								</label>
						
						<div class="dd" style="width:200px; display:flex; padding-top:10px">
							<select style="width: 100%" class="form_style" value="Y" name="bed"><option
									selected="" value="">침구 갯수</option>								
								<c:forEach begin="0" end="10" step="1" var="i">
									<option value="${ i }" ${ map.roomOption.bed eq i ? 'selected' : '' }>${ i }</option>
								</c:forEach>
							</select>
						</div>
							</div>
						</li>
					<li><div class="dt">1박 가격 *</div>
						<div class="dd">
							<input type="text" class="form_style" name="price" value="${ map.roomVO.price }"
								placeholder="단위 구분 기호(,) 사용하지 않고 숫자만으로 입력해주세요. 단위 : 원">
						</div></li>
					<li><div class="dt">room 소제목 *</div>
						<div class="dd">
							<input type="text" class="form_style" name="info" value="${ map.roomVO.info }"
								placeholder="room의 소제목을  간단하게 입력해주세요. (최대 50자)">
						</div></li>
					<li><div class="dt">room 소개 *</div>
						<div class="dd">
							<textarea rows="5" class="form_style" name="roomInfo"
								placeholder="공간의 구조, 컨셉, 스토리 등을 자유롭게 작성해 주세요. (최소 50자)">${ map.roomVO.roomInfo }</textarea>
						</div></li>
					<div class="_contactus_divider__BZ5eb"></div>
					
					<li><div class="left">이미지 제출</div></li>
					<div class="container text-start lh-base" style="background-color: white">
						<div class="row g-1">
							<div class="col-6">
								<div class="p-1 bg-white">
									<img
										src="/resources/images/room/roomphoto3.JPG"
										style="width: 100%;">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-white">
									<img alt=""
										src="/resources/images/room/roomphoto2.JPG"
										style="width: 100%">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-white">
									<img alt=""
										src="/resources/images/room/roomphoto1.JPG"
										style="width: 100%">
								</div>
							</div>
							<div class="col-6">
								<div class="p-1 bg-white">
									<p class="_contactus_guide_title__ZyIpA">이미지 제출 가이드</p>
									<p class="_contactus_guide_list__ogEdb">• room 이미지 제출은 필수 사항 입니다.</p>
									<p class="_contactus_guide_list__ogEdb">• room 이미지는 최대 10장까지 제출 할 수 있습니다.</p>
									<p class="_contactus_guide_sub_list__srBT5">￮ room의 외부 사진</p>
									<p class="_contactus_guide_sub_list__srBT5">￮ room의 디테일</p>
								</div>
							</div>
						</div>
					</div>


<!-- 					부트스트랩 파일첨부 input		
							<div class="mb-3">
								<label for="formFileMultiple" class="form-label"></label> 
								<input class="form-control" type="file"
									id="formFileMultiple" multiple>
							</div> -->
					<li><div class="dt">파일 첨부 *</div>
						<div class="dd">
							<div class="file_wrap">
								<div class="form_style" style="padding: 0; align-items: center" role="presentation"
									tabindex="0" id="image_container" onclick="fileUpload()">
									<c:forEach items="${ map.listPhoto }" var="photo">
										<img src="/resources/images/${ photo.savePath }" style="width:150px; height:85px; padding:5px; border-radius:12px">
									</c:forEach>
									<div class="drag" role="button" style="cursor: pointer; display:none"
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
									* room 사진은 최대 최대 10장 등록 가능합니다.</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="bt_btns">
				<button type="submit" class="btn_bk" id="btnAddRoom">수정하기</button>
				<button type="reset" class="btn_bk">초기화</button>
			</div>
			<input type="hidden" name="roomNo" value="${ map.roomVO.roomNo }">
			<input type="hidden" name="stayNo" value="${ map.roomVO.stayNo }">
		</form>
	</div>
</div>

<jsp:include page="../common/footer.jsp"/>