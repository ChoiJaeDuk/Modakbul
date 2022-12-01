package modakbul.mvc.lim;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Role;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UsersRepository;
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
	
	
	
	@Test
	void contextLoads() {
		
		String encodedPassword = passwordEncoder.encode("1234");
		
		for(int i=15; i<=16; i++) {
			usersRep.save(
					Users.builder()
					.userId("user"+i)
					.userpwd(encodedPassword)
					.userName("회원"+i)
					.userNick("유저"+i)
					.userGender("여자")
					.userEmail("user"+i+"@gmail.com")
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
	}
	
	@Test
	public void selectAll() {
		List<Users> list = usersRep.findAll();
		
		list.forEach(b->System.out.println(b));
	}
	
	@Test
	public void login() {
		Users user = usersRep.login("user13", "1234");
		System.out.println(user.getUserName());
	}
	
	@Test
	public void selectById() {
		Users user = usersRep.selectById("jieun1234");
		System.out.println(user);
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

}
