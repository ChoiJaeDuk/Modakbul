package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.groupby.SelectReplyState;

public interface InquiryRepository extends JpaRepository<Inquiry, Long>, QuerydslPredicateExecutor<Inquiry>{

	@Query(value = "select*from inquiry where gather_no=?1 order by inq_no", nativeQuery = true)
	Page<Inquiry> InquiryListByGatherNo(Long gatherNo, Pageable pageable);
	
	//마이페이지에서 쓰는
	@Query(value = "select i.inq_no as inqNo, g.gather_name as gatherName, i.inq_subject as inqSubject, i.inq_regis_date as inqRegisDate, r.inq_no as state\r\n"
			+ "from inquiry i \r\n"
			+ "left outer join (select distinct inq_no from inquiry_reply) r \r\n"
			+ "on i.inq_no=r.inq_no join gather g on i.gather_no=g.gather_no where i.user_no=? and r.inq_no is null " 
			,nativeQuery = true)
	List<SelectReplyState> selectReplyState(Long userNo);
	
	
}
