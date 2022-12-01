package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Gather;

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
	List<Gather> selectGatherList(int regularGatherNo, int categoryNo, String sort ,Pageable pageable);
	
	
	/**
	 * 모임 번호를 받아 해당 모임 객체를 반환한다.
	 * @param GatherNo
	 * @return
	 */
	Gather selectGatherByGatherNo(int gatherNo);
	
	/**
	 * 광고로 등록된 모임 리스트를 반환한다.
	 * @param adList
	 * @return
	 */
	List<Gather> selectADGatherList(List<Long> adList);
	
	
}
