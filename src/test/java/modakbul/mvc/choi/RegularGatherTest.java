package modakbul.mvc.choi;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.QRegularGather;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.repository.RegularGatherRepository;
import modakbul.mvc.service.RegularGatherService;

@SpringBootTest
@Transactional
@Commit
public class RegularGatherTest {
	
	private QRegularGather rg = QRegularGather.regularGather;
	
	@Autowired
	private EntityManager em;
	
	@Autowired
	private RegularGatherRepository regularGatherRep;
	
	@Autowired
	private RegularGatherService regularGatherService;
	
	@Test
	void insertRegularGather() {
		//RegularGather regularGather =new RegularGather(3L, 2, "화요일", 50, 0, "진행중", null);
		regularGatherRep.save(RegularGather.builder().regularGatherCycle(3).regularGatherDay("dd").gatherTemper(12).gatherTemperCount(0).regularGatehrState("진행중").build());
		//regularGatherService.insertRegularGather(regularGather);
	}
	
	
	@Test
	void updateRegularGather() {
		//RegularGather regularGather =new RegularGather(1L, 1, "수요일", 50, 1, "신청대기", null);
		//regularGatherService.updateRegularGather(regularGather);
	}
	
	
	@Test
	void updateGatherTemper() {
		regularGatherService.updateGatherTemper(1L, 50);
	}
	
}
