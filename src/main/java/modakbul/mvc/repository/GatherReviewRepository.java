package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.GatherReview;

public interface GatherReviewRepository extends JpaRepository<GatherReview, Long>, QuerydslPredicateExecutor<GatherReview>{

	@Query(value = "select* from gather_review  where REGULAR_GATHER_NO= ?1 order by GATHER_REVIEW_NO",nativeQuery = true) 
	List<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo);
	
 }
