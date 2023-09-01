package com.gogo.mapper;

import java.util.List;

import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

public interface FileuploadMapper {

	public int insert(FileuploadVO vo);
	
	public List<FileuploadVO> getStayPhotoList(StayVO vo);
	
	public int updateStayPhoto(FileuploadVO vo);

	public int deleteStayPhoto(FileuploadVO vo);

	public List<FileuploadVO> getRoomPhotoList(RoomVO vo);
	
	public int deleteRoomPhoto(FileuploadVO vo);
}
