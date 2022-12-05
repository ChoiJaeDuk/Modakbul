package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.groupby.SelectReplyState;
import modakbul.mvc.repository.InquiryRepository;

@Service
@Transactional
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	private InquiryRepository inquiryRep;
	
	@Override
	public List<Inquiry> InquiryListByGatherNo(Long gatherNo) {
		return inquiryRep.InquiryListByGatherNo(gatherNo);
	}

	@Override
	public Inquiry selectByInquiryId(Long inqNo) {
		Inquiry inquiry=inquiryRep.findById(inqNo).orElse(null);
		if(inquiry==null) {
			throw new RuntimeException("문의 내용 찾을수 없어요 ");
		}
		
		return inquiry;
	}

	@Override
	public void insertInquiry(Inquiry inquiry) {
		inquiryRep.save(inquiry);
	}

	@Override
	public void deleteInquiry(Long inqNo) {
		Inquiry inq=inquiryRep.findById(inqNo).orElse(null);
		if(inq== null)
			throw new RuntimeException("문의번호 오류로 삭제 못함");
	
		inquiryRep.deleteById(inqNo);
	}
	
	/**
	 * 마이페이지에서 문의글 답변 달렸는지 상태확인
	 * */
	public List<SelectReplyState> selectReplyState(Long userNo){
		List<SelectReplyState> l=inquiryRep.selectReplyState(userNo);
		
		return l;
		
	}
	//문의수정
	public Inquiry updatedInquiry(Inquiry inquiry) {
		Inquiry inq=inquiryRep.findById(inquiry.getInqNo()).orElse(null);
		if(inq== null)
			throw new RuntimeException("문의번호 오류로 삭제 못함");
		
		inq.setInqContent(inq.getInqContent()); //내용만 수정
		
		return inq;
	}

}
