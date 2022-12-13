package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQuery;
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
	 * *
	@Override
	public Page<Advertisement> selectAll(Pageable pageable) {

		return adminRep.findAll(pageable);
	}*/
	
	/**
	 * 광고 페이징
	 * */
	@Override
	public Page<Advertisement> selectAd(Pageable pageable, String adStatus) {
		
		BooleanBuilder builder = new BooleanBuilder();
		if(adStatus!=null) {
			builder.and(ad.adStatus.eq(adStatus));
		}
		List<Advertisement> list = queryFactory
				.select(ad)
				.from(ad)
				.where(builder)
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.orderBy(ad.advertisementNo.desc())
				.fetch();
		
		 JPAQuery<Advertisement> countQuery = queryFactory
		            .select(ad)
		            .from(ad)
		            .where(builder);
		 
		return PageableExecutionUtils.getPage(list, pageable, ()->countQuery.fetch().size());
	}
	/**
	 * 광고 등록
	 * */
	@Override
	public void advertisementInsert(Advertisement advertisement, Long gatherNo) {

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
		return adminRep.selectByStatus1();
	}

	/**
	 * 광고 상태 출력(신청대기)
	 * */
	@Override
	public List<Advertisement> selectByStatus2() {
		return adminRep.selectByStatus2();
	}
	
	/**
	 * 광고 상태 출력(광고 종료)
	 * */
	@Override
	public List<Advertisement> selectByStatus3() {
		return adminRep.selectByStatus3();
	}
	
	/**
	 * 광고 승인날짜 리스트
	 * */
	@Override
	public String selectApproveDate(Advertisement advertisement) {
		// TODO Auto-generated method stub
		return adminRep.selectApproveDate(advertisement);
	}

	/**
	 * 광고 데드라인 리스트
	 * */
	@Override
	public String selectDeadLine(Advertisement advertisement) {
		// TODO Auto-generated method stub
		return adminRep.selectDeadLine(advertisement);
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
	 * 광고 신청 승인 업데이트 
	 * */
	@Override
	public void updateAdGather(Long advertisementNo, String status) {
		LocalDateTime now = LocalDateTime.now();
		
			//queryFactory.update(ad).set(ad.adStatus, "광고중").set(ad.adApproveDate, date)
			//.where(ad.gather.gatherNo.eq(advertisement.getGather().getGatherNo()))
			//.where(ad.advertisementNo.eq(advertisement.getAdvertisementNo()))
			//.execute();
		Advertisement dbAdv = adminRep.findById(advertisementNo).orElse(null);
		dbAdv.setAdStatus(status);
		dbAdv.setAdApproveDate(now);
	}
	
	/**
	 * 광고 종료하기
	 * */
	@Override
	public void updateAdCancle(Long advertisementNo, String status) {
		LocalDateTime now = LocalDateTime.now();
		
		Advertisement dbAdv = adminRep.findById(advertisementNo).orElse(null);
		dbAdv.setAdStatus(status);
		dbAdv.setDeadLine(now);
		
	}
	
	/**
	 * 유료모임 신청 리스트
	 * */
	@Override
	public List<Gather> selectGatherState() {
		List<Gather> gatherList = queryFactory.selectFrom(qGather).where(qGather.gatherState.eq("신청대기")).fetch();
		
		return gatherList;
	}
	
	/**
	 * 유료광고 모임 뿌리기
	 * */
	@Override
	public List<Advertisement> selectAdGather() {
		List<Advertisement> gatherList = queryFactory.selectFrom(ad)
				.where(ad.gather.gatherState.eq("모집중").and(ad.adStatus.eq("광고중")))
				.fetch();
				
		return gatherList;
	}
	
	/**
	 * 마이페이지에서 신청대기 리스트
	 */
	@Override
	public Page<Advertisement> selectADGatherRegis(Long userNo, Pageable pageable, Long advertisementNo) {
		QueryResults<Advertisement> selectADGatherRegis = queryFactory.select(ad)
				.from(ad).join(qGather).on(ad.gather.gatherNo.eq(qGather.gatherNo))
				.where(ad.adStatus.eq("신청대기")
				//.where(qGather.gatherState.eq("신청대기")
				.and(ad.user.userNo.eq(userNo)))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize()).fetchResults();
		
		return new PageImpl<Advertisement>(selectADGatherRegis.getResults(), pageable, selectADGatherRegis.getTotal());
	}
	
	/**
	 * 마이페이지에서 광고중 리스트
	 */
	@Override
	public Page<Advertisement> selectGatherADIng(Long userNo, Pageable pageable, Long advertisementNo) {

		QueryResults<Advertisement> selectADGatherRegis = queryFactory.select(ad)
				.from(ad).join(qGather).on(ad.gather.gatherNo.eq(qGather.gatherNo))
				.where(ad.adStatus.eq("광고중")
				//.where(qGather.gatherState.eq("신청대기")
				.and(ad.user.userNo.eq(userNo)))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize()).fetchResults();
		
		return new PageImpl<Advertisement>(selectADGatherRegis.getResults(), pageable, selectADGatherRegis.getTotal());
	}

	
	/**
	 * 광고 신청 취소하기
	 * */
	@Override
	public void updateMyAdCancel(Long advertisementNo) {
		//Advertisement dbAdv = //adminRep.findById(advertisementNo).orElse(null);
		/*
		 * queryFactory.delete(ad).where(ad.gather.gatherNo.eq(advertisement.getGather()
		 * .getGatherNo()) .and(ad.adStatus.eq("신청대기"))) .execute();
		 */
		adminRep.deleteById(advertisementNo);

				
				
		//dbAdv.setAdStatus(status);
		
		
		
	}
	
	/**
	 * 진행중 광고 종료하기
	 * */
	@Override
	public void updateMyAdCancel(Long advertisementNo, String status) {
		LocalDateTime now = LocalDateTime.now();
		
		Advertisement dbAdv = adminRep.findById(advertisementNo).orElse(null);
		dbAdv.setAdStatus(status);
		dbAdv.setDeadLine(now);
	}

	@Override
	public void updateBanner(Long advertisementNo, String bannerName) {
		Advertisement ad = this.selectByNo(advertisementNo);
		ad.setAdFileName(bannerName);
		
	}
	
	@Override
	public Advertisement selectByNo(Long advertisementNo) {
		
		return adminRep.selectByNo(advertisementNo);
	}

	


	








		
	
}


	