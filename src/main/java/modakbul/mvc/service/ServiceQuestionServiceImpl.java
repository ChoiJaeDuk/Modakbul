package modakbul.mvc.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.ServiceQuestion;
import modakbul.mvc.repository.ServiceQuestionRepository;

@Service
@Transactional
public class ServiceQuestionServiceImpl implements ServiceQuestionService {
	@Autowired
	private ServiceQuestionRepository serviceQuestionRep;
	
	@Override
		public List<ServiceQuestion> selectAllByServiceQuestionNo() {

		return serviceQuestionRep.findAll();
		}
	@Override
	public void insertServiceQustion(ServiceQuestion serviceQuestion) {
		serviceQuestionRep.save(serviceQuestion);
	}

	@Override
	public ServiceQuestion selectByServiceQuestionNo(Long serviceQuestionNo, String serviceQuestionPwd) {
		ServiceQuestion dbServiceQueestion=serviceQuestionRep.findById(serviceQuestionNo).orElse(null);
		if(dbServiceQueestion == null)
			throw new RuntimeException("글번호 오류로 검색불가");
		if(!dbServiceQueestion.getServiceQuestionPwd().equals(serviceQuestionPwd))
			throw new RuntimeException("비번 오류요 ");
		
		
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
		
		//serviceQuestionRep.updateServiceQuestionReply(serviceQuestionReply,serviceQuestionNo);
		
	}
	
	
	@Override
	public List<ServiceQuestion> selectByAdminNo() {	
		List<ServiceQuestion> adminList=serviceQuestionRep.selectByAdminNo();
		return adminList;
	}

	

}
