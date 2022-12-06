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
import modakbul.mvc.repository.GatherRepository;

@SpringBootTest
@Transactional
@Commit
public class Test {
	
	Users users = new Users(2L);
	Gather gather = new Gather(10L);

	
	@Autowired
	private AdminRepository advertisementRep;
	
	@Autowired
	private GatherRepository gatherRepository;
	
	/**
	 * 광고 등록
	 * */
	@org.junit.jupiter.api.Test
	void advertisementInsert() {

		LocalDateTime date = LocalDateTime.now();
	
		
		Advertisement advertisement = new Advertisement(1L,users,gather,"광고종료",date,null,null,"test7.jpg");
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
	
	/**
	 * 광고 상태 검색 
	 * */
	@org.junit.jupiter.api.Test
	public void selectByStatus2() {
		List<Advertisement> list = advertisementRep.selectByStatus2(null);
		/*for(Advertisement b :list) {
			System.out.println(b);
		}*/
		list.forEach(b->System.out.println(b));
	}
	
	/**
	 * 12월 광고중 검색 
	 * */
	@org.junit.jupiter.api.Test
	public void selectAdStatusIng12() {
		List<Advertisement> list = advertisementRep.selectAdStatusIng12(null);
		/*for(Advertisement b :list) {
			System.out.println(b);
		}*/
		list.forEach(b->System.out.println(b));
	}
	
	/**
	 * 모임 참가비 조회1
	 * */
	@org.junit.jupiter.api.Test
	public void selectGatherBid1() {
		String selectGatherBid1 = advertisementRep.selectGatherBid1(null);
	
			System.out.println("selectGatherBid1 = "+selectGatherBid1);
	
	}
	
	/**
	 * 유료 광고중 모임 검색 
	 * */
	@org.junit.jupiter.api.Test
	public void selectAdGather() {
		List<Advertisement> list = advertisementRep.selectAdGather();
		/*for(Advertisement b :list) {
			System.out.println(b);
		}*/
		list.forEach(b->System.out.println(b));
	}
	
}
