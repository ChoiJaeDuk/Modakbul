package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.GatherAttachments;

public interface GatherAttachmentsService {
	
	void insertGatherAttachments(List<GatherAttachments> gatherAttachments);
	
	
	void updateGatherAttachments(GatherAttachments gatherAttachments);
	
	
	void deleteGatherAttachments(Long gatherAttachementNo);
	
	
	List<GatherAttachments> selectGatherAttachments(Long gatherNo);
}
