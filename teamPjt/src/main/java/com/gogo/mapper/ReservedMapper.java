package com.gogo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

public interface ReservedMapper {
	
	
	public int insertReserved(ReservedVO vo); 
	
	public RoomVO selectOne_room(String roomNo);
	
	public ReservedVO selectOne_reservation(String reservationNo);
	
	public StayVO selectOne_stay(String stayNo);
	
	public String reservedDay(String reservationNo);
	
	public String reservedDay2(@Param("checkIn") String checkIn, @Param("checkOut") String checkOut);
	
	public String getReservationNo();
	
	public List<String> getReservedList(String roomNo);
	
}
