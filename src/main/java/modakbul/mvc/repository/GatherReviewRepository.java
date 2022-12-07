package modakbul.mvc.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.GatherReview;

public interface GatherReviewRepository extends JpaRepository<GatherReview, Long>, QuerydslPredicateExecutor<GatherReview>{

	@Query(value = "select * from gather_review where regular_gather_no= ?1", nativeQuery = true) 
	Page<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo, Pageable pageable);
	
 }
