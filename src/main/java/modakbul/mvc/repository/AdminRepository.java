package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;

public interface AdminRepository extends JpaRepository<Advertisement, Long>, QuerydslPredicateExecutor<Advertisement> {
	
	/**
	 * 유료광고중인 거 추천 모임에 뿌리기
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
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-01' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng1(Advertisement advertisement);

	/**
	 * 2월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-02' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng2(Advertisement advertisement);

	/**
	 * 3월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-03' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng3(Advertisement advertisement);

	/**
	 * 4월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-04' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng4(Advertisement advertisement);

	/**
	 * 5월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-05' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng5(Advertisement advertisement);

	/**
	 * 6월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-06' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng6(Advertisement advertisement);

	/**
	 * 7월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-07' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng7(Advertisement advertisement);

	/**
	 * 8월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-08' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng8(Advertisement advertisement);

	/**
	 * 9월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-09' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng9(Advertisement advertisement);

	/**
	 * 10월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-10' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng10(Advertisement advertisement);

	/**
	 * 11월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-11' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng11(Advertisement advertisement);

	/**
	 * 12월 광고중
	 * */
	@Query(value = "select * from advertisement where to_char(ad_regis_date , 'YYYY-MM') = '2022-12' and ad_status = '광고중' or ad_status = '광고종료'",nativeQuery = true)
	List<Advertisement> selectAdStatusIng12(Advertisement advertisement);

	/**
	 * 모임 참가비 조회1
	 * */
	@Query(value ="select sum(gather_bid) from gather where to_char(gather_date , 'YYYY-MM') = '2022-12'", nativeQuery = true)
	String selectGatherBid1(String gatherBid);
}