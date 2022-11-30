package modakbul.mvc.lim;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Users;
import modakbul.mvc.users.repository.UsersRepository;

@SpringBootTest
@Commit
@Transactional
public class UsersTest {
	
	@Autowired
	private UsersRepository usersRep;
	
	@Autowired
	private PasswordEncoder passwordEncorder;
	
	@Test
	void contextLoads() {
		
		//  usersRep.save( Users.builder().build());
		
		for(int i=1; i<=105; i++) {
			usersRep.save(
					Users.builder()
					.build()
					
					
					
					);
		}
	}
	

}
