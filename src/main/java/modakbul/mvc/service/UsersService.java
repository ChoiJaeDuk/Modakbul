package modakbul.mvc.service;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.KakaoOAuthToken;
import modakbul.mvc.domain.KakaoProfile;
import modakbul.mvc.domain.Users;


public interface UsersService {
	
	/**
	 * 회원가입
	 * @param user
	 */
	void insert(Users user);
	
	/**
	 * 이메일인증코드전송
	 * @param userEamil
	 * @return
	 */
	String sendCode(String userEamil) throws Exception;
	
	//String checkCode(String code);
	
	/**
	 * 전체검색 - Page처리
	 * @param pageable
	 * @return
	 */
	Page<Users> selectAll(Pageable pageable, String job);
	
	/**
	 * 카카오로그인
	 * @param user
	 * @return
	 */
	HashMap<String, Object> kakaoLogin(String token) throws ParseException;

	
	KakaoOAuthToken getAccessToken(String code);
	
	/**
	 * 개인정보 조회,  아이디 중복체크
	 * @param userNo
	 * @return
	 */
	Users selectById(String userId);
	
	/**
	 * 닉네임중복체크
	 * @param userNick
	 * @return
	 */
	boolean nickCheck(String userNick);
	
	
	/**
	 * 개인정보 수정
	 * @param user
	 * @return
	 */
	void update(Users user);
	
	
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
	boolean selectUserPwd(String userId, String userEmail) throws Exception;
	
	/**
	 * 모닥불온도 업데이트
	 * @param userNo
	 * @param temper
	 */
	Users updateTemper(Long userNo, double temper);
	
	/***
	 * 검색어에 따른 유저 찾기
	 * @param keyword
	 * @return
	 */
	List<Users> selectByKeyword(String keyword);

}
