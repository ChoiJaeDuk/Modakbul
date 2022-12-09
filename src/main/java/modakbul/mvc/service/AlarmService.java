package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Users;

public interface AlarmService {
	
	/**
	 * 회원별 알람 목록 출력
	 */
	Page<AlarmReceiver> selectByUserId(Long userNo, Pageable page);
	
	/**
	 * 알람 등록
	 */
	Alarm insertAlarm(Alarm alarm);
	
	/**
	 * 알람 삭제
	 */
	void deleteAlarm(Long alarmNo);
	
	/**
	 * 알람 리시버 등록
	 */
	void insertReceiver(List<Users> userList, Alarm alarm);
	
	/**
	 * 알람 리시버 삭제
	 */
	void deleteReceiver(Long alarmReceiverNo);

	/**
	 * 회원의 안읽은 알람 갯수
	 */
	int countNewAlarm(Long userNo);
	
	/**
	 * 안읽은 알람 리스트 & 갯수 
	 */
	List<AlarmReceiver> unreadAlarms(Long userNo);
	
}
