package com.gogo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.vo.FileuploadVO;

@Service
public interface FileuploadService {

	public int fileupload(List<MultipartFile> files, String dir
						,FileuploadVO vo);

	public int deleteStayPhoto(FileuploadVO vo);
	
	//
	public String fileuploadMainPic(List<MultipartFile> files, String dir, FileuploadVO paramFileuploadVO);

}
