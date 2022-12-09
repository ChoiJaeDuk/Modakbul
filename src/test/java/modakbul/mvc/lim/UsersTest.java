package modakbul.mvc.lim;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Role;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UsersRepository;
import modakbul.mvc.service.MailSendService;
import modakbul.mvc.service.UsersService;

@SpringBootTest
@Commit
@Transactional
public class UsersTest {
	
	@Autowired
	private UsersRepository usersRep;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private UsersService service;
	
	@Autowired
	private MailSendService mailSender;
	
	private final static int PAGE_COUNT = 5;
	private final static int BLOCK_COUNT=4;
	
	
	
	@Test
	void contextLoads() {
		
		String encodedPassword = passwordEncoder.encode("1234");
		
	
			usersRep.save(
					Users.builder()
					.userId("aj3338@nate.com")
					.userpwd(encodedPassword)
					.userName("임지민")
					.userNick("지민")
					.userGender("여자")
					.userEmail("aj3338@nate.com")
					.userValidateNo("32333")
					.userPhone("122231")
					.userPostCode("1231")
					.userAddr("경기도 성남시 분당구")
					.userAddrDetail("알파리움")
					.userJob("개인")
					.state(Role.ROLE_USER)
					.build()
					
					);
		
	}
	
	@Test
	public void selectAll() {
		List<Users> list = usersRep.findAll();
		
		list.forEach(b->System.out.println(b));
	}
	
	@Test
	public void selectAllByPage() {
		int nowPage=4;
		Pageable page = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.DESC, "userNo");
		
		//Page<Users> list = usersRep.findAll(page);
		
		int temp = (nowPage-1)%BLOCK_COUNT;
		
		int startPage = nowPage-temp;

		//System.out.println("개수" + list.getTotalElements());


		System.out.println("blockCount = " + BLOCK_COUNT + "/" + "startPage = " + startPage + "/" + "nowPage = " + nowPage);
		//list.forEach(b->System.out.println(b));
		Page<Users> pageList = service.selectUsers(page, null, null);
		pageList.forEach(b->System.out.println(b));
	}
	
	@Test
	public void login() {
		Users user = usersRep.login("user13", "1234");
		System.out.println(user.getUserName());
	}
	
	@Test
	public void selectById() {
		Users user = usersRep.selectById("user1");
		System.out.println("userNo = " + user.getUserNo() + "follow = " + user.getFollowingList().size());
	}
	
	@Test
	public void selectUserId() {
		String userId = usersRep.selectUserId("jieun3604@gmail.com");
		System.out.println(userId);
	}
	
	@Test
	public void updateTemper() {
		
		Users db =service.updateTemper(4L, 59);
		System.out.println(db.getTemper() + "/" + db.getTemperCount());
		
	}
	
	@Test
	public void sendMail() throws Exception {
		String code=mailSender.sendSimpleMessage("aj3338@naver.com", "join");
		System.out.println("code = " + code);
	}
	
	@Test
	public void selectUserPwd() throws Exception {
		
		service.selectUserPwd("jieun1234", "jieun3604@gmail.com");
		
	}

	@Test
	public void selectByKeyword(){
		//List<Users> list = usersRep.selectByKeyword("유저");
		List<Users> list = usersRep.findByUserNickContaining("저");
		list.forEach(b->System.out.println(b));
	}
}
