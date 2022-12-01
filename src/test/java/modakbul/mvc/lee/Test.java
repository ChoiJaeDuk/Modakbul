package modakbul.mvc.lee;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.FollowRepository;

@SpringBootTest
@Commit
@Transactional
public class Test {
	
	@Autowired
	private FollowRepository followRep;
	
	@org.junit.jupiter.api.Test
	public void insertFollow() {
		System.out.println("followRep = " + followRep);
		/*
		 * followRep.save(Follow.builder() .followingUser(new Users(5L))
		 * .followerUser(new Users(6L)) .build() );
		 */
		
	}
}
