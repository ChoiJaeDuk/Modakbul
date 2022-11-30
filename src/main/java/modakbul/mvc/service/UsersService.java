package modakbul.mvc.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.Users;


public interface UsersService {
	
	/**
	 * 회원가입
	 * @param user
	 */
	void insert(Users user);
	
	
	/**
	 * 전체검색 - Page처리
	 * @param pageable
	 * @return
	 */
	Page<Users> selectAll(Pageable pageable);
	
	/**
	 * 로그인
	 * @param user
	 * @return
	 */
	Users login(Users user);
	
	/**
	 * 개인정보 조회,  아이디 중복체크
	 * @param userNo
	 * @return
	 */
	Users selectById(String userId);
	
	
	/**
	 * 개인정보 수정
	 * @param user
	 * @return
	 */
	Users update(Users user);
	
	
	/**
	 * 회원탈퇴
	 * @param user
	 */
	void delete(Users user);
	
	/**
	 * 아이디찾기
	 * @param userEmail
	 * @return
	 */
	String selectUserId(String userEmail);
	
	/**
	 * 비밀번호찾기
	 * @param userId
	 * @param userEmail
	 * @return
	 */
	void selectUserPwd(String userId, String userEmail);
	

}
