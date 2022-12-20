package modakbul.mvc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.GatherAttachments;
import modakbul.mvc.domain.QGatherAttachments;
import modakbul.mvc.repository.GatherAttachmentsRepository;

@Service
@RequiredArgsConstructor
@org.springframework.transaction.annotation.Transactional
@EnableScheduling
public class GatherAttachmentsServiceImpl implements GatherAttachmentsService {
	private final EntityManager em;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	private final GatherAttachmentsRepository gatherAttachmentsRep;
	
	QGatherAttachments ga = QGatherAttachments.gatherAttachments;
	
	@Override
	public void insertGatherAttachments(GatherAttachments gatherAttachments) {
		
		gatherAttachmentsRep.save(gatherAttachments);

	}

	@Override
	public void updateGatherAttachments(GatherAttachments gatherAttachments) {
		em.merge(gatherAttachments);
		
	}

	@Override
	public void deleteGatherAttachments(Long gatherAttachmentNo) {
		gatherAttachmentsRep.deleteById(gatherAttachmentNo);
	}
	
	//보류 어떤값을 리턴해야하는지 모르겠어요~~!
	@Override
	public List<GatherAttachments> selectGatherAttachments(Long gatherNo) {
		List<GatherAttachments> list = queryFactory.selectFrom(ga)
		.where(ga.gather.gatherNo.eq(gatherNo))
		.fetch();
		return list;
	}

}
