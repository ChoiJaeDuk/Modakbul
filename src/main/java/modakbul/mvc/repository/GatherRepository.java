package modakbul.mvc.repository;

import java.util.List;

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
	
}
