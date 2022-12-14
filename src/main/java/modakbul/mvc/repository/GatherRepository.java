package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.groupby.GatherGroupBy;

public interface GatherRepository extends JpaRepository<Gather, Long> , QuerydslPredicateExecutor<Gather> {
	
	@Query(value ="select count(g2.gather_state) as gatherStateCount \r\n"
			+ "from \r\n"
			+ "(select distinct gather_state from gather) g1\r\n"
			+ "left outer join \r\n"
			+ "(select * from gather where user_no=?1) g2\r\n"
			+ "on g1.gather_state = g2.gather_state\r\n"
			+ "group by g1.gather_state\r\\n"
			+ "order by g1.gather_state",nativeQuery = true)
	List<Long> selectStateCount(Long userNo);
	
	
	
	@Query(value ="select distinct to_char(g1.gather_date,'yyyy-mm')as gatherMonth,count(g2.gather_state) as gatherCount\r\n"
			+ "from (select distinct gather_date from gather) g1 \r\n"
			+ "left outer join (select * from gather where gather_state='진행완료') g2\r\n"
			+ "on g1.gather_date = g2.gather_date\r\n"
			+ "group by to_char(g1.gather_date,'yyyy-mm')", nativeQuery = true)
	List<GatherGroupBy> selectGatherCountByMonth();
	
	
	@Query(value ="select g from Gather g where g.gatherState='신청대기'")
	Page<Gather> selectGatherappliList(Pageable pageable);
	
	
	@Query(value = "select g.gather_no as gatherNo\r\n"
			+ ", gather_img as gatherImg\r\n"
			+ ", gather_name as gatherName\r\n"
			+ ", gather_deadline as gatherDeadline\r\n"
			+ ", gather_max_users as gatherMaxUsers\r\n"
			+ ", NVL(pcount,0) as PCount\r\n"
			+ ", NVL(l.like_count,0) as likeCount \r\n"
			+ ", regular_gather_no as regularGatherNo\r\n"
			+ "from gather g left outer join \r\n"
			+ "(select gather_no, count(gather_no)as pcount from participant where application_state='참가승인' group by gather_no) p \r\n"
			+ "on g.gather_no=p.gather_no \r\n"
			+ "left outer join (select gather_no, count(gather_no) as like_count from like_gather group by gather_no) l\r\n"
			+ "on g.gather_no= l.gather_no\r\n"
			+ "where g.user_no=?1 and g.gather_state='모집중'", nativeQuery = true)
	List<GatherGroupBy> selectRecruitingList(Long userNo);
	
	
	@Query(value= "select to_char(gather_date,'mm') as gatherMonth,\r\n"
			+ "sum(total) as total\r\n"
			+ "from(select g.gather_no, sum(gather_bid)*participants as total, gather_date\r\n"
			+ "from gather g left outer join\r\n"
			+ "(select gather_no, count(gather_no) as participants from participant where application_state='참가완료' group by gather_no) p\r\n"
			+ "on g.gather_no = p.gather_no\r\n"
			+ "where gather_bid !=0 and gather_state='진행완료' and to_char(gather_date,'yyyy') = ?1 \r\n"
			+ "group by g.gather_no, participants, gather_date)\r\n"
			+ "group by to_char(gather_date,'mm') \r\n"
			+ "order by gatherMonth", nativeQuery = true)
	List<GatherGroupBy> selectBidTotal(String year);
	
	
	@Query(value = "select * from gather where gather_state='모집중' and rownum <5 order by gather_deadline asc", nativeQuery = true)
	List<Gather> selectGatherOrderByDeadline();
}




