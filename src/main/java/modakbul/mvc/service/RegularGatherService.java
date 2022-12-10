package modakbul.mvc.service;

import modakbul.mvc.domain.RegularGather;

public interface RegularGatherService {
	
	
	/**
	 * 정기모임을 등록하는 메소드
	 * @param regularGather
	 */
	RegularGather insertRegularGather(RegularGather regularGather);
	
	
	
	/**
	 * 신청대기상태에서 취소를 누르면 정기모임이 삭제된다.
	 */
	void deleteRegularGather(Long regulrGatherNo);
	
	/**
	 * 정기모임 정보를 수정하는 메소드
	 * @param regularGather
	 */
	void updateRegularGather(RegularGather regularGather);
	
		
	/**
	 * 신청상태를 변경해준다.
	 * @param state
	 */
	void updateRegularGatherState(Long regularGatherNo, String state);
	
	
	/**
	 * 정기모임 온도를 업데이하는 메소드
	 * @param gatherTemper
	 * @param temper
	 */
	void updateGatherTemper(Long gatherTemper, double temper);
}
