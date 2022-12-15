package modakbul.mvc.kyu;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.GatherReviewReply;
import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.domain.InquiryReply;
import modakbul.mvc.domain.ServiceQuestion;
import modakbul.mvc.domain.UserReview;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.SelectReplyState;
import modakbul.mvc.repository.GatherReviewReplyRepository;
import modakbul.mvc.repository.GatherReviewRepository;
import modakbul.mvc.repository.InquiryReplyRepository;
import modakbul.mvc.repository.InquiryRepository;
import modakbul.mvc.repository.ServiceQuestionRepository;
import modakbul.mvc.repository.UserReviewRepository;
import modakbul.mvc.service.GatherReviewService;
import modakbul.mvc.service.InquiryReplytService;
import modakbul.mvc.service.InquiryService;
import modakbul.mvc.service.ServiceQuestionService;
import modakbul.mvc.service.UserReviewService;

@SpringBootTest
@Commit
@Transactional
public class Test {

	@Autowired
	private GatherReviewRepository gatherReviewRep;
	
	@Autowired
	private GatherReviewService gatherReviewSer;

	@Autowired
	private UserReviewRepository userReviewRep;
	
	@Autowired
	private UserReviewService userReviewSer;

	@Autowired
	private InquiryRepository inquiryRep;

	@Autowired
	private ServiceQuestionRepository serviceQuestionRep;

	@Autowired
	private InquiryReplyRepository inquiryReplyRep;
	@Autowired
	private InquiryReplytService inquiryReplySer;

	@Autowired
	private GatherReviewReplyRepository gatherReviewReplyRep;

	@Autowired
	private ServiceQuestionService sqservice;

	@Autowired
	private InquiryService inqSer;
	
	

	@org.junit.jupiter.api.Test
	public void contextLoads() {
		// 모임후기에 13개 정도 레코드 추가
		for (int i = 1; i <= 3; i++) {
		//	gatherReviewRep.save(GatherReview.builder().regularGather(new RegularGather(1L)).gatherTemper(10)
		//			.writerUser(new Users(2L)).hostUser(new Users(1L)).gatherReviewContent("내용" + i).build());
		}
	}

	@org.junit.jupiter.api.Test
	public void selectAllById() {
		
		Pageable pageable = PageRequest.of(0, 5);
		
		Page<GatherReview> list = gatherReviewSer.selectAllByRegularGatherNo(1L,pageable);
		List<GatherReview> review = list.getContent();
		System.out.println(list);
		//review.forEach(b -> System.out.println(b));

	}

	@org.junit.jupiter.api.Test
	public void deleteGatherReview() {
		gatherReviewRep.deleteById(8L);
	}

	@org.junit.jupiter.api.Test
	public void insertUserReview() {
		/*for (int i = 1; i <= 2; i++) {
			userReviewRep.save(UserReview.builder().writerUser(new Users(2L)).hostUser(new Users(4L)).userTemper(50)
					.userReviewContent("테스트re" + i).build());
		}*/
		UserReview userReview = UserReview.builder().writerUser(new Users(2L)).hostUser(new Users(4L)).userTemper(50)
		.userReviewContent("회원에게 후기 남기기 들어가니?").build();
		
		userReviewSer.insert(userReview);
	}

	@org.junit.jupiter.api.Test
	public void selectUserReview() {
		Pageable pageable = PageRequest.of(0, 5);
		
		Page<UserReview> list = userReviewSer.selectAllByUserReviewNo(1L,pageable);
		List<UserReview> review = list.getContent();
		System.out.println(list);
	}

	@org.junit.jupiter.api.Test
	public void deleteuserReview() {
		userReviewRep.deleteById(9L);
	}

	@org.junit.jupiter.api.Test
	void selectByUserReviewNo() {
		Optional<UserReview> dbUserReview = userReviewRep.findById(10L);
		UserReview userReview = dbUserReview.orElse(null);
		System.out.println(userReview.getUserReviewContent());
		System.out.println(userReview.getWriterUser().getUserName());
	}

	@org.junit.jupiter.api.Test
	public void insertInquiry() {
		for (int i = 1; i <= 1; i++) {
			inquiryRep.save(Inquiry.builder()
					.inqNo(999L)
					.user(new Users(1L))
					.gather(new Gather(68L))
					.inqSubject("질문있어용" + i)
					.inqContent("질문내욤." + i)
					.build());
		}
	}

	@org.junit.jupiter.api.Test // 전체 문의
	void selectInquiryByGatherNo() {
		Pageable pageable = PageRequest.of(0, 5,Direction.DESC, "INQ_NO");
		
		Page<Inquiry> page = inqSer.InquiryListByGatherNo(5L, pageable);
		List<Inquiry> list = page.getContent();
		list.forEach(b -> System.out.println(b.getInqSubject()));
		
		list.forEach(b -> System.out.println(b.getInqSubject() + "//" + b.getUser().getUserNick()));
		System.out.println(page);
	
	}

	@org.junit.jupiter.api.Test // 상세
	void selectByInquiryId() {
		Optional<Inquiry> optionInquiry = inquiryRep.findById(7L);
		Inquiry inquiry = optionInquiry.orElse(null);
		System.out.println(inquiry.getInqContent());
	}

	@org.junit.jupiter.api.Test
	void deleteInquiryId() {
		inquiryRep.deleteById(10L);
	}

	/////////////////////// servicequestion
	@org.junit.jupiter.api.Test
	void insertServiceQuestion() {
		/*for (int i = 2; i <= 5; i++) {
			serviceQuestionRep.save(ServiceQuestion.builder().user(new Users(4L)).serviceQuestionContent("공지사항 내용" + i)
					.serviceQuestionSubject("공지사항 제목테스틍" + i).serviceQuestionPwd("admin").build());
		}*/
		ServiceQuestion serviceQuestion = ServiceQuestion.builder().user(new Users(3L)).serviceQuestionContent("1:1문의 테스트")
				.serviceQuestionSubject("1:1문의 테스트").serviceQuestionPwd("admin").build();
		
		sqservice.insertServiceQustion(serviceQuestion);
	
	}

	@org.junit.jupiter.api.Test
	void selectAll() {
		Pageable pageable = PageRequest.of(0, 5,Direction.DESC,"SERVICE_QUESTION_NO");
		
		Page<ServiceQuestion> li = serviceQuestionRep.selectAll(pageable);
		List<ServiceQuestion> list = li.getContent();
		list.forEach(b -> System.out.println(b.getServiceQuestionSubject()));
	}

	@org.junit.jupiter.api.Test
	void selectByServiceQuestionNo() {
		ServiceQuestion sq = sqservice.selectByServiceQuestionNo(22L, null,4L); //
		System.out.println(sq.getServiceQuestionContent());
		System.out.println(sq.getServiceQuestionSubject());
		System.out.println(sq.getUser().getUserNick());
	}

	@org.junit.jupiter.api.Test
	void deleteServiceQuestion() {
		serviceQuestionRep.deleteServiceQuestion(5L, "1234");
	}

	// 댓글
	@org.junit.jupiter.api.Test
	void insertReply() {
		for (int i = 2; i <= 6; i++) {
			inquiryReplyRep.save(InquiryReply.builder().inquiry(new Inquiry(3L)).inquiryReplycontent("우아" + i)
					.user(new Users(5L)).build());
		}
	}

	@org.junit.jupiter.api.Test
	void selectInquiryReply() {
		
		Pageable pageable = PageRequest.of(0, 5,Direction.DESC,"INQUIRY_REPLY_NO");

		Page<InquiryReply> li = inquiryReplySer.selectReplyByInquiryNo(3L,pageable);
		List<InquiryReply> replyList=li.getContent();
		
		replyList.forEach(b -> System.out.println(b.getInquiryReplycontent() + "//" + b.getUser().getUserNick()));
		System.out.println(li);
		System.out.println();
	}

	// 모임댓글
	@org.junit.jupiter.api.Test
	void insertGatherReply() {
		for (int i = 1; i <= 3; i++) {
			gatherReviewReplyRep.save(GatherReviewReply.builder().gatherReview(new GatherReview(10L))
					.gatherReplyContent("문의댓글입니다" + i).user(new Users(5L)).build());
		}
	}

	// 문의사항 게시판에 댓글 달리면
	@org.junit.jupiter.api.Test
	void updateServiceQuestionReply() {
		sqservice.updateServiceQuestionReply(
				ServiceQuestion.builder().serviceQuestionNo(61L).serviceQuestionReply("알람테스트").build());
		// serviceQuestionRep.updateServiceQuestionReply("댓글 테22",9L);
	}

	// 어드민이 ServiceQuestion등록한 글 리스트
	@org.junit.jupiter.api.Test
	void selectByAdminNo() {
		Pageable pageable = PageRequest.of(0, 5,Direction.DESC,"SERVICE_QUESTION_NO");

//		Page<ServiceQuestion> page = serviceQuestionRep.selectByAdminNo(4L,pageable);
//		List<ServiceQuestion> adminList=page.getContent();
//		adminList.forEach(b -> System.out.println(b.getUser().getUserNick() + "//" + b.getServiceQuestionContent()));
	}

	// 마이페이지에서 답변유무 상태 확인 ---------------ㅋ 못함요
	@org.junit.jupiter.api.Test
	void selectReplyState() {

		int nowPage=1;
		Pageable pageable = PageRequest.of(nowPage-1,7);

		//List<SelectReplyState> result= inquiryRep.selectReplyState(1L);
		Page<SelectReplyState> list = inqSer.selectReplyState(1L,pageable);
		//List<SelectReplyState> list=result.getContent();
		//int pageSize=list.getSize();
	
		

		list.forEach(b->System.out.println(b.getGatherName()));
		
	}
	
	//문의 수정 
	@org.junit.jupiter.api.Test
	void updatedInquiry() {
		Inquiry dbinq=inquiryRep.findById(6L).orElse(null);
		
		dbinq.setInqContent("4564576");
	}
	
	
}
