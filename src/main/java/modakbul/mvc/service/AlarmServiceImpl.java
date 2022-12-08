package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;


import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.repository.AlarmReceiverRepository;
import modakbul.mvc.repository.AlarmRepository;

@Service
@Transactional
@RequiredArgsConstructor
public class AlarmServiceImpl implements AlarmService{

	private final AlarmRepository alarmRep;
	private final AlarmReceiverRepository receiverRep;
	
	/**
	 * 회원별 알람 목록 출력
	 */
	@Override
	public Page<AlarmReceiver> selectByUserId(Long userNo, Pageable page) {
		
		Page<AlarmReceiver> resultPage = receiverRep.selectByUserId(userNo, page);
		
		List<AlarmReceiver> list = resultPage.getContent();
		list.forEach(b->System.out.println(b)); 
		list.forEach(a->a.setAlarmStatus("읽음"));
		
		return resultPage;
	}
	
	/**
	 * 알람 등록
	 */
	@Override
	public void insertAlarm(Alarm alarm) {
		alarmRep.save(alarm);
		
	}
	
	/**
	 * 알람 삭제
	 */
	@Override
	public void deleteAlarm(Long alarmNo) {	}
	
	/**
	 * 알람 리시버 등록
	 */
	@Override
	public void insertReceiver(AlarmReceiver receiver) {
		
		receiverRep.save(receiver);
		
	}
	
	/**
	 * 알람 리시버 삭제
	 */
	@Override
	public void deleteReceiver(Long alarmReceiverNo) {
		
		receiverRep.deleteById(alarmReceiverNo);
	}

	/**
	 * 회원의 안읽은 알람 갯수
	 */
	@Override
	public int countNewAlarm(Long userNo) {
		
		return receiverRep.countNewAlarm(userNo);
	}
	
	/**
	 * 안읽은 알람 리스트 & 갯수 
	 */
	@Override
	public List<AlarmReceiver> unreadAlarms(Long userNo) {
		
		List<AlarmReceiver> list = receiverRep.unreadAlarms(userNo);
		
		return list;
	}
	
	
}
