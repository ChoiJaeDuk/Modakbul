package modakbul.mvc.kyu;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.domain.Inquiry;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.UserReview;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.GatherReviewRepository;
import modakbul.mvc.repository.InquiryRepository;
import modakbul.mvc.repository.UserReviewRepository;

@SpringBootTest
@Commit
@Transactional
public class Test {
	
	@Autowired
	private GatherReviewRepository gatherReviewRep;
	
	@Autowired
	private UserReviewRepository userReviewRep;
	
	@Autowired
	private InquiryRepository inquiryRep;


	@org.junit.jupiter.api.Test
	public void contextLoads() {
		//모임후기에 13개 정도 레코드 추가
		for(int i=1; i<=3; i++) {
			gatherReviewRep.save(GatherReview.builder()
					.regularGather(new RegularGather(1L))
					.gatherTemper(10)
					.writerUser(new Users(2L))
					.hostUser(new Users(1L))
					.gatherReviewContent("내용"+i)
					.build()
					);
		}
	}
	
	@org.junit.jupiter.api.Test
	public void selectAllById() { 
		List<GatherReview> list=gatherReviewRep.selectAllByRegularGatherNo(1L);
		list.forEach(b->System.out.println(b));

	}
	
	@org.junit.jupiter.api.Test
	public void deleteGatherReview() {
		gatherReviewRep.deleteById(8L);
	}
	
	
	
	
	@org.junit.jupiter.api.Test
	public void insertUserReview() {
		for(int i=1; i<=2; i++) {
			userReviewRep.save(UserReview.builder()
					.writerUser(new Users(1L))
					.hostUser(new Users(3L))
					.userTemper(50)
					.userReviewContent("일일모임 테스즁 "+i)
					.build());
		}
	}
	
	@org.junit.jupiter.api.Test
	public void selectUserReview() {
		List<UserReview> urList=userReviewRep.selectByUserReviewNo(3L);
		urList.forEach(b->System.out.println(b.getUserReviewContent()));
	}
	@org.junit.jupiter.api.Test
	public void deleteuserReview() {
		userReviewRep.deleteById(9L);
	}
	
	@org.junit.jupiter.api.Test 
	void selectByUserReviewNo() {
		Optional<UserReview> dbUserReview=userReviewRep.findById(10L);
		UserReview userReview=dbUserReview.orElse(null);
		System.out.println(userReview.getUserReviewContent());
		System.out.println(userReview.getWriterUser().getUserName());
	}
	
	@org.junit.jupiter.api.Test
	public void insertInquiry() {
		for(int i=1; i<=2; i++) {
			inquiryRep.save(Inquiry.builder()
					.user(new Users(1L))
					.gather(new Gather(5L))
					.inqSubject("질문있어용"+i)
					.inqContent("질문내욤."+i)
					.build());
		}
	}
	
	@org.junit.jupiter.api.Test //전체 문의
	void selectInquiryByGatherNo() {
		List<Inquiry> list=inquiryRep.InquiryListByGatherNo(5L);
		list.forEach(b->System.out.println(b.getInqSubject()));
	}
	@org.junit.jupiter.api.Test//상세
	void selectByInquiryId() {
		Optional<Inquiry> optionInquiry=inquiryRep.findById(7L);
		Inquiry inquiry=optionInquiry.orElse(null);
		System.out.println(inquiry.getInqContent());
	}
	@org.junit.jupiter.api.Test
	void deleteInquiryId() {
		inquiryRep.deleteById(10L);
	}
}
