package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.QAdvertisement;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.UsersRepository;

@Service
@Transactional
@EnableScheduling
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminRepository adminRep;
	@Autowired
	private GatherRepository gatherRepository;
	@Autowired
	private UsersRepository usersRepository;

	@Autowired
	private JPAQueryFactory queryFactory;
	
	QAdvertisement ad = QAdvertisement.advertisement;
	
	/**
	 * 광고 종료 스케줄러 
	 * */
	@Override
	@Scheduled(cron = "0 * * * * *")
	public void AutoAdvertisementUpdate() {
		List<Advertisement> advertisementList = queryFactory.selectFrom(ad).where(ad.adStatus.eq("광고중")).fetch();
		
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime ldt = LocalDateTime.of(now.getYear(), now.getMonth(), now.getDayOfMonth(), now.getHour(),now.getMinute());
		
		for(Advertisement advertisement : advertisementList) {
			System.out.println("adNo = " + advertisement.getAdvertisementNo()+"/"+advertisement.getDeadLine().isEqual(ldt));
			
			if(advertisement.getDeadLine().isEqual(ldt)) {
				advertisement.setAdStatus("광고종료");
			}
		}
	}
	
	/**
	 * 모임 조회
	 * */
	@Override
	public List<Gather> selectGatherList() {

		return gatherRepository.findAll();
	}

	/**
	 * 회원 조회
	 * */
	@Override
	public List<Users> selectUsersList() {

		return usersRepository.findAll();
	}

	/**
	 * 광고 조회
	 * */
	@Override
	public List<Advertisement> selectAll() {
		return adminRep.findAll();
	}

	/**
	 * 모임 페이징
	 * */
	@Override
	public Page<Gather> selectGatherList(Pageable pageable) {
		// TODO Auto-generated method stub
		return gatherRepository.findAll(pageable);
	}

	/**
	 * 회원 페이징
	 * */
	@Override
	public Page<Users> selectUsersList(Pageable pageable) {
		// TODO Auto-generated method stub
		return usersRepository.findAll(pageable);
	}

	/**
	 * 광고 페이징
	 * */
	@Override
	public Page<Advertisement> selectAll(Pageable pageable) {

		return adminRep.findAll(pageable);
	}

	/**
	 * 광고 등록
	 * */
	@Override
	public Advertisement advertisementInsert(Advertisement advertisement) {

		Advertisement resultAdvertisement = adminRep.save(advertisement);
		return resultAdvertisement;

	}

	/**
	 * 광고 상태 변경 
	 * */
	@Override
	public void statusUpdate(Advertisement advertisement) {
		Advertisement statusUpdate = adminRep.findById(advertisement.getAdvertisementNo()).orElse(advertisement);
	
		statusUpdate.setAdStatus(advertisement.getAdStatus());

	}

	/**
	 * 광고 수정
	 * */
	@Override
	public void updateAdvertisement(Advertisement advertisement) {			
		if(advertisement.getAdStatus().equals("광고중")) {
			delete(advertisement);
		}
		adminRep.save(advertisement);
	
	}

	/**
	 * 광고중 광고 삭제하기
	 * */
	@Override
	public void delete(Advertisement advertisement) {
		queryFactory.delete(ad)
		.where(ad.gather.gatherNo.eq(advertisement.getGather().getGatherNo())
				.and(ad.adStatus.eq("광고중")))
		.execute();

	}

	@Override
	public List<Advertisement> selectByStatus1(Advertisement advertisement) {

		return adminRep.selectByStatus1(advertisement);
	}

	@Override
	public List<Advertisement> selectByStatus2(Advertisement advertisement) {
		// TODO Auto-generated method stub
		return adminRep.selectByStatus2(advertisement);
	}

	@Override
	public List<Advertisement> selectByStatus3(Advertisement advertisement) {
		// TODO Auto-generated method stub
		return adminRep.selectByStatus3(advertisement);
	}

	
	@Override
	public List<AdvertisementGroupBy> selectAdTotalPrice(Advertisement advertisement) {
		
		List<AdvertisementGroupBy> total = adminRep.selectAdTotalPrice();
		
		return total;
	}


	

	





}