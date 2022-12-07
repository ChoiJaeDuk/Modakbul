package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.InquiryReply;
import modakbul.mvc.repository.InquiryReplyRepository;

@Service
@Transactional
public class InquiryReplytServiceImpl implements InquiryReplytService {

	@Autowired
	private InquiryReplyRepository inquiryReplyRep;
	
	@Override
	public Page<InquiryReply> selectReplyByInquiryNo(Long inqNo,Pageable pageable) {
		Page<InquiryReply> list=inquiryReplyRep.selectReplyByInquiryNo(inqNo,pageable);
		return list;
	}

	@Override
	public InquiryReply selectByInquiryReplyNo(Long inquiryReplyNo) {
		InquiryReply dbInquiryReply=inquiryReplyRep.findById(inquiryReplyNo).orElse(null);
		if(dbInquiryReply==null)
			throw new RuntimeException("문의글에 댓글이아직 없어요");
		return dbInquiryReply;
	}

	@Override
	public void insertInquiryReply(InquiryReply inquiryReply) {
		inquiryReplyRep.save(inquiryReply);

	}

	@Override
	public void deleteInquiryReply(Long inquiryReplyNo) {
		InquiryReply dbInquiryReply=inquiryReplyRep.findById(inquiryReplyNo).orElse(null);
		if(dbInquiryReply==null)
			throw new RuntimeException("댓글 삭제 번호 오류로 삭제불가");
		
		inquiryReplyRep.deleteById(inquiryReplyNo);
	}

}
