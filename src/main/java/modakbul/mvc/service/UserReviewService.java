
package modakbul.mvc.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.UserReview;

public interface UserReviewService {
	/**
	 * 일일 모임 후기 조회하기
	 * */
	Page<UserReview> selectAllByUserReviewNo(Long hostUserNo, Pageable pageable);

	/**
	 * 일일모임 등록하기
	 * */
	void insert(UserReview userReview);
	
	/**
	 * 삭제하기
	 * */
	void delete(Long userReviewNo);
	
	Page<UserReview> selectByUserNo(Long hostUserNo, Pageable pageable);
	 
	 
}