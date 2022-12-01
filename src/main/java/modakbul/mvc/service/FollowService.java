package modakbul.mvc.service;

import modakbul.mvc.domain.Follow;

public interface FollowService {
	
	/**
	 * 팔로잉 목록 출력
	 */
//	Follow selectByUserId(String userId);
	
	/**
	 * 등록
	 */
	void insert(Follow follow);
	
	/**
	 * 삭제
	 */
	void delete(Long followNo);
}
