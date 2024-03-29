package modakbul.mvc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.querydsl.core.QueryResults;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QParticipant;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.ParticipantGroupBy;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.ParticipantRepository;
import modakbul.mvc.repository.UsersRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class ParticipantServiceImpl implements ParticipantService {
	
	private final EntityManager em;
	
	private QParticipant participant = QParticipant.participant;
	private QGather gather = QGather.gather;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	private final ParticipantRepository participantRep;
	private final GatherRepository gatherRep;
	private final UsersRepository usersRep;
	
	@Autowired
	private AlarmService alarmService;
	//시간나면 유효성검사를 해보자
	@Override
	public void insertParticipant(Participant participant) {
		
		participantRep.save(participant);
	}
	
	
	@Override
	public void deleteParticipant(Long userNo, Long gatherNo) {
		Long result = queryFactory
				.delete(participant)
				.where(participant.user.userNo.eq(userNo)
						.and(participant.gather.gatherNo.eq(gatherNo)))
						.execute();
		System.out.println(result);
	}

	@Override
	public void updateApplicationState(Long userNo, Long gatherNo ,String state) {
		queryFactory.update(participant)
		.set(participant.applicationState,state)
		.where(participant.user.userNo.eq(userNo)
				.and(participant.gather.gatherNo.eq(gatherNo)))
		.execute();
		
		Gather gather = gatherRep.findById(gatherNo).orElse(null);
		Users user = usersRep.findById(userNo).orElse(null);
		
	
		if(state.equals("참가승인")) {
			String alarmSubject = gather.getGatherName()+"모임 상태알림";
			String alarmContent = "신청하신 " + gather.getGatherName() + "모임 참가가 승인되었습니다.";
			Alarm alarm = new Alarm(0L, alarmSubject, alarmContent, null);
			alarmService.insertReceiverOne(user, alarm);
			String str = user.getUserPhone();
			str = str.replaceAll("-", "");
			System.out.println(str);
			//exampleController.sendOne(str, alarmContent);//문자
		}else if(state.equals("참가거절")) {
			String alarmSubject = gather.getGatherName()+"모임 상태알림";
			String alarmContent = "신청하신 " + gather.getGatherName() + "모임 참가가 거절되었습니다.";
			Alarm alarm = new Alarm(0L, alarmSubject, alarmContent, null);
			alarmService.insertReceiverOne(user, alarm);
			String str = user.getUserPhone();
			str = str.replaceAll("-", "");
			System.out.println(str);
			//exampleController.sendOne(str, alarmContent);//문자
		}
		
	}

	@Override
	public Page<Gather> selectApplicationStateByUserNo(Long userNo, String state, Pageable pageable) {
		QueryResults<Gather> result; 
		if(state.equals("참가완료")) {
			result = queryFactory.select(gather)
				.from(participant).join(gather)
				.on(participant.gather.gatherNo.eq(gather.gatherNo))
				.where(participant.user.userNo.eq(userNo)
						.and(participant.applicationState.in(state,"참가취소","참가확정","진행중")))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
				System.out.println("참가취소쪽 나오니?");
		}else {
			 result = queryFactory.select(gather)
				.from(participant).join(gather)
				.on(participant.gather.gatherNo.eq(gather.gatherNo))
				.where(participant.user.userNo.eq(userNo)
						.and(participant.applicationState.eq(state)))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		}
		System.out.println("참가취소 result.size() = " + result.getTotal());
		return new PageImpl<Gather>(result.getResults(), pageable, result.getTotal());
	}

	@Override
	public List<ParticipantGroupBy> selectApplicationStateCount(Long userNo) {

		List<ParticipantGroupBy> applicationStateCount = participantRep.selectApplicationStateCount(userNo);
		return applicationStateCount;
	}


	@Override
	public int selectParticipantCountByGatherNo(Long gatherNo) {
		
		List<Participant> list = queryFactory.selectFrom(participant)
		.where(participant.gather.gatherNo.eq(gatherNo)
				.and(participant.applicationState.eq("참가승인")))
		.fetch();
		
		return list.size();
	}


	@Override
	public void autoUpdateParticipantState(Long gatherNo, String state, String dbState) {
		System.out.println("참가자 상태 업데이트 호출되니?" +state);
		queryFactory.update(participant)
		.set(participant.applicationState, state)
		.where(participant.gather.gatherNo.eq(gatherNo)
				.and(participant.applicationState.eq(dbState)))
		.execute();
		
	}

	public Page<Participant> selectParticipantByGatherNo(Long gatherNo, Pageable pageable) {
		
		QueryResults<Participant> result = queryFactory.selectFrom(participant)
				.where(participant.gather.gatherNo.eq(gatherNo)
						.and(participant.applicationState.eq("신청대기")))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		
		return new PageImpl<Participant>(result.getResults(),pageable, result.getTotal());
		
	}


	@Override
	public int checkParticipant(Long gatherNo, Long userNo) {

		List<Participant> list = queryFactory.selectFrom(participant)
				.where(participant.gather.gatherNo.eq(gatherNo)
						.and(participant.user.userNo.eq(userNo)))
				.fetch();
		
		return list.size();
	}
}
