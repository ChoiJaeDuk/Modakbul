package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;

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
	void update(UserAttachments userAttachments);
	
	/**
	 * 회원첨부파일삭제
	 * @param userAttachmentsFileNo
	 */
	List<UserAttachments> delete(Long userAttachmentsFileNo);
	
	/**
	 * 해당유저에 모든 증명서
	 * @param user
	 * @return
	 */
	List<UserAttachments> selectAll(Users user);
	
	/**
	 * 파일번호에 해당하는 증명서
	 * @param userAttachmentsFileNo
	 * @return
	 */
	UserAttachments selectByNo(Long userAttachmentsFileNo);
}
