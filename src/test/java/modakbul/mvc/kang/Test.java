package modakbul.mvc.kang;

import java.time.LocalDateTime;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.AdvertisementRepository;

@SpringBootTest
@Transactional
@Commit
public class Test {
	
	Users users = new Users(1L);
	Gather gather = new Gather(5L);

	
	@Autowired
	private AdvertisementRepository advertisementRep;
	
	
	@org.junit.jupiter.api.Test
	void advertisementInsert() {

		LocalDateTime date = LocalDateTime.now();
	
		
		Advertisement advertisement = new Advertisement(2L,users,gather,"진행대기",date,null,null,"test2.jpg");
		advertisementRep.save(advertisement);

	}
	
	
	@org.junit.jupiter.api.Test
	void statusUpdate() {
			Advertisement advertisement = advertisementRep.findById(4L).orElse(null);
			
			advertisement.setAdStatus("광고중");
			
		}
	
	
}
