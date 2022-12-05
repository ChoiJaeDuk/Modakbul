package modakbul.mvc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.querydsl.core.types.Predicate;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QParticipant;
import modakbul.mvc.groupby.ParticipantGroupBy;
import modakbul.mvc.repository.ParticipantRepository;

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
	}

	@Override
	public Page<Gather> selectApplicationStateByUserNo(Long userNo, String state, Pageable pageable) {
		List<Gather> result = queryFactory.select(gather)
		.from(participant).join(gather)
		.on(participant.gather.gatherNo.eq(gather.gatherNo))
		.where(participant.user.userNo.eq(userNo)
				.and(participant.applicationState.eq(state)))
		.fetch();
		return new PageImpl<Gather>(result, pageable, result.size());
	}

	@Override
	public List<ParticipantGroupBy> selectApplicationStateCount(Long userNo) {

		List<ParticipantGroupBy> applicationStateCount = participantRep.selectApplicationStateCount(userNo);
		return applicationStateCount;
	}


	@Override
	public int selectParticipantCountByGatherNo(Long gatherNo) {
		
		List<Participant> list = queryFactory.selectFrom(participant)
		.where(participant.gather.gatherNo.eq(gatherNo))
		.fetch();
		
		return list.size();
	}

	
}
