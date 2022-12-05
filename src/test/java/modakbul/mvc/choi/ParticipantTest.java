package modakbul.mvc.choi;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.QParticipant;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.ParticipantGroupBy;
import modakbul.mvc.repository.ParticipantRepository;
import modakbul.mvc.service.ParticipantService;

@SpringBootTest
@Transactional
@Commit
public class ParticipantTest {
	Users user = new Users(6L);
	Gather gather = new Gather(13L);
	
	private QParticipant participant;
	
	@Autowired
	private ParticipantRepository participantRep;
	
	@Autowired
	private ParticipantService participantService;
	
	@Test
	void insertParticipant() {
		Participant participant = new Participant(0L, gather, user, "참가승인");
		participantService.insertParticipant(participant);
	}
	
	
	@Test
	void deleteParticipant() {
		participantService.deleteParticipant(user.getUserNo(), gather.getGatherNo());
	}
	
	
	@Test
	void updateApplicationState() {
		participantService.updateApplicationState(user.getUserNo(), gather.getGatherNo(), "참가승인");
	}
	
	
	@Test
	void selectApplicationStateByUserNo() {
		Pageable pageable = PageRequest.of(0, 5);
		Page<Gather> list = participantService.selectApplicationStateByUserNo(user.getUserNo(), "참가승인", pageable);
		
		System.out.println("list = " + list.getContent());
	}
	
	@Test
	void selectApplicationStateCount() {
		List<ParticipantGroupBy> list = participantService.selectApplicationStateCount(1L);
		
		for(ParticipantGroupBy p:list) {
			System.out.println(p.getApplicationState() + "/"+p.getApplicationStateCount());
		}
	}
	
	
	@Test
	void selectParticipantCountByGatherNo() {
		int count = participantService.selectParticipantCountByGatherNo(13L);
		System.out.println("count = " + count);
	}
	
	
	@Test
	void autoUpdateParticipantState() {
		participantService.autoUpdateParticipantState(13L, "참가승인", "참가확정");
	}
	
}
