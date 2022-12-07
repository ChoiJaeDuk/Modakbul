package modakbul.mvc.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.groupby.SelectReplyState;

public interface InquiryRepository extends JpaRepository<Inquiry, Long>{

	@Query(value = "select*from inquiry where gather_no=?1 order by inq_no", nativeQuery = true)
	Page<Inquiry> InquiryListByGatherNo(Long gatherNo, Pageable pageable);
	
	//마이페이지에서 쓰는
	@Query(value = "select i.inq_no, g.gather_name, i.inq_subject, i.inq_regis_date, r.inq_no as state  from (select * from inquiry where user_no =?1) i left outer join (select distinct inq_no from inquiry_reply) r on i.inq_no=r.inq_no join gather g on i.gather_no=g.gather_no", nativeQuery = true)
	Page<SelectReplyState> selectReplyState(Long userNo, Pageable pageable);
}
