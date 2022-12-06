	package modakbul.mvc.service;

import java.util.List;
import java.util.Optional;

import modakbul.mvc.domain.GatherReview;

public interface GatherReviewService {
	
	/**
	 * 정기모임 후기 조회 하기 
	 * */
	List<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo) ;

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
	
	/**
	 * 리뷰 작성 유무 체크 
	 * */
	
	
}
