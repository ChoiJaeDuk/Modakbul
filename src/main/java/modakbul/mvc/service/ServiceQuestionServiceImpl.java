package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.QServiceQuestion;
import modakbul.mvc.domain.ServiceQuestion;
import modakbul.mvc.repository.ServiceQuestionRepository;

@Service
@org.springframework.transaction.annotation.Transactional
public class ServiceQuestionServiceImpl implements ServiceQuestionService {
	@Autowired
	private ServiceQuestionRepository serviceQuestionRep;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	@Autowired
	private AlarmService alarmService;
	
	@Override
		public Page<ServiceQuestion> selectAll(Pageable pageable) {

		return serviceQuestionRep.selectAll(pageable);
		}
	@Override
	public void insertServiceQustion(ServiceQuestion serviceQuestion) {
		serviceQuestionRep.save(serviceQuestion);
	}

	@Override
	public ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo, String serviceQuestionPwd,Long userNo) {

		QServiceQuestion serviceQusetion = QServiceQuestion.serviceQuestion;
		
		BooleanBuilder builder = new BooleanBuilder();
		
		ServiceQuestion dbServiceQueestion=serviceQuestionRep.findById(serviceQuestionNo).orElse(null);
		if(dbServiceQueestion == null)
			throw new RuntimeException("글번호 오류로 검색불가");
		
		
		
		if((serviceQuestionPwd!=null)) {
			if(!dbServiceQueestion.getServiceQuestionPwd().equals(serviceQuestionPwd))
				throw new RuntimeException("비번 오류요 ");
			builder.and(serviceQusetion.serviceQuestionPwd.eq(serviceQuestionPwd));
		}
		
		builder.and(serviceQusetion.serviceQuestionNo.eq(serviceQuestionNo));
		
		queryFactory.select(serviceQusetion).from(serviceQusetion).where(builder);
		
		
		return dbServiceQueestion;
	}

	@Override
	public void deleteServiceQuestion(Long serviceQuestion, String serviceQuestionPwd) {
		ServiceQuestion dbServiceQuestion=serviceQuestionRep.findById(serviceQuestion).orElse(null);
		if(dbServiceQuestion==null)
			throw new RuntimeException("글번호 오류로 삭제 못함요");
		if(!dbServiceQuestion.getServiceQuestionPwd().equals(serviceQuestionPwd))
			throw new RuntimeException("비번오류로 삭제 할 수 없어요 ");
		
		serviceQuestionRep.deleteById(serviceQuestion);
	}
	
	@Override
	public void updateServiceQuestionReply(ServiceQuestion serviceQuestion) {
		ServiceQuestion dbServiceQuestion=serviceQuestionRep.findById(serviceQuestion.getServiceQuestionNo()).orElse(null);
		if(dbServiceQuestion==null)
			throw new RuntimeException("글번호 오류로 댓글 등록못함");
		
		dbServiceQuestion.setServiceQuestionReply(serviceQuestion.getServiceQuestionReply());
		
		
		String alarmSubject = "문의 답변 완료";
		String alarmContent = "관리자가 답변을 남겼습니다.";
		Alarm alarm = new Alarm(0L, alarmSubject, alarmContent, null);
		
		
		alarmService.insertReceiverOne(dbServiceQuestion.getUser(), alarm);
		//serviceQuestionRep.updateServiceQuestionReply(serviceQuestionReply,serviceQuestionNo);
		
	}
	
	
	@Override
	public Page<ServiceQuestion> selectByAdminNo( Pageable pageable) {	
		Page<ServiceQuestion> adminList=serviceQuestionRep.selectByAdminNo(pageable);
		
		return adminList;
	}
	@Override
	public ServiceQuestion selectNoticeDetail(Long serviceQuestionNo) {
		ServiceQuestion dbServiceQuestion=serviceQuestionRep.selectNoticeDetail(serviceQuestionNo);
		
		return dbServiceQuestion;
	}
	@Override
	public ServiceQuestion selectByNo(Long serviceQuestionNo) {
		ServiceQuestion serviceQuestion= serviceQuestionRep.findById(serviceQuestionNo).orElse(null);
		return serviceQuestion;
	}
	
	
	

}
