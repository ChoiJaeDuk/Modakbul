package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.InquiryReply;
import modakbul.mvc.domain.UserReview;

public interface InquiryReplyRepository extends JpaRepository<InquiryReply, Long>, QuerydslPredicateExecutor<InquiryReply>{

	@Query(value = "select*from inquiry_reply where inq_no=?1 order by inquiry_reply_no",nativeQuery =true )
	List<InquiryReply> selectReplyByInquiryNo(Long inqNo);
}
