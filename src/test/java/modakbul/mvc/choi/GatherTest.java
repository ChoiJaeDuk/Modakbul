package modakbul.mvc.choi;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.GatherRepository;

@SpringBootTest
public class GatherTest {
	
	Users user = new Users();
	
	GatherRepository gatherRep;
	@Test
	void contextLoads() {
	}
	
	@Test
	void gatherInsert() {
		gatherRep.save(null);
	}
}
