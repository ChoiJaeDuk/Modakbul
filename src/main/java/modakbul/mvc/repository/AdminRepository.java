package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.groupby.AdvertisementGroupBy;

public interface AdminRepository extends JpaRepository<Advertisement, Long>, QuerydslPredicateExecutor<Advertisement> {
	
	/**
	 * 
	 * */
	
	/**
	 * 유료광고중인 모임 추천 모임에 뿌리기
	 * */
	
	@Query(value = "select * from gather left join advertisement on advertisement.gather_no = gather.gather_no where ad_status = '광고중' and gather.gather_state = '모집중' ORDER by advertisement.gather_no asc",nativeQuery = true)
	List<Advertisement> selectAdGather();
	
	
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '광고중'",nativeQuery = true)
	List<Advertisement> selectByStatus1(Advertisement advertisement);
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '신청대기'",nativeQuery = true)
	List<Advertisement> selectByStatus2(Advertisement advertisement);
	/**
	 * 광고 상태 출력
	 */ 
	@Query(value = "select * from advertisement where ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectByStatus3(Advertisement advertisement);
	
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
	
	
	@Query(value = "select distinct TO_CHAR(ad_regis_date,'mm') as month, sum(ad_price)as totalPrice, count(advertisement_no) as adCount\r\n"
			+ "from advertisement group by TO_CHAR(ad_regis_date,'mm') order by TO_CHAR(ad_regis_date,'mm')", nativeQuery = true)
	List<AdvertisementGroupBy> selectAdTotalPrice();
	
}