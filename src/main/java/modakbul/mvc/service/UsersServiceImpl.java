package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UsersRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class UsersServiceImpl implements UsersService {
	
	private final UsersRepository usersRep;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public void insert(Users user) {
		String encodedPassword = passwordEncoder.encode(user.getUserpwd());
		user.setUserpwd(encodedPassword);
		
		usersRep.save(user);

	}

	@Override
	public Page<Users> selectAll(Pageable pageable) {
		
		return usersRep.findAll(pageable);
	}

	@Override
	public Users login(String userId, String userPwd) {
		
		return usersRep.login(userId, userPwd);
	
	}

	@Override
	public Users selectById(String userId) {
		
		return usersRep.selectById(userId);
	}

	@Override
	public Users update(Users user) {
		Users dbUser = usersRep.selectById(user.getUserId());
		
		if(dbUser == null)
			throw new RuntimeException("해당 아이디에 대한 오류로 수정할 수 없습니다.");
	
		
		
		
		return null;
	}

	@Override
	public void delete(Users user) {
		
		usersRep.deleteById(user.getUserNo());

	}

	@Override
	public String selectUserId(String userEmail) {
		String dbUserId = usersRep.selectUserId(userEmail);
		if(dbUserId == null)
			throw new RuntimeException("해당 이메일의 정보가 존재하지 않습니다.");
		return dbUserId;
		
	}

	@Override
	public void selectUserPwd(String userId, String userEmail) {
		
		 

	}

}
