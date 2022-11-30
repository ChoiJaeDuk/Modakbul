package modakbul.mvc.choi;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import modakbul.mvc.repository.GatherRepository;

@SpringBootTest
public class GatherTest {
	
	GatherRepository gatherRep;
	@Test
	void contextLoads() {
	}
	
	@Test
	void gatherInsert() {
		gatherRep.save(null);
	}
}
