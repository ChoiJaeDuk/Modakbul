package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.LikeGather;

public interface GatherRepository extends JpaRepository<Gather, Long> , QuerydslPredicateExecutor<Gather> {

//	@Query(value="select l.gatherNo, count(l.gatherNo) as likeGatherCount from LikeGather l group by l.gatherNo")
//	List<LikeGather> selectLikeGatherCount();
	
//	@Query(value="select gather_no, count(gather_no) as gatherLikeCount from like_gather group by gather_no", nativeQuery = false)
//	List<LikeGather> selectLikeGatherCount();
	
	@Query(value="select * from gather", nativeQuery = true)
	List<Gather> selectLikeGatherCount();
}
