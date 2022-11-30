package modakbul.mvc.kyu;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.GatherReviewRepository;


@SpringBootTest
@Commit
@Transactional
public class Test {
	
	@Autowired
	private GatherReviewRepository gatherReviewRep;


	@org.junit.jupiter.api.Test
	public void contextLoads() {
		//모임후기에 13개 정도 레코드 추가
		for(int i=1; i<=13; i++) {
			gatherReviewRep.save(GatherReview.builder()
					.regularGather(new RegularGather(1L))
					.gatherTemper(10)
					.writerUser(new Users(2L))
					.hostUser(new Users(1L))
					.gatherReviewContent("내용"+i)
					.build()
					);
		}
	}
}
