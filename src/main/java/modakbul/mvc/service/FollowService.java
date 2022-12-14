package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import modakbul.mvc.domain.Follow;

public interface FollowService {
	
	/**
	 * 팔로잉 목록 출력
	 */
	List<Follow> selectByUserId(Long userNo);
	
	/**
	 * 등록
	 */
	String insert(Follow follow);
	
	/**
	 * 삭제
	 */
	String delete(Long follower, Long follwing);
	
	/**
	 * 나를 팔로우(구독자) 하는 사람들
	 */
	List<Follow> myFollower(Long userNo);
	
	/**
	 * 내가 팔로잉(구독한채널) 하는 사람들
	 */
	List<Follow> myFollowing(Long userNo);
	
	/**
	 * 내가 팔로우 했나요?
	 */
	String searchFollowing(Long follower, Long following);
}
