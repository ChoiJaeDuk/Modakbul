package modakbul.mvc.service;

import javax.persistence.EntityManager;
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
	private final EntityManager em;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	//private final MailTest mail;
	
	@Override
	public void insert(Users user) {
		
		String encodedPassword = passwordEncoder.encode(user.getUserpwd());
		
		user.setUserpwd(encodedPassword);
		
		usersRep.save(user);

	}
	
	@Override
	public boolean emailCheck(String userEmail) {
		 
		
		// TODO Auto-generated method stub
		
		return false;
		
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
	public boolean nickCheck(String userNick) {
		Users user  = usersRep.nickCheck(userNick);
		
		if(user == null) return true;
		
		return false;
	}
	
	

	@Override
	@org.springframework.transaction.annotation.Transactional(readOnly = false)
	public Users update(Users user) {
		Users dbUser = usersRep.selectById(user.getUserId());
		
		if(dbUser == null)
			throw new RuntimeException("해당 아이디에 대한 오류로 수정할 수 없습니다.");
		
		if(user.getUserpwd() != null) {
			
			String encodedPassword = passwordEncoder.encode(user.getUserpwd());
			
			user.setUserpwd(encodedPassword);
		}
		
		/*
		 * dbUser.setUserPhone(user.getUserPhone());
		 * dbUser.setUserPostCode(user.getUserPostCode());
		 * dbUser.setUserAddr(user.getUserAddr());
		 * dbUser.setUserAddrDetail(user.getUserAddrDetail());
		 */	
		em.merge(user);

		return dbUser;
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
		
		 Users user = usersRep.selectById(userId);
		 if(!user.getUserEmail().equals(userEmail))
			 throw new RuntimeException("해당 정보에 맞는 회원이 없습니다.");
		 
		 

	}

	@Override
	public Users updateTemper(Long userNo, double temper) {
		//(평균매너온도 * 온도카운트 + 새로운 매너온도)/( 온도카운트+1)
		
		Users dbUser = usersRep.findById(userNo).orElse(null);
		double dbTemper = dbUser.getTemper() * dbUser.getTemperCount();
	
		dbUser.setTemperCount(dbUser.getTemperCount() + 1 );
		
		double newTemper =  (Math.round (((dbTemper + temper ) / dbUser.getTemperCount()) * 10)) / 10.0 ;
	

		dbUser.setTemper(newTemper);
		
		return dbUser;
	}
	

}
