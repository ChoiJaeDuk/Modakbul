package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;

public interface LikeGatherRepository extends JpaRepository<LikeGather, Long>, QuerydslPredicateExecutor<LikeGather>{
	
	/**
	 * userId에 해당하는 관심모임 출력
	 */ 
	 @Query("select like from LikeGather like where like.user.userId = ?1")
	 LikeGather selectByUserId(String userId);
	 
}
