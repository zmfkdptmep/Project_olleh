package MainMapperTest;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gogo.mapper.MainMapper;
import com.gogo.test.MapperTest;
import com.gogo.vo.StayVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StayMapperTest {

	@Autowired
	MainMapper mainMapper;
	
	@Test
	public void test() {
		assertNotNull(mainMapper);
		
	}
	
	@Test
	public void insert() {
		StayVO stayVO = new StayVO();
		stayVO.setBadge("뱃지");
//		stayVO.setLatitude(1234);
//		stayVO.setLongitude(12345);
		stayVO.setMainPic1("pic1");
		stayVO.setMainPic2("pic2");
		stayVO.setMemberId("user1");
		stayVO.setStayAdress("address");
		stayVO.setStayInfo("info");
		stayVO.setStayLoc("loc");
		stayVO.setStayName("짱");
		stayVO.setStayType("내타입");
		
		mainMapper.insert(stayVO);
	}
	
}
