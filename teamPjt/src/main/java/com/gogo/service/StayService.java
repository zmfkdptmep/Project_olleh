package com.gogo.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomPhotoVO;
import com.gogo.vo.StayVO;

@Service
public interface StayService {

	List<StayVO> stayList(Model model);
	
	 List<StayVO> stayKeywordList(StayVO vo, Model model);
	
	Map<String, String> roomInfo(String stayName, Model model);
	
	List<Map<String, String>> stayRoomList(String stayName, Model model);
	
	Map<String, String> roomInfoPageList(@Param("stayName")String stayName, @Param("roomName")String roomName, Model model);
	
	List<RoomPhotoVO> roomInfoPagePic(@Param("stayName")String stayName, @Param("roomName")String roomName, Model model);
	
	int insertLike(StayVO vo);
	
	List<StayVO> likeId(StayVO vo, Model model);
	
	int deleteLike(StayVO vo);
	
	List<FileuploadVO>stayRoomImg(String stayName, Model model);
	
	List<FileuploadVO> stayImgList(Model model);

	void stayLocList(StayVO vo, Model model);
	
	List<StayVO> likeIdRest(StayVO vo);
	
	List<Map<String, String>> stayRoomListDate(@Param("stayName")String stayName, @Param("findStartDate")String findStartDate, @Param("findEndDate")String findEndDate);
	
	List<Map<String, String>> stayRoomImgDate(@Param("stayName")String stayName, @Param("findStartDate")String findStartDate, @Param("findEndDate")String findEndDate);
	
	List<FileuploadVO> restStayImgList();
	
	Map<String, String> stayAllImg(String stayName, Model model);
	
	List<Map<String, String>> roomAllImg(String stayName, Model model);
	
}
