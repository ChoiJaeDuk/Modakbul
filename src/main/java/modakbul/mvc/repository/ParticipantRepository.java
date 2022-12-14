package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.Participant;
import modakbul.mvc.groupby.ParticipantGroupBy;

public interface ParticipantRepository extends JpaRepository<Participant, Long>, QuerydslPredicateExecutor<Participant>{
	
	
	@Query(value ="select p1.application_state as applicationState, count(p2.application_state) as applicationStateCount\r\n"
			+ "from (select distinct application_state from participant) p1 left outer join \r\n"
			+ "(select * from participant where user_no=?1) p2\r\n"
			+ "on p1.application_state = p2.application_state \r\n"
			+ "group by p1.application_state order by p1.application_state", nativeQuery = true)
	List<ParticipantGroupBy> selectApplicationStateCount(Long userNo);

}
