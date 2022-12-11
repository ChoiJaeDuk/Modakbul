package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
	Page<LikeGather> selectByUserId(Long userNo, Pageable page);
	 
	
	/**
	 * 관심모임 갯수 구하기
	 *///@Query("select count(*) from AlarmReceiver a where a.user.userNo = ?1")
	@Query(value="select count(*) from Like_Gather where user_No=?1", nativeQuery = true)
	int countLikeGather(Long userNo);
	
	/**
	 * 유저가 해당모임을 관심등록함?
	 */
	@Query("select lg from LikeGather lg where lg.gather.gatherNo = ?1 and lg.user.userNo =?2 ")
	LikeGather searchLikeGather(Long gatherNo, Long userNo);

}
