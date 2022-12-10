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
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.UsersGroupBy;
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
	
	QGather qGather = QGather.gather;
	
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
	public void advertisementInsert(Advertisement advertisement) {

		adminRep.save(advertisement);

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
	
	/**
	 * 광고 상태 출력(광고중)
	 * */
	@Override
	public List<Advertisement> selectByStatus1() {
		List<Advertisement> advertisementList = queryFactory.selectFrom(ad).where(ad.adStatus.eq("광고중")).fetch();
		return advertisementList;
	}
	@Override
	public Page<Advertisement> selectByStatus1(Pageable pageable) {
		return null;
	}

	
	/**
	 * 광고 상태 출력(신청대기)
	 * */
	@Override
	public List<Advertisement> selectByStatus2(Advertisement advertisement) {
		return adminRep.selectByStatus2(advertisement);
	}
	@Override
	public Page<Advertisement> selectByStatus2(Pageable pageable) {
		return null;
	}
	
	/**
	 * 광고 상태 출력(광고 종료)
	 * */
	@Override
	public List<Advertisement> selectByStatus3(Advertisement advertisement) {
		return adminRep.selectByStatus3(advertisement);
	}
	@Override
	public Page<Advertisement> selectByStatus3(Pageable pageable) {
		return null;
	}

	/**
	 * 광고 매출 차트
	 * */
	@Override
	public List<AdvertisementGroupBy> selectAdTotalPrice(Advertisement advertisement) {
		
		List<AdvertisementGroupBy> total = adminRep.selectAdTotalPrice();
		
		return total;
	}
	
	/**
	 * 월별 회원수 증가 차트
	 * */
	@Override
	public List<UsersGroupBy> selectMonthCountUser(Users users) {
		
		List<UsersGroupBy> totalUser = usersRepository.selectMonthCountUser();
		return totalUser;
	}
	
	/**
	 * 카테고리별 모임 개수
	 * */
	@Override
	public List<GatherGroupBy> selectCategoryCount(Gather gather) {
		
		List<GatherGroupBy> categoryCount = adminRep.selectCategoryCount();
		
		return categoryCount;
	}

	/**
	 * 광고 업로드 폼
	 * */
	@Override
	public void save(Advertisement files) {
		Advertisement f = new Advertisement();
		f.setAdFileName(files.getAdFileName());
		
		adminRep.save(f);
	}
	
	/**
	 * 유료모임 신청 승인 업데이트 
	 * */
	@Override
	public void updateGather(Gather gather) {
			queryFactory.update(qGather).set(qGather.gatherState, "모집중").where(qGather.gatherNo.eq(gather.getGatherNo())
					.and(qGather.gatherState.eq("신청대기"))).execute();

		
	}
	
	/**
	 * 유료모임 신청 리스트
	 * */
	@Override
	public List<Gather> selectGatherState() {
		List<Gather> gatherList = queryFactory.selectFrom(qGather).where(qGather.gatherState.eq("신청대기")).fetch();
		
		return gatherList;
	}








		
	
}


	