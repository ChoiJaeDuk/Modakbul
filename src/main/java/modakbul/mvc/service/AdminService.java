package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.UsersGroupBy;

public interface AdminService {

	/**
	 * 광고 종료 스케줄러 
	 * */
	void AutoAdvertisementUpdate();
	
	/**
	 * 광고 등록
	 * */
	void advertisementInsert(Advertisement advertisement, Long gatherNo);

	/**
	 * 광고 수정하기
	 * */
	void updateAdvertisement(Advertisement advertisement);

	/**
	 * 광고 상태 변경
	 * */
	void statusUpdate(Advertisement advertisement);

	/**
	 * 광고 상태 출력(광고중)
	 * */
	List<Advertisement> selectByStatus1();
	/**
	 * 광고 상태 출력(신청대기)
	 * */
	List<Advertisement> selectByStatus2();
	/**
	 * 광고 상태 출력(광고 종료)
	 * */
	List<Advertisement> selectByStatus3();
	
	/**
	 * 광고 승인날짜 리스트
	 * */
	String selectApproveDate(Advertisement advertisement);
	
	/**
	 * 광고 데드라인 리스트
	 * */
	String selectDeadLine(Advertisement advertisement);
	
	/**
	 * 삭제하기
	 * */
	void delete(Advertisement advertisement);

	/**
	 * 모임 조회
	 * */
	List<Gather> selectGatherList();

	/**
	 * 회원 조회
	 * */
	List<Users> selectUsersList();

	/**
	 * 광고 조회
	 * */
	List<Advertisement> selectAll();

	/**
	 * 모임 조회 - Page처리
	 * */
	Page<Gather> selectGatherList(Pageable pageable);

	/**
	 * 회원 조회 - Page처리
	 * */
	Page<Users> selectUsersList(Pageable pageable);

	/**
	 * 광고 조회 - Page처리
	 * */
	Page<Advertisement> selectAd(Pageable pageable, String adStatus);

	/**
	 * 광고 매출 차트
	 * */
	List<AdvertisementGroupBy> selectAdTotalPrice(Advertisement advertisement);
	
	/**
	 * 월별 회원수 증가 차트
	 * */
	List<UsersGroupBy> selectMonthCountUser(Users users);
	
	/**
	 * 카테고리별 모임 개수
	 * */
	List<GatherGroupBy> selectCategoryCount(Gather gather);
	
	/**
	 * 광고 파일 등록
	 * */
	void save(Advertisement files);
	
	/**
	 * 광고 승인
	 * */
	void updateAdGather(Long advertisementNo, String status);
	
	/**
	 * 광고 종료하기
	 * */
	void updateAdCancle(Long advertisementNo, String status);
	
	/**
	 * 모임 신청대기 리스트
	 * */
	List<Gather> selectGatherState();
	
	/**
	 * 유료광고 모임 뿌리기
	 * */
	List<Advertisement> selectAdGather();
	
	/**
	 * 마이페이지에서 광고신청 대기 리스트
	 */
	Page<Advertisement> selectADGatherRegis(Long userNo, Pageable pageable, Long advertisementNo);
	
	/**
	 * 마이페이지에서 광고중 리스트
	 */
	Page<Advertisement> selectGatherADIng(Long userNo, Pageable pageable, Long advertisementNo);
	
	/**
	 * 광고 신청 취소하기
	 * */
	void updateMyAdCancel(Long advertisementNo);
	
	/**
	 * 광고 종료하기
	 * */
	void updateMyAdCancel(Long advertisementNo, String status);
	
	/**
	 * 광고 배너 변경
	 * */
}