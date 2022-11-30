package modakbul.mvc.lim;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UsersRepository;

@SpringBootTest
@Commit
@Transactional
public class UsersTest {
	
	@Autowired
	private UsersRepository usersRep;
	
	
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
	
	@Test
	public void selectAll() {
		List<Users> list = usersRep.findAll();
		
		list.forEach(b->System.out.println(b));
	}
	

}
