package modakbul.mvc.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import modakbul.mvc.domain.ServiceQuestion;
import modakbul.mvc.domain.Users;

public interface ServiceQuestionRepository extends JpaRepository<ServiceQuestion, Long>,QuerydslPredicateExecutor<ServiceQuestion> {
	
	@Query(value = "select * from service_question where user_no not in 4",nativeQuery = true)
	Page<ServiceQuestion> selectAll(Pageable pageable);
	
	@Query(value = "delete from service_question where service_question_no= ?1 and service_question_pwd=?2",nativeQuery = true)
	@Modifying
	void deleteServiceQuestion(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/**
	 * 어드민이 쓴 글(user_no=4)은 공지사항
	 * */
	@Query(value = "select * from service_question where user_No=4",nativeQuery = true)
	Page<ServiceQuestion> selectByAdminNo( Pageable pageable);
	
	@Query("select s from ServiceQuestion s where s.serviceQuestionNo=?1")
	ServiceQuestion selectNoticeDetail(Long serviceQuestionNo);
	
}
