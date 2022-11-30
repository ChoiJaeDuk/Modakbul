package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Users;

@Service
@RequiredArgsConstructor
@Transactional
public class UsersServiceImpl implements UsersService {
	
	
	
	@Override
	public void insert(Users user) {
		// TODO Auto-generated method stub

	}

	@Override
	public Page<Users> selectAll(Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Users login(Users user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Users selectById(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Users update(Users user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Users user) {
		// TODO Auto-generated method stub

	}

	@Override
	public String selectUserId(String userEmail) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void selectUserPwd(String userId, String userEmail) {
		// TODO Auto-generated method stub

	}

}
