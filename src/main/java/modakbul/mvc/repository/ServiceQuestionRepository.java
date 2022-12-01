package modakbul.mvc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import modakbul.mvc.domain.ServiceQuestion;

public interface ServiceQuestionRepository extends JpaRepository<ServiceQuestion, Long> {
	
	@Query(value = "select* from service_question where service_question_no= ?1 and service_question_pwd=?2 order by service_question_no",nativeQuery = true)
	ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo,String serviceQuestionPwd);
	
	@Query(value = "delete from service_question where service_question_no= ?1 and service_question_pwd=?2",nativeQuery = true)
	@Modifying
	void deleteServiceQuestion(Long serviceQuestionNo,String serviceQuestionPwd);
	
	/*
	 * @Query(value =
	 * "update service_question set SERVICE_QUESTION_REPLY=?1 where service_question_no=?2"
	 * ,nativeQuery = true)
	 * 
	 * @Modifying void updateServiceQuestionReply(String serviceQuestionReply, Long
	 * serviceQuestionNo);
	 */
}
