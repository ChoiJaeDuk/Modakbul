package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Follow;


public interface FollowRepository extends JpaRepository<Follow, Long>, QuerydslPredicateExecutor<Follow>{
	
	/**
	 * userId에 해당하는 팔로잉 목록 출력 - 내가 구독한 사람들의 리스트(마이페이지)
	 */
//	@Query("select f from Follow f where f.user.userId = ?1")
//	Follow selectByUserId(String userId);
	
}
