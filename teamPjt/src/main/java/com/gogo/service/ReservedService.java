package com.gogo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gogo.vo.ReservedVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

@Service
public interface ReservedService {
	
	public int insertReserved(ReservedVO vo);
	
	public RoomVO selectOne_room(String roomNo);
	
	public ReservedVO selectOne_reservation(String reservationNo);
	
	public StayVO selectOne_stay(String stayNo);

	public String reservedDay(String reservationNo);
	
	public String reservedDay2(@Param("checkIn") String checkIn, @Param("checkOut") String checkOut);
	
	public String getReservationNo();
	
	public String goReserved(ReservedVO reserved, Model model);
	
	public String comma(Object a);
	
	public List<String> getReservedList(String roomNo);
}
