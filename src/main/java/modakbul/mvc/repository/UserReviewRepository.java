package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.UserReview;

public interface UserReviewRepository extends JpaRepository<UserReview, Long>, QuerydslPredicateExecutor<UserReview> {
	@Query(value = "select*from user_review where host_user_no=?1 order by user_review_no",nativeQuery =true )
	List<UserReview> selectByUserReviewNo(Long hostUserNo);
}
