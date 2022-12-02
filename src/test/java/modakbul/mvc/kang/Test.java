package modakbul.mvc.kang;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.AdminRepository;

@SpringBootTest
@Transactional
@Commit
public class Test {
	
	Users users = new Users(1L);
	Gather gather = new Gather(5L);

	
	@Autowired
	private AdminRepository advertisementRep;
	
	/**
	 * 광고 등록
	 * */
	@org.junit.jupiter.api.Test
	void advertisementInsert() {

		LocalDateTime date = LocalDateTime.now();
	
		
		Advertisement advertisement = new Advertisement(2L,users,gather,"신청대기",date,null,null,"test6.jpg");
		advertisementRep.save(advertisement);

	}
	
	/**
	 * 광고 상태 변경
	 * */
	@org.junit.jupiter.api.Test
	void statusUpdate() {
			Advertisement advertisement = advertisementRep.findById(5L).orElse(null);
			
			advertisement.setAdStatus("광고중");
			
		}
	
	/**
	 * 광고 배너 변경
	 * */
	@org.junit.jupiter.api.Test
	void bannerUpdate() {
			Advertisement advertisement = advertisementRep.findById(5L).orElse(null);
			
			advertisement.setAdFileName("test10.jpg");
			
		}
	
	/**
	 * 광고 삭제 
	 * */
	@org.junit.jupiter.api.Test
	public void delete() {
		advertisementRep.deleteById(4L);
	}
	
	/**
	 * 전체검색 
	 * */
	@org.junit.jupiter.api.Test
	public void selectAll() {
		List<Advertisement> list = advertisementRep.findAll();
		/*for(Advertisement b :list) {
			System.out.println(b);
		}*/
		list.forEach(b->System.out.println(b));
	}
	
}
