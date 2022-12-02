package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.ServiceQuestion;

public interface ServiceQuestionService {
	/**
	 * 문의사항게시판에 글 전체보기
	 * */
	List<ServiceQuestion> selectAllByServiceQuestionNo();
	/**
	 * 문의 사항게시판에 글쓰기
	 * */
	void insertServiceQustion(ServiceQuestion serviceQuestion);
	
	/**
	 * 문의 사항 상세보기
	 * */
	ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/**
	 * 삭제하기
	 * */
	void deleteServiceQuestion(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/**
	 * 문의에 댓글달리면 업뎃 
	 * */
	void updateServiceQuestionReply(ServiceQuestion serviceQuestion);

}
