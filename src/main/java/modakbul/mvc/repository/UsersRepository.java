package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import modakbul.mvc.domain.Users;

public interface UsersRepository extends JpaRepository<Users, Long> {

	/**
	 * 로그인
	 * */
	@Query("select u from Users u where u.userId=?1 and u.userpwd=?2")
	Users login(String userId, String userPwd);
	
	/**
	 * 개인정보 조회,  아이디 중복체크
	 * */
	@Query("select u from Users u where u.userId=?1")
	Users selectById(String userId);
	
	/**
	 * 아이디찾기
	 * */
	@Query("select u.userId from Users u where u.userEmail=?1")
	String selectUserId(String userEamil);
	
	
}
