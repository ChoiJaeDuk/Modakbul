package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;

public interface GatherServiceScheduled {
	List<Gather> autoUpdateGatherState();
	void test(List<Gather> gather);
	
	void autoUpdateParticipantState(Long gatherNo, String state, String dbState) ;
	
	 List<Users> gatherStateAlarmList(String state, Long gatherNo) ;
	
    int selectParticipantCountByGatherNo(Long gatherNo);
   
    void insertReceiverAll(List<Users> userList, Alarm alarm) ;
	
   
    Alarm insertAlarm(Alarm alarm) ;
}
