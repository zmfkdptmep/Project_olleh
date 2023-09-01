package com.gogo.vo;

import java.util.List;

import lombok.Data;

@Data
public class RoomPhotoVO {

	private String roomNo; // 객실 seq
	private String stayNo; // 숙소 seq
	private List<String> roomImg; // 이미지 사진
	private String field; // 사진 위치
}
