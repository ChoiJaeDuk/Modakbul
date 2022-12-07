package modakbul.mvc.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.UserReview;

public interface UserReviewRepository extends JpaRepository<UserReview, Long>, QuerydslPredicateExecutor<UserReview> {
	@Query(value = "select * from user_review where host_user_no=?1",nativeQuery =true )
	Page<UserReview> selectByUserReviewNo(Long hostUserNo,Pageable pageable );
}
