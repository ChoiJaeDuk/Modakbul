package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.ServiceQuestion;

public interface ServiceQuestionService {
	/**
	 * 회원이 문의사항게시판에 쓴 글 전체보기
	 * */
	Page<ServiceQuestion> selectAll(Pageable pageable);
	/**
	 * 문의 사항게시판에 글쓰기
	 * */
	void insertServiceQustion(ServiceQuestion serviceQuestion);
	
	/**
	 * 문의 사항 상세보기
	 * */
	ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo,String serviceQuestionPwd,Long userNo);
	
	/**
	 * 삭제하기
	 * */
	void deleteServiceQuestion(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/**
	 * 문의에 댓글달리면 날짜랑 댓글 내용업뎃 
	 * */
	void updateServiceQuestionReply(ServiceQuestion serviceQuestion);

	/**
	 * 어드민이 쓴 글(user_no=4)은 공지사항
	 * */
	Page<ServiceQuestion> selectByAdminNo(Pageable pageable);
	
	/**공지사항상세보기*/
	ServiceQuestion selectNoticeDetail(Long serviceQuestionNo);
	
	ServiceQuestion selectByNo(Long serviceQuestionNo);
}
