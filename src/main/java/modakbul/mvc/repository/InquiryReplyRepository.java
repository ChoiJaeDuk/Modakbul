package modakbul.mvc.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.InquiryReply;

public interface InquiryReplyRepository extends JpaRepository<InquiryReply, Long>, QuerydslPredicateExecutor<InquiryReply>{

	@Query(value = "select * from inquiry_reply where inq_no=?1 order by INQUIRY_REPLY_NO" , nativeQuery =true )
	//@Query(value = "select ir from  InquiryReply ir where ir.inquiry.inqNo=?1" )
	Page<InquiryReply> selectReplyByInquiryNo(Long inqNo,Pageable pageable);
}
