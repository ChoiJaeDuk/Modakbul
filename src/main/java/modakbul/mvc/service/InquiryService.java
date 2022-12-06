package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.groupby.SelectReplyState;

public interface InquiryService {

	/**
	 * 모임번호에 해당하는 문의전체 띄우기(일일,정기 구분 x)
	 * */
	List<Inquiry> InquiryListByGatherNo(Long gatherNo);
	
	/**
	 * 문의 상세보기
	 * */
	Inquiry selectByInquiryId(Long inqNo);
	
	/**
	 * 문의 등록하기
	 * */
	void insertInquiry(Inquiry inquiry);
	/**
	 * 문의 삭제하기 
	 * */
	void deleteInquiry(Long inqNo);
	
	/**
	 * 마이페이지에서 문의글 답변 달렸는지 상태확인
	 * */
	List<SelectReplyState> selectReplyState(Long userNo);
	
	/**
	 * 문의 수정하기 
	 * */
	Inquiry updatedInquiry(Inquiry inquiry);
}
