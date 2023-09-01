package com.gogo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomOptionVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

@Service
public interface MainService {

	public int insert(StayVO vo);
	
	public int insertRoom(RoomVO vo, RoomOptionVO optionVO
					,List<MultipartFile> files, String stayNo);

	public int insertStay(StayVO vo, List<MultipartFile> files);
	
	public void getStay(StayVO vo, Model model);
	
	public int updateStay(StayVO vo, List<MultipartFile> files);

	public void getRoom(RoomVO vo, Model model);

	public int updateRoom(RoomVO vo, RoomOptionVO optionVO, List<MultipartFile> files);

	public void getMainList(Model model);

	public String getStayNo(String memberId, Model model);
	
	public void getPopStayList(Model model);
	
//	public int roomFileupload(List<MultipartFile> files
//			, FileuploadVO vo) ;
//
//	public int stayFileupload(List<MultipartFile> files
//						, FileuploadVO vo);


}
