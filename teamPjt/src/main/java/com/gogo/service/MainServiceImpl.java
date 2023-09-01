package com.gogo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.mapper.FileuploadMapper;
import com.gogo.mapper.MainMapper;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.RoomOptionVO;
import com.gogo.vo.RoomVO;
import com.gogo.vo.StayVO;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	MainMapper mainMapper;
	
	@Autowired
	FileuploadService fileuploadService;
	
	@Autowired
	FileuploadMapper fileuploadMapper;
	
	@Override
	public int insert(StayVO vo) {
		
		return mainMapper.insert(vo);
	}

	@Override
	@Transactional
	public int insertRoom(RoomVO vo, RoomOptionVO optionVO,
					List<MultipartFile> files, String stayNo) {
		
		int res = mainMapper.insertRoom(vo);
		System.out.println(vo.getRoomNo());
		if(res>0) {
			optionVO.setRoomNo(vo.getRoomNo());
			res = mainMapper.insertRoomOption(optionVO);
		}
		if(res>0) {
			FileuploadVO fileuploadVO = new FileuploadVO();
			fileuploadVO.setRoomNo(vo.getRoomNo());
			fileuploadVO.setStayNo(stayNo);
			fileuploadVO.setMemberId("");
			String dir = "room\\";
			res = fileuploadService.fileupload(files, dir, fileuploadVO);
		}
		return res;
	}

	@Override
	@Transactional
	public int insertStay(StayVO vo, List<MultipartFile> files) {
		
		int res = mainMapper.insertStay(vo);
		System.out.println(vo.getStayNo());
		System.out.println("insertStay res : " + res);
		
		String mainPic = "";
		if (res > 0) {
			FileuploadVO fileuploadVO = new FileuploadVO();
			fileuploadVO.setStayNo(vo.getStayNo());
			fileuploadVO.setRoomNo("");
			fileuploadVO.setMemberId("");
			String dir = "stay\\";
			mainPic = fileuploadService.fileuploadMainPic(files, dir, fileuploadVO);
			System.out.println("mainservice insertstay res : " + res);

			vo.setMainPic1(mainPic);
			res = mainMapper.updateStayMainPic(vo);
		}
		return res;
	}
//	public int insertStay(StayVO vo, List<MultipartFile> files) {
//		
//		
//		  int res = mainMapper.insertStay(vo); 
//		  System.out.println(vo.getStayNo());
//		  System.out.println("insertStay res : " + res);
// 
//		  if(res>0) { 
//			  FileuploadVO fileuploadVO = new FileuploadVO();
//			  fileuploadVO.setStayNo(vo.getStayNo());
//			  fileuploadVO.setRoomNo("");
//			  fileuploadVO.setMemberId("");
//			  String dir = "stay\\";
//			  res = fileuploadService.fileupload(files, dir, fileuploadVO);
//			  System.out.println("mainservice insertstay res : " + res);
//		  }
//		 
//		  return res;
//	}

	// stay 정보 불러오기
	public void getStay(StayVO vo, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stayVO", mainMapper.getStayOne(vo));
		map.put("listPhoto", fileuploadMapper.getStayPhotoList(vo));
		
		model.addAttribute("map", map);
	}

	@Override
	@Transactional
	public int updateStay(StayVO vo, List<MultipartFile> files) {
		System.out.println(vo);
		// StayVO 정보 수정(사진 제외)
		int res = mainMapper.updateStay(vo);
		int deleteRes = 0;
		String mainPic = "";
		System.out.println("================" + files.size());
		if(files.size() > 1 && res > 0) {
			// 로컬에서 사진 삭제
			List<FileuploadVO> listPhoto = fileuploadMapper.getStayPhotoList(vo);
			for(FileuploadVO photo : listPhoto) {
				deleteRes += fileuploadService.deleteStayPhoto(photo);
			}
			System.out.println("deleteRes : " + deleteRes);
			
			FileuploadVO fileuploadVO = new FileuploadVO();
			
			fileuploadVO.setStayNo(vo.getStayNo());
			// db 에서 사진 삭제
			res = fileuploadMapper.deleteStayPhoto(fileuploadVO);
			
			if(res>0) {
				fileuploadVO.setRoomNo("");
				fileuploadVO.setMemberId("");
				String dir = "stay\\";
				
				// 수정된 사진 업로드
				mainPic = fileuploadService.fileuploadMainPic(files, dir, fileuploadVO);
				
				vo.setMainPic1(mainPic);
				res = mainMapper.updateStayMainPic(vo);
			}
		}
		return res;
	}

	@Override
	public void getRoom(RoomVO vo, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomVO", mainMapper.getRoomOne(vo));
		map.put("roomOption", mainMapper.getRoomOption(vo));
		map.put("listPhoto", fileuploadMapper.getRoomPhotoList(vo));
		model.addAttribute("map", map);
	}

	@Override
	@Transactional
	public int updateRoom(RoomVO vo, RoomOptionVO optionVO, List<MultipartFile> files) {
		int res = 0;
		res = mainMapper.updateRoom(vo);
		if(res>0) {
			res = mainMapper.updateRoomOption(optionVO);
			if(res>0) {
				int deleteRes = 0;
				if(files.size() > 1 && res > 0) {
					// 로컬에서 사진 삭제
					List<FileuploadVO> listPhoto = fileuploadMapper.getRoomPhotoList(vo);
					for(FileuploadVO photo : listPhoto) {
						deleteRes += fileuploadService.deleteStayPhoto(photo);
					}
					System.out.println("deleteRes : " + deleteRes);
					
					FileuploadVO fileuploadVO = new FileuploadVO();
					
					fileuploadVO.setRoomNo(vo.getRoomNo());
					// db 에서 사진 삭제
					res = fileuploadMapper.deleteRoomPhoto(fileuploadVO);
					
					if(res>0) {
						fileuploadVO.setStayNo(vo.getStayNo());
						fileuploadVO.setMemberId("");
						String dir = "room\\";
						
						// 수정된 사진 업로드
						res = fileuploadService.fileupload(files, dir, fileuploadVO);
					}
				}
			}
		}
		return res;
	}

	@Override
	public void getMainList(Model model) {
		List<StayVO> listStay = mainMapper.getMainList();
		model.addAttribute("listStay", listStay);
	}

	@Override
	public String getStayNo(String memberId, Model model) {
		String stayNo = mainMapper.getStayNo(memberId);
		model.addAttribute("stayNo", stayNo);
		
		return stayNo;
	}

	@Override
	public void getPopStayList(Model model) {
		List<StayVO> listPopStay = mainMapper.getPopStayList();
		model.addAttribute("listPopStay", listPopStay);
	}
	
//	@Override
//	public int roomFileupload(List<MultipartFile> files, FileuploadVO vo) {
//		
//		String dir = "room\\";
//		int res = fileuploadService.fileupload(files, dir, vo);
//		
//		return res;
//	}
//	
//	@Override
//	public int stayFileupload(List<MultipartFile> files, FileuploadVO vo) {
//		//System.out.println("stayFileupload 입장!!!!!");
//		String dir = "stay\\";
//		int res = fileuploadService.fileupload(files, dir, vo);
//		
//		return res;
//	}
	


}
