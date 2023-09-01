package com.gogo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gogo.mapper.StayMapper;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomPhotoVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class StayServiceImpl implements StayService{

	@Autowired
	StayMapper stayMapper;
	
	@Override
	public List<StayVO> stayList(Model model) {
		List<StayVO> list = stayMapper.stayList();
		
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
		return null;
	}

	@Override
	public Map<String, String> roomInfo(String stayName, Model model) {
		Map<String, String> roomInfo = stayMapper.roomInfo(stayName);
		log.info("===========");
		log.info("list : " + roomInfo);
		model.addAttribute("list", roomInfo);
		return null;
	}

	@Override
	public List<Map<String, String>> stayRoomList(String stayName, Model model) {
		List<Map<String, String>> stayRoomInfo = stayMapper.stayRoomList(stayName);
		log.info("===========");
		log.info("stayRoomInfo : " + stayRoomInfo);
		model.addAttribute("stayRoomInfo", stayRoomInfo);
		return null;
	}

	@Override
	public Map<String, String> roomInfoPageList(String stayName, String roomName, Model model) {
		Map<String, String> roomInfo = stayMapper.roomInfoPageList(stayName, roomName);
		log.info("===========");
		log.info("roomInfo : " + roomInfo);
		model.addAttribute("roomInfo", roomInfo);
		return null;
	}

	@Override
	public List<RoomPhotoVO> roomInfoPagePic(String stayName, String roomName, Model model) {
		List<RoomPhotoVO> picList = stayMapper.roomInfoPagePic(stayName, roomName);
		log.info("===========");
		log.info("picList : " + picList);
		model.addAttribute("picList", picList);
		return null;
	}


	@Override
	public List<StayVO> stayKeywordList(StayVO vo, Model model) {
		return stayMapper.stayKeywordList(vo);
	}

	@Override
	public int insertLike(StayVO vo) {
		return stayMapper.insertLike(vo);
	}

	@Override
	public List<StayVO> likeId(StayVO vo, Model model) {
		List<StayVO> likeList = stayMapper.likeId(vo);
		log.info("===========");
		log.info("likeList : " + likeList);
		model.addAttribute("likeList", likeList);
		return null;
	}

	@Override
	public int deleteLike(StayVO vo) {
		return stayMapper.deleteLike(vo);
	}

	@Override
	public List<FileuploadVO> stayRoomImg(String stayName, Model model) {
		List<FileuploadVO> stayRoomImg = stayMapper.stayRoomImg(stayName);
		log.info("===========");
		log.info("stayRoomImg : " + stayRoomImg);
		model.addAttribute("stayRoomImg", stayRoomImg);
		return null;
	}

	@Override
	public List<FileuploadVO> stayImgList(Model model) {
		List<FileuploadVO> stayImg = stayMapper.stayImgList();
		log.info("===========");
		log.info("stayImg : " + stayImg);
		model.addAttribute("stayImg", stayImg);
		return null;
	}

	@Override
	public void stayLocList(StayVO vo, Model model) {
		List<StayVO> list = stayMapper.stayLocList(vo);
		log.info("===========");
		log.info("list : " + list);
		model.addAttribute("list", list);
	}

	@Override
	public List<StayVO> likeIdRest(StayVO vo) {
		return stayMapper.likeIdRest(vo);
	}

	@Override
	public List<Map<String, String>> stayRoomListDate(String stayName, String findStartDate, String findEndDate) {
		return stayMapper.stayRoomListDate(stayName, findStartDate, findEndDate);
	}

	@Override
	public List<Map<String, String>> stayRoomImgDate(String stayName, String findStartDate, String findEndDate) {
		return stayMapper.stayRoomImgDate(stayName, findStartDate, findEndDate);
	}

	@Override
	public List<FileuploadVO> restStayImgList() {
		return stayMapper.stayImgList();
	}

	@Override
	public Map<String, String> stayAllImg(String stayName, Model model) {
		Map<String, String> stay = stayMapper.stayAllImg(stayName);
		model.addAttribute("stayImg", stay);
		return null;
	}

	@Override
	public List<Map<String, String>> roomAllImg(String stayName, Model model) {
		List<Map<String, String>> room = stayMapper.roomAllImg(stayName);
		model.addAttribute("roomImg", room);
		return null;
	}
}
