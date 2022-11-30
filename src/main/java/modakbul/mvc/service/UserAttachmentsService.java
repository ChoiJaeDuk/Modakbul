package modakbul.mvc.service;

import modakbul.mvc.domain.UserAttachments;

public interface UserAttachmentsService {
	
	/**
	 * 회원첨부파일추가
	 * @param userAttachments
	 */
	void insert(UserAttachments userAttachments);
	
	/**
	 * 회원첨부파일수정
	 * @param userAttachments
	 */
	//void update(UserAttachments userAttachments);
	
	/**
	 * 회원첨부파일삭제
	 * @param userAttachmentsFileNo
	 */
	void delete(Long userAttachmentsFileNo);
}
