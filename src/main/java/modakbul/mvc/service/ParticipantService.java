package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.groupby.ParticipantGroupBy;

public interface ParticipantService {
	
	/**
	 * 참가신청을 하면 등록해준다.
	 * @param participant
	 */
	void insertParticipant(Participant participant);
	
	/**
	 * 참가신청한 유저가 신청 취소를 할 경우
	 * participantNo에 해당하는 데이터를 삭제한다. 
	 */
	void deleteParticipant(Long userNo, Long GatherNo);
	
	
	/**
	 * state인수를 받아 state로 appliState를 변경한다.
	 */
	void updateApplicationState(Long userNo, Long gatherNo ,String state);
	
	
	/**
	 * state에 따른 모임 리스트 조회 
	 * @param state
	 * @return
	 */
	Page<Gather> selectApplicationStateByUserNo(Long userNo, String state, Pageable pageable);
	
	
	/**
	 * 해당 회원이 참가 신청대기, 승인, 완료한 모임 카운트
	 * @return
	 */
	List<ParticipantGroupBy> selectApplicationStateCount(Long userNo);
	
	
	/**
	 * 해당 모임의 참가자 카운트를 불러온다
	 * @param gatherNo
	 * @return
	 */
	int selectParticipantCountByGatherNo(Long gatherNo);
	
	
	void autoUpdateParticipantState(Long gatherNo, String state, String dbState);
	
}
