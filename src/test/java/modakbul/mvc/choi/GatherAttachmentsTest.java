package modakbul.mvc.choi;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.QGatherAttachments;
import modakbul.mvc.repository.GatherAttachmentsRepository;
import modakbul.mvc.service.GatherAttachmentsService;

@SpringBootTest
@Transactional
@Commit
public class GatherAttachmentsTest {
	
	private Gather gather = new Gather(5L);
	
	private QGatherAttachments ra = QGatherAttachments.gatherAttachments;
	
	@Autowired
	private EntityManager em;
	
	@Autowired
	private GatherAttachmentsRepository gatherAttachmentsRep;
	
	@Autowired
	private GatherAttachmentsService gatherAttachmentsService;
	
	@Test
	void insertGatherAttachments() {
		GatherAttachments g = new GatherAttachments(5L, gather, "테스트2", "file2");
		
		gatherAttachmentsService.insertGatherAttachments(g);
	}
	
	
	@Test
	void updateGatherAttachments() {
		GatherAttachments g = new GatherAttachments(3L, gather, "수정본", "file2");
		gatherAttachmentsService.updateGatherAttachments(g);
	}
	
	
	@Test
	void selectGatherAttachments() {
		List<GatherAttachments> list = gatherAttachmentsService.selectGatherAttachments(5L);
		for(GatherAttachments g: list) {
			System.out.println(g.getGatherAttachmentsFileName());
		}
	}
}
