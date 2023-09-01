package com.gogo.service;

import java.io.File;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gogo.mapper.FileuploadMapper;
import com.gogo.vo.FileuploadVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Service
@Log4j
public class FileuploadServiceImpl extends FileuploadPath implements FileuploadService{
	
	@Autowired
	FileuploadMapper fileuploadMapper;
	
	private static final String ATTACHES_DIR = dirPath;
	
	public int fileupload(List<MultipartFile> files, String dir, FileuploadVO paramFileuploadVO) {
		int insertRes = 0;
		System.out.println("fileupload 입장");
		for(MultipartFile file : files) {
			System.out.println("fileupload for 입장");
			log.info("getoriname : " + file.getOriginalFilename());
			
			try {
				System.out.println("dir : " + dir);
				UUID uuid = UUID.randomUUID();
				String saveFileName = uuid + "_" + file.getOriginalFilename();
				File sFile = new File(ATTACHES_DIR + getFolder(dir) + saveFileName);

				// file 을  sFile에 저장
				file.transferTo(sFile);
				
				FileuploadVO vo = new FileuploadVO();
				
				// 주어진 파일의 Mime유형
				String contentType =
						Files.probeContentType(sFile.toPath());
				
				// 이미지가 아니면 리턴 0
				if(contentType == null && !contentType.startsWith("image")) {
					System.out.println("이미지 아님");
					return 0;
				}
				
				// 썸네일 생성 경로
				String thmbnail = ATTACHES_DIR + getFolder(dir) + "s_" + saveFileName;
				// 썸네일 생성
				// 원본파일, 크기, 저장될 경로
				Thumbnails.of(sFile).size(200, 200).toFile(thmbnail);
				
				System.out.println("sfile : " + sFile);
				vo.setFileName(file.getOriginalFilename());
				vo.setUuid(uuid.toString());
				vo.setUploadPath(getFolder(dir));
				vo.setStayNo(paramFileuploadVO.getStayNo());
				vo.setRoomNo(paramFileuploadVO.getRoomNo());
				vo.setMemberId(paramFileuploadVO.getMemberId());
				
				insertRes += fileuploadMapper.insert(vo);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return insertRes;
	}
	
	// stay 등록 시 mainPic을 저장하기 위해 첫 번째 사진 savePath를 반환해주는 메소드
	public String fileuploadMainPic(List<MultipartFile> files, String dir, FileuploadVO paramFileuploadVO) {
		int insertRes = 0;
		String mainPic = "";
		System.out.println("fileupload 입장");
		for(int i=0; i<files.size(); i++) {
			System.out.println("fileupload for 입장");
			log.info("getoriname : " + files.get(i).getOriginalFilename());
			
			try {
				System.out.println("dir : " + dir);
				UUID uuid = UUID.randomUUID();
				String saveFileName = uuid + "_" + files.get(i).getOriginalFilename();
				File sFile = new File(ATTACHES_DIR + getFolder(dir) + saveFileName);
				if(i == 0) {
					mainPic = getFolder(dir) + saveFileName;
				}
				// file 을  sFile에 저장
				files.get(i).transferTo(sFile);
				
				FileuploadVO vo = new FileuploadVO();
				
				// 주어진 파일의 Mime유형
				String contentType =
						Files.probeContentType(sFile.toPath());
				
				// 이미지가 아니면 리턴 0
				if(contentType == null && !contentType.startsWith("image")) {
					System.out.println("이미지 아님");
					return "";
				}
				
				// 썸네일 생성 경로
				String thmbnail = ATTACHES_DIR + getFolder(dir) + "s_" + saveFileName;
				// 썸네일 생성
				// 원본파일, 크기, 저장될 경로
				Thumbnails.of(sFile).size(200, 200).toFile(thmbnail);
				
				System.out.println("sfile : " + sFile);
				vo.setFileName(files.get(i).getOriginalFilename());
				vo.setUuid(uuid.toString());
				vo.setUploadPath(getFolder(dir));
				vo.setStayNo(paramFileuploadVO.getStayNo());
				vo.setRoomNo(paramFileuploadVO.getRoomNo());
				vo.setMemberId(paramFileuploadVO.getMemberId());
				
				insertRes += fileuploadMapper.insert(vo);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return mainPic;
	}
	
	// 중복 방지용 
	// 		업로드 날짜를 폴더 이름으로 사용
	//		2023/07/18
	public String getFolder(String dir) {
		LocalDate currentDate = LocalDate.now();	                       
		String uploadPath = dir + currentDate.toString().replace("-", File.separator) + File.separator;
															/// 마지막 구분자를 넣어주지 않으면 경로로 인식하지 못하고, 마지막 일(day)이 파일명으로 등록 됨
		System.out.println("겟 폴더 입장!!!!!!!!!!!!!!!!!!!!");
		log.info("currentDate : " + currentDate);
		log.info("경로 : " + uploadPath);
		
		// 폴더 생성(없으면)
		File saveDir = new File(ATTACHES_DIR + uploadPath);
		System.out.println("fileuploadImpl getFolder saveDir : " + saveDir);
		if(!saveDir.exists()) {
			if(saveDir.mkdirs()) {
				log.info("폴더 생성!!!");
			}else {
				log.info("폴더 생성 실패!!");
			}
		}
		return uploadPath;
	}
	
	@Override
	public int deleteStayPhoto(FileuploadVO vo) {
		int res = 0;
		// 삭제할 파일 처리
		String savePath = vo.getSavePath();
		String s_savePath = vo.getS_savePath();
		System.out.println("s_savePath : "+ s_savePath);
		
		if(savePath != null && !savePath.equals("")) {
			File file = new File(ATTACHES_DIR + savePath);
			
			if(file.exists()) {
				if(!file.delete()){
					System.err.println("Path : " + savePath);
					System.err.println("파일 삭제 실패!");
					return 0;
				}else{
					res++;
				};
			}
		}
		
		if(s_savePath != null && !s_savePath.equals("")) {
			System.out.println("썸네일 삭제");
			File file = new File(ATTACHES_DIR + s_savePath);
			
			if(file.exists()) {
				if(!file.delete()){
					System.err.println("Path : " + s_savePath);
					System.err.println("파일 삭제 실패!");
					return 0;
				}else {
					res++;
				}
			}
		}
	
		return res;
	}
	
	
	
}
