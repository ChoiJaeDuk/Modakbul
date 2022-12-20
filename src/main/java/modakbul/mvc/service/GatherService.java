package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.groupby.GatherGroupBy;

public interface GatherService {
	
	/**
	 * 모임을 등록한다.
	 * 정기모임이면 정기모임도 등록한다.
	 * @param gather
	 */
	void insertGather(Gather gather);
	
	
	/**
	 * 모임신청에서 신청을 취소하면 삭제된다.
	 */
	void deleteGather(Long gatherNo);
	
	/**
	 * 시간이 지남에 따라 상태를 업데이트한다.
	 * (모집중 -> 모집마감 -> 진행중 -> 진행완료)
	 * @param state
	 */
	void autoUpdateGatherState();
	
	
	/**
	 * 모임정보를 수정한다.
	 * @param gatherNo
	 */
	void updateGather(Gather gather);
	
	
	/**
	 * 동적쿼리 사용
	 * - 모임 상태가 모집중인 모임중
	 * 정기모임 번호가 0이면 일일모임 리스트를 반환하고
	 * 정기모임 번호가 0이 아니라면 정기모임 리스트를 반환한다.
	 * 
	 * - 모임상태가 신청대기인 모임을 반환한다.
	 * 
	 * @param regularGatherNo
	 * @return
	 */
	Page<Gather> selectGatherList(String gatherType, List<Long> categoryList, String place, String sort , String search, Pageable pageable);
	
	
	/**
	 * 모임 번호를 받아 해당 모임 객체를 반환한다.
	 * @param GatherNo
	 * @return
	 */
	Gather selectGatherByGatherNo(Long gatherNo);
	
	
	/**
	 * 관심모임을 등록할때 모임의 likeCount를 업데이트 해준다.
	 * @param gatherNo
	 * @param likeCount
	 */
	void updateLikeCount(Long gatherNo);
	
	
	/**
	 * 모임상태 카운트를 반환한다.
	 */
	List<Long> gatherStateCount(Long userNo);
	
	
	
	
	/**
	 * 월별 진행완료된 모임에 카운트
	 * @param pageable
	 * @return
	 */
	List<GatherGroupBy> selectGatherCountByMonth(Pageable pageable);
	
	
	/**
	 * 등록된 날짜순으로 모임정보를 출력
	 * @param pageable
	 * @return
	 */
	Page<Gather> selectGatherOrderByRegisDate(Pageable pageable);
	
	
	/**
	 * 신청대기상태인 모임 조회
	 * @param pageable
	 * @return
	 */
	Page<Gather> selectGatherappliList(Pageable pageable);
	
	
	/**
	 * 모집중인 모임중 광고가 등록되지 않은 모임 리스트 출력
	 * @param userNo
	 * @param pageable
	 * @return
	 */
	Page<Gather> selectNoneADGatherList(Long userNo, Pageable pageable);
	
	
	/**
	 * gatherNo와 state를 받아서 모임상태를 업데이트해준다.(자동업데이트에 사용)
	 * @param gaherNo
	 * @param state
	 */
	void updateGatherState(Long gaherNo, String state);
	
	
	
	/**
	 * 리뷰를 안쓴 모임리스트
	 * @param userNo
	 * @param state
	 * @param pageable
	 * @return
	 */
	
	  Page<Gather> selectByReviewState(Long userNo, boolean state, Pageable
	  pageable);
	 
	
	
	/**
	 * 참가자들의 상태를 자동업데이트 해준다.
	 * @param gatherNo
	 * @param state
	 * @param dbState
	 */
	void autoUpdateParticipantState(Long gatherNo, String state, String dbState);
	
	
	/**
	 * 내가 주최하는 모임중 신청대기상태 모임 검색
	 * @param pageable
	 * @param userNo
	 * @return
	 */
	Page<Gather> selectGatherStateByUserNo(Pageable pageable, Long userNo, String state);
	
	/**
	 * 마이페이지 모집중 값 리턴
	 * @param pageable
	 * @param userNo
	 * @return
	 */
	Page<GatherGroupBy> selectRecruitingList(Pageable pageable, Long userNo);
	
	/**
	 * 관리자페이지에서 모임관리
	 * @return
	 */
	Page<Gather> selectGatherManagementList(Pageable pageable);
	
	/**
	 * 관리자 페이지 월별 유료모임 매출
	 * @param year
	 * @return
	 */
	List<GatherGroupBy> selectBidTotal(String year);
	
	
	List<Gather> selectDeadlineOrderBy();
	
	
	List<String> selectGatherFile(Long gatherNo);
}


