package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.groupby.GatherGroupBy;

public interface GatherService {
	
	/**
	 * 모임을 등록한다.
	 * 정기모임이면 정기모임도 등록한다.
	 * @param gather
	 */
	void insertGather(Gather gather);
	
	
	/**
	 * 시간이 지남에 따라 상태를 업데이트한다.
	 * (모집중 -> 모집마감 -> 진행중 -> 진행완료)
	 * @param state
	 */
	void updateGatherState();
	
	
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
	Page<Gather> selectGatherList(boolean gatherType, List<Long> categoryList, String place, String sort , String search, Pageable pageable);
	
	
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
	void updateLikeCount(Long gatherNo, int likeCount);
	
	
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
	
}
