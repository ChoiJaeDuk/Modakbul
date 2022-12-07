	package modakbul.mvc.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.GatherReview;

public interface GatherReviewService {
	
	/**
	 * 정기모임 후기 조회 하기 
	 * */
	//List<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo) ;
	Page<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo, Pageable pageable) ;

	/**
	 * 정기 모임 후기 등록하기
	 * */
	void insert(GatherReview gatherReview);
	
	/**
	 * 정기 모임 삭제하기
	 * */
	void delete(Long gatherReviewNo);
	/**
	 * 리뷰 아이디별 상세
	 * */
	GatherReview selectByGatherReviewNo(Long gatherReviewNo);

	
	
}
