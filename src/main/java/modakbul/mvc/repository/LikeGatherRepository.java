package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;

public interface LikeGatherRepository extends JpaRepository<LikeGather, Long>,QuerydslPredicateExecutor<LikeGather>{
	
	/**
	 * userId에 해당하는 관심모임 출력
	 */ 
	@Query(value = "select * from like_gather where user_no =?1",nativeQuery = true)
	List<LikeGather> selectByUserId(Long userNo);
	 
	
	/**
	 * 관심모임 갯수 구하기
	 *///@Query("select count(*) from AlarmReceiver a where a.user.userNo = ?1")
	@Query(value="select count(*) from Like_Gather where user_No=?1", nativeQuery = true)
	int countLikeGather(Long userNo);
	
	

}
