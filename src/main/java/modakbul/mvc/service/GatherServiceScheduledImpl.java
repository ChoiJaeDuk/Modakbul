package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.querydsl.jpa.impl.JPAQueryFactory;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QParticipant;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.AlarmReceiverRepository;
import modakbul.mvc.repository.AlarmRepository;
import modakbul.mvc.repository.GatherRepository;

@Service
public class GatherServiceScheduledImpl implements GatherServiceScheduled  {
	@Autowired
	private JPAQueryFactory queryFactory;
	
	
	private QParticipant p = QParticipant.participant;
	private QGather g = QGather.gather;
	
	
	@Autowired
	private  GatherRepository gatherRep;
	@Autowired
	private  AlarmRepository alarmRep;
	@Autowired
	private  AlarmReceiverRepository receiverRep;
	
	
	
  @Override
	public void autoUpdateParticipantState(Long gatherNo, String state, String dbState) {
		// System.out.println("참가자 상태 업데이트 호출되니?" +state);
		queryFactory.update(p).set(p.applicationState, state)
				.where(p.gather.gatherNo.eq(gatherNo).and(p.applicationState.eq(dbState))).execute();
	}
  @Override
	public List<Users> gatherStateAlarmList(String state, Long gatherNo) {
		List<Users> userList = queryFactory.select(p.user).from(p)
				.where(p.applicationState.eq(state).and(p.gather.gatherNo.eq(gatherNo))).fetch();
		return userList;
	}
  
  @Override
   public int selectParticipantCountByGatherNo(Long gatherNo) {
		
		List<Participant> list = queryFactory.selectFrom(p)
		.where(p.gather.gatherNo.eq(gatherNo)
				.and(p.applicationState.eq("참가승인")))
		.fetch();
		
		return list.size();
	}
  
  @Override
   public void insertReceiverAll(List<Users> userList, Alarm alarm) {
		System.out.println("등록전" + alarm.getAlarmNo());
		Alarm a = insertAlarm(alarm);
		
		List<AlarmReceiver> alarmReceiverList = new ArrayList<AlarmReceiver>();
		
		for(Users user:userList) {
			 alarmReceiverList.add(new AlarmReceiver(0L, user, a , "안읽음"));
		}
		System.out.println("등록후 = " + alarm.getAlarmNo());
		receiverRep.saveAll(alarmReceiverList);
		
		
		
	}
	
  @Override
   public Alarm insertAlarm(Alarm alarm) {
		Alarm a = alarmRep.save(alarm);
		System.out.println("알람 저장후 알람번호 : " + a.getAlarmNo());
		
		return a;
	}
   
	
	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public List<Gather>  autoUpdateGatherState() {
		/////////////////////////////////
		

		// boolean result = date1.isEqual(ldt);
		List<Gather> gatherList = queryFactory.selectFrom(g).where(g.gatherState.in("모집중", "모집마감", "진행중", "모집보류"))
				.fetch();

		System.out.println("검색결과 수 : " + gatherList.size());
		
		return gatherList;

		
	}// for문
	
	
 @Override
 @Transactional(propagation=Propagation.REQUIRES_NEW)
	public void test(List<Gather> gatherList ) {
	 LocalDateTime now = LocalDateTime.now();
		LocalDateTime ldt = LocalDateTime.of(now.getYear(), now.getMonth(), now.getDayOfMonth(), now.getHour(),
				now.getMinute());
		
		for (Gather gather : gatherList) {
			System.out.println(gather.getGatherNo());

			LocalDateTime grd = gather.getGatherDate();
			LocalDateTime completeDate = grd.plusHours(gather.getGatherTime());

			int i = selectParticipantCountByGatherNo(gather.getGatherNo());
			
					
			// System.out.println("결과 = " + ldt.isEqual(gather.getGatherDeadline()));
			// System.out.println("i = " + i +" / " + "최소인원: " +
			// gather.getGatherMinUsers());
			

				if (ldt.isEqual(gather.getGatherDeadline())) {

					List<Users> usersList = gatherStateAlarmList("참가승인", gather.getGatherNo());

					if (i < gather.getGatherMinUsers()) {
						gather.setGatherState("모임취소");
						autoUpdateParticipantState(gather.getGatherNo(), "모임취소", "참가승인");
						autoUpdateParticipantState(gather.getGatherNo(), "모임취소", "신청대기");
						String alarmSubject = gather.getGatherName() + "모임 상태알림";
						String alarmContent = "신청하신 " + gather.getGatherName() + "모임이 참가 인원 미달로인해 취소되었습니다.";
						Alarm alarm = new Alarm(0L, alarmSubject, alarmContent, null);

						insertReceiverAll(usersList, alarm);

						// 정기모임 재등록
						if (gather.getRegularGather().getRegularGatherState().equals("진행중")) {
							// 다음 날짜를 계산
							LocalDateTime newGatherDate = gather.getGatherDate()
									.plusDays(gather.getRegularGather().getRegularGatherCycle() * 7);
							// 다음 마감시간을 계산
							LocalDateTime newDeadline = newGatherDate.minusHours(3);
							// 새로운 모임을 insert
							Gather newGather = new Gather(0L, gather.getCategory(), gather.getUser(),
									gather.getRegularGather(), gather.getGatherName(), gather.getGatherMinUsers(),
									gather.getGatherMaxUsers(), gather.getGatherSelectGender(),
									gather.getGatherMinAge(), gather.getGatherMaxAge(), newGatherDate, newDeadline,
									gather.getGatherTime(), gather.getGatherPlace(), gather.getGatherPlaceDetail(),
									gather.getGatherComment(), "모집중", null, gather.getGatherBid(),
									gather.getGatherImg(), gather.getLikeCount());
							gatherRep.save(newGather);
						}
					} else {
						gather.setGatherState("모집마감");
						autoUpdateParticipantState(gather.getGatherNo(), "참가확정", "참가승인");

						String alarmSubject = gather.getGatherName() + "모임 상태알림";
						String alarmContent = "신청하신 " + gather.getGatherName() + "모임 진행이 확정되었습니다!";
						Alarm alarm = new Alarm(0L, alarmSubject, alarmContent, null);
						System.out.println("usersList = " + usersList.size());
						insertReceiverAll(usersList, alarm);
					}
				} else if (ldt.isEqual(gather.getGatherDate())) {

					gather.setGatherState("진행중");
					autoUpdateParticipantState(gather.getGatherNo(), "참가중", "참가확정");

				} else if (ldt.isEqual(completeDate)) {

					gather.setGatherState("진행완료");
					autoUpdateParticipantState(gather.getGatherNo(), "참가완료", "참가중");

					if (gather.getRegularGather().getRegularGatherState().equals("진행중")) {

						// 다음 날짜를 계산
						LocalDateTime newGatherDate = gather.getGatherDate()
								.plusDays(gather.getRegularGather().getRegularGatherCycle() * 7);
						// 다음 마감시간을 계산
						LocalDateTime newDeadline = newGatherDate.minusHours(3);
						// 새로운 모임을 insert
						Gather newGather = new Gather(0L, gather.getCategory(), gather.getUser(),
								gather.getRegularGather(), gather.getGatherName(), gather.getGatherMinUsers(),
								gather.getGatherMaxUsers(), gather.getGatherSelectGender(), gather.getGatherMinAge(),
								gather.getGatherMaxAge(), newGatherDate, newDeadline, gather.getGatherTime(),
								gather.getGatherPlace(), gather.getGatherPlaceDetail(), gather.getGatherComment(),
								"모집중", null, gather.getGatherBid(), gather.getGatherImg(), gather.getLikeCount());
						gatherRep.save(newGather);
					}
				}
			
		}

	}
}
