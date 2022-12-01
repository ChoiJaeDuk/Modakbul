package modakbul.mvc.repository;

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
	
}
