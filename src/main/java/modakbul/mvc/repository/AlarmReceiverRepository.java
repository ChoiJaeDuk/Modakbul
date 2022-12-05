package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.AlarmReceiver;

public interface AlarmReceiverRepository extends JpaRepository<AlarmReceiver, Long>, QuerydslPredicateExecutor<AlarmReceiver>{
	
	/**
	 * 회원의 알림 확인
	 */
	@Query(value="select * from Alarm_receiver where user_no =?1", nativeQuery = true)
	Page<AlarmReceiver> selectByUserId(Long userNo, Pageable page);
	
	
	/**
	 * 회원의 안읽은 알람 갯수
	 */
	@Query("select count(*) from AlarmReceiver a where a.user.userNo = ?1 and ar.alarmStatus = '안읽음'")
	int countNewAlarm(Long userNo);
	
	
	/**
	 * 알람읽음 일괄처리를 위한 list(setAlarmStatus("읽음"))
	 */
	@Query("select ar from AlarmReceiver ar where ar.user.userNo = ?1 and ar.alarmStatus = '안읽음'")
	List<AlarmReceiver> unreadAlarms(Long userNo);
	
	
	
}
