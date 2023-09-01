package com.gogo.mapper;

import java.util.List;

import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomOptionVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

public interface MainMapper {
	
	public int insert(StayVO vo);
	
	public int insertRoom(RoomVO vo);
	
	public int insertRoomOption(RoomOptionVO vo);
	
	public int insertPhoto(FileuploadVO vo);
	
	public int insertStay(StayVO vo);
	
	public StayVO getStayOne(StayVO vo);
	
	public int updateStay(StayVO vo);
	
	//
	public int updateStayMainPic(StayVO vo);
	
	public RoomVO getRoomOne(RoomVO vo);

	public RoomOptionVO getRoomOption(RoomVO vo);

	public int updateRoom(RoomVO vo);

	public int updateRoomOption(RoomOptionVO optionVO);
	
	public int deleteRoomPhoto(RoomVO vo);

	public List<StayVO> getMainList();

	public String getStayNo(String memberId);
	
	public List<StayVO> getPopStayList();
	
}
