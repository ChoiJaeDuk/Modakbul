package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.ServiceQuestion;

public interface ServiceQuestionRepository extends JpaRepository<ServiceQuestion, Long>,QuerydslPredicateExecutor<ServiceQuestion> {
	
	//@Query(value = "select* from service_question where service_question_no= ?1 and service_question_pwd=?2 order by service_question_no",nativeQuery = true)
	//ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo,String serviceQuestionPwd, Long userNo);
	
	
	@Query(value = "delete from service_question where service_question_no= ?1 and service_question_pwd=?2",nativeQuery = true)
	@Modifying
	void deleteServiceQuestion(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/**
	 * 어드민이 쓴 글(user_no=4)은 공지사항
	 * */
	@Query(value = "select* from service_question where user_No=4 order by service_question_no",nativeQuery = true)
	List<ServiceQuestion> selectByAdminNo();
	
	
}
