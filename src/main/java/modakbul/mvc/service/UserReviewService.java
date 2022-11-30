package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.UserReview;

public interface UserReviewService {
	/**
	 * 일일 모임 후기 조회하기
	 * */
	List<UserReview> selectAllByUserReviewNo(Long hostUserNo);

	/**
	 * 일일모임 등록하기
	 * */
	void insert(UserReview userReview);
	
	/**
	 * 삭제하기
	 * */
	void delete(Long userReviewNo);
	
	 UserReview selectByUserReviewNo(Long userReviewNo);
}
