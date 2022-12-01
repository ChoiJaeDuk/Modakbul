package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.GatherReviewReply;

public interface GatherReviewReplyRepository extends JpaRepository<GatherReviewReply, Long>, QuerydslPredicateExecutor<GatherReviewReply> {

}
