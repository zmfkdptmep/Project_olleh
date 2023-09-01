package com.gogo.vo;

import lombok.Data;

@Data
public class FileuploadVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private String stayNo;
	private String roomNo;
	private String memberId;
	
	// 저장된 파일경로
	private String savePath;
	private String s_savePath;
	//uploadpath + uuid + "_" + filename;
	private String profile;
	
}
