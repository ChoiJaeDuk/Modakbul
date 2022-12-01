package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.domain.InquiryReply;

public interface InquiryReplytService {

	/**
	 * 문의 번호에 해당하는 댓글 다 
	 * */
	List<InquiryReply> selectReplyByInquiryNo(Long inqNo);
	
	/**
	 * 문의 상세보기
	 * */
	InquiryReply selectByInquiryReplyNo(Long inquiryReplyNo);
	
	/**
	 * 문의 등록하기 ---문의 글 번호 받아야 되나용?
	 * */
	void insertInquiryReply(InquiryReply inquiryReply);
	/**
	 * 문의 삭제하기 
	 * */
	void deleteInquiryReply(Long inquiryReplyNo);
}
