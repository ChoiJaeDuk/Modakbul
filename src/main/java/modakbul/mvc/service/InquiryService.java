package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.Inquiry;

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
}
