package com.gogo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gogo.service.StayService;
import com.gogo.vo.FileuploadVO;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/stst/*")
public class RestStayController {
	
	@Autowired
	StayService stayService;
	
	@PostMapping("keyword")
	public Map<String, Object> keywordList(@RequestBody StayVO vo, Model model, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<StayVO> list = stayService.stayKeywordList(vo, model);
		System.out.println(list);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		if(id != null) {
			vo.setMemberId(id);
		}else {
			vo.setMemberId("");
		}
		List<StayVO> likeList = stayService.likeIdRest(vo);
		List<FileuploadVO> imgList = stayService.restStayImgList();
		
		map.put("likeList", likeList);
		map.put("list", list);
		map.put("imgList", imgList);
		return map;
	}
	
	@GetMapping("category/{encodedCategoryName}")
	public Map<String, Object> categoryList(@PathVariable("encodedCategoryName") String encodedCategoryName, Model model, HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		StayVO vo = new StayVO();
		vo.setCategory(encodedCategoryName);
		List<StayVO> list = stayService.stayKeywordList(vo, model);
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		System.out.println(id);
		if(id != null) {
			vo.setMemberId(id);
		}else {
			vo.setMemberId("");
		}
		List<StayVO> likeList = stayService.likeIdRest(vo);
		List<FileuploadVO> imgList = stayService.restStayImgList();
		
		map.put("imgList", imgList);
		map.put("likeList", likeList);
		map.put("list", list);
		return map;
	}
	
	@PostMapping("insertLike")
	public Map<String, Object> insertLike(@RequestBody StayVO vo, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		int res = stayService.insertLike(vo);
		map.put("value", '1');
		return map;
	}
	
	@PostMapping("deleteLike")
	public Map<String, Object> deleteLike(@RequestBody StayVO vo, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		int res = stayService.deleteLike(vo);
		return map;
	}
	
	@GetMapping("/matjip/{encodedPromotion}/{mapx}/{mapy}")
    public Map<String, Object> searchKakao(@PathVariable("encodedPromotion") String encodedPromotion, @PathVariable("mapx") double mapx, @PathVariable("mapy") double mapy) {
        Map<String, Object> map = new HashMap<String, Object>();
    	
        String kakaoRestApiKey = "9d5258d378cbe587f835e4711d24dcb5";
		 
        String text = null;
        try {
            text = URLEncoder.encode(encodedPromotion, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }
        log.info(text);
        
        String apiURL = "https://dapi.kakao.com/v2/local/search/keyword.json?page=1&size=15&sort=accuracy&query="+text+"&x="+mapx+"&y="+mapy+"&radius=20000";

        log.info(apiURL);
        Map<String, String> requestHeaders = new HashMap<String, String>();
        requestHeaders.put("Authorization", "KakaoAK 9d5258d378cbe587f835e4711d24dcb5");
        String responseBody = get(apiURL,requestHeaders);
        
        log.info(responseBody);
        
        map.put("rs", responseBody);
        return map;
    	
    }
	
	@GetMapping("/room/{stayName}/{findStartDate}/{findEndDate}")
	public Map<String, Object> roomListDate(@PathVariable("stayName") String stayName, @PathVariable("findStartDate") String findStartDate, @PathVariable("findEndDate") String findEndDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Map<String, String>> roomList = stayService.stayRoomListDate(stayName, findStartDate, findEndDate);
		List<Map<String, String>> roomImg = stayService.stayRoomImgDate(stayName, findStartDate, findEndDate);
		
		map.put("roomList", roomList);
		map.put("roomImg", roomImg);
		return map;
	}
	
	
	
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
