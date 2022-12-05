package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Follow;


public interface FollowRepository extends JpaRepository<Follow, Long>,QuerydslPredicateExecutor<Follow>{
	
	/**
	 * userId에 해당하는 팔로잉 목록 출력 - 내가 구독한 사람들의 리스트(마이페이지)
	 */
	@Query(value = "select * from Follow where follow_no =?1",nativeQuery = true)
	Follow selectByUserId(Long userNo);
	
	/**
	 * 나를 팔로우(구독자) 하는 사람들
	 */
	@Query("select f from Follow f where f.followingUser.userNo = ?1")
	List<Follow> myFollower(Long userNo);
	
	/**
	 * 내가 팔로잉(구독한채널) 하는 사람들
	 */
	@Query("select f from Follow f where f.followerUser.userNo = ?1")
	List<Follow> myFollwing(Long userNo);
	
	/**
	 * 팔로잉 목록 검색(제가 이사람 팔로잉 했나요?)
	 */
	@Query("select f from Follow f where f.followerUser.userNo = ?1 and f.followingUser.userNo = ?2")
	Follow searchFollowing(Long follower, Long following);
	
	
}
