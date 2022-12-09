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
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.UsersRepository;
import modakbul.mvc.service.AdminService;

@SpringBootTest
@Transactional
@Commit
public class Test {

	Gather gather = new Gather(7L);

	Users userTest = new Users().builder().userNo(2L).build();
	
	@Autowired
	private AdminService adminService;
	@Autowired
	private AdminRepository advertisementRep;
	
	@Autowired
	private GatherRepository gatherRepository;
	
	@Autowired
	private UsersRepository users;
	
	
	/**
	 * 스케줄러
	 * */
	void AutoAdvertisementUpdate() {
		
	}
	
	/**
	 * 광고 등록
	 * */
	@org.junit.jupiter.api.Test
	void advertisementInsert() {

		LocalDateTime date = LocalDateTime.now();
		LocalDateTime deadLine = LocalDateTime.of(2022, 12, 6, 18, 15);
		
		Advertisement advertisement = new Advertisement(141L,userTest,gather,"광고중",date,null,deadLine,"test7.jpg",50000);
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
	 * 전체검색 selectUsersList
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
	 * 유저 전체검색 
	 * */
	@org.junit.jupiter.api.Test
	public void selectUsersList() {
		List<Users> list = adminService.selectUsersList();
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
	
	/**
	 * 광고 수정 
	 * */
	@org.junit.jupiter.api.Test
	public void UpdateAdvertisement() {
		LocalDateTime deadLine = LocalDateTime.of(2022, 12, 6, 14, 47);
		LocalDateTime approveDate = LocalDateTime.of(2022, 12, 6, 14, 49);
		LocalDateTime date = LocalDateTime.now();
		Advertisement ad = new Advertisement(78L , userTest , gather, "광고중", date, approveDate, deadLine, "test3",10000);
		adminService.updateAdvertisement(ad);
		
	}
	
	/**
	 * 월별 광고 매출 리스트
	 * */
	@org.junit.jupiter.api.Test
	public void selectAdTotalPrice() {

		List<AdvertisementGroupBy> test = adminService.selectAdTotalPrice(null);
		for(AdvertisementGroupBy t: test) {
			System.out.println(t.getMonth() + "월 / "+ t.getTotalPrice() +"원" + " / 개수: " + t.getAdCount());
		}
	}
	
	/**
	 * 광고 상태 변경
	 * */
	@org.junit.jupiter.api.Test
	void updateGathWer() {
			Gather gather = gatherRepository.findById(69L).orElse(null);
			adminService.updateGather(gather);
			
		}
}
