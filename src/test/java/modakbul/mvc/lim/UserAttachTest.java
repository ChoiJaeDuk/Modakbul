package modakbul.mvc.lim;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UserAttachmentsRepository;
import modakbul.mvc.service.UserAttachmentsService;

@SpringBootTest
@Commit
@Transactional
public class UserAttachTest {
	
	@Autowired
	private UserAttachmentsRepository userAttach;
	
	@Autowired
	private UserAttachmentsService service;
	
	
	@Test
	public void insert() {
		
		for(int i=1; i<=3; i++) {
			userAttach.save(
					UserAttachments.builder()
					.user(new Users(2L))
					.userAttachmentsFileSubject("자격증")
					.userAttachmentsFileName("fff.hwp")
					.build()
	
					);
		}
	}
	
	@Test
	public void update() {
		service.update(new UserAttachments(1L, new Users(2L), "hello.hwp", "증명서"));
	}

	
	@Test
	void selectTest() {
		List<UserAttachments> list = service.selectUserAttachmentsByUserNo(1L);
		
		System.out.println(list.size());
		
	}
}
