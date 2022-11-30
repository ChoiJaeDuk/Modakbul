package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import modakbul.mvc.domain.Inquiry;

public interface InquiryRepository extends JpaRepository<Inquiry, Long> {

	@Query(value = "select*from inquiry where gather_no=?1 order by inq_no", nativeQuery = true)
	List<Inquiry> InquiryListByGatherNo(Long gatherNo);
}
