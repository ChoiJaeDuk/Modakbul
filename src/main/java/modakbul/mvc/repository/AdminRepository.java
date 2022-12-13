package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.groupby.AdvertisementGroupBy;
import modakbul.mvc.groupby.GatherGroupBy;

public interface AdminRepository extends JpaRepository<Advertisement, Long>, QuerydslPredicateExecutor<Advertisement> {
	
	/**
	 * 유료모임 신청대기 리스트
	 * */
	@Query(value = "select * from gather left join regular_gather on gather.regular_gather_no = regular_gather.regular_gather_no where gather_state = '신청대기' or regular_gather.regular_gather_state = '신청대기' ORDER by gather_no asc", nativeQuery = true)
	List<Gather> selectGatherState();
	/**
	 * 유료모임 신청 승인
	 * */
	@Query(value = "UPDATE gather g SET g.gather_state = '모집중' WHERE g.gather_no = ?1", nativeQuery = true)
	@Modifying
	void updateGather(Long gatherNo);
	/**
	 * 유료광고중인 모임 추천 모임에 뿌리기
	 * */
	
	@Query(value = "select * from gather left join advertisement on advertisement.gather_no = gather.gather_no where ad_status = '광고중' and gather.gather_state = '모집중' ORDER by advertisement.gather_no asc", nativeQuery = true)
	List<Gather> selectAdGather();
	
	
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '광고중'",nativeQuery = true)
	List<Advertisement> selectByStatus1();
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '신청대기'",nativeQuery = true)
	List<Advertisement> selectByStatus2();
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectByStatus3();
	
	/**
	 * 1월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-01' and ad_status in('광고중','광고종료')",nativeQuery = true)
	List<Advertisement> selectAdStatusIng1(Advertisement advertisement);
	
	/**
	 * 모임 참가비 조회1
	 * */
	@Query(value ="select sum(gather_bid) from gather where to_char(gather_date , 'YYYY-MM') = '2022-12'", nativeQuery = true)
	String selectGatherBid1(String gatherBid);
	
	/**
	 * 광고 차트
	 * */
	@Query(value = "select distinct TO_CHAR(ad_regis_date,'mm') as month, sum(ad_price)as totalPrice, count(advertisement_no) as adCount\r\n"
			+ "from advertisement group by TO_CHAR(ad_regis_date,'mm') order by TO_CHAR(ad_regis_date,'mm')", nativeQuery = true)
	List<AdvertisementGroupBy> selectAdTotalPrice();
	
	/**
	 * 카테고리 별 모임 개수 
	 * */
	@Query(value = "select distinct category_no as category , count(gather_no) as gatherCount from gather group by category_no order by category_no", nativeQuery = true)
	List<GatherGroupBy> selectCategoryCount();
	
	/**
	 * 광고 승인날짜 리스트
	 * */
	@Query(value = "select TO_CHAR(ad_approve_date,'mm') as month from advertisement order by TO_CHAR(ad_approve_date,'mm')", nativeQuery = true)
	String selectApproveDate(Advertisement advertisement);
	
	/**
	 * 광고 데드라인 리스트
	 * */
	@Query(value = "select TO_CHAR(dead_line,'mm') as month from advertisement order by TO_CHAR(dead_line,'mm')", nativeQuery = true)
	String selectDeadLine(Advertisement advertisement);
	
	/**
	 * selectByNo
	 */
	@Query("select ad from Advertisement ad where ad.advertisementNo=?1")
	Advertisement selectByNo(Long adNo);
	
}