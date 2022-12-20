package modakbul.mvc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.apache.tomcat.jni.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.QUserAttachments;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UserAttachmentsRepository;

@Service
@RequiredArgsConstructor
@org.springframework.transaction.annotation.Transactional
public class UserAttachmentsServiceImpl implements UserAttachmentsService {
	
	private final UserAttachmentsRepository userAttachRep;
	//private final UsersService usersService;
	private final EntityManager em;
	
	private QUserAttachments ua = QUserAttachments.userAttachments;
	
	@Autowired
	private JPAQueryFactory queryFactory;

	@Override
	public void insert(UserAttachments userAttachments) {
		
		
		userAttachRep.save(userAttachments);
	}

	@Override
	@org.springframework.transaction.annotation.Transactional
	public void update(UserAttachments userAttachments) {
		
		em.merge(userAttachments);

	}

	@Override
	public List<UserAttachments> delete(Long userAttachmentsFileNo) {
		Users user = userAttachRep.selectUser(userAttachmentsFileNo);
		userAttachRep.deleteById(userAttachmentsFileNo);
		 
		 
		 System.out.println("user1 = " + user);
		 List<UserAttachments> list = userAttachRep.selectById(user);
		 System.out.println("size + " + list.size());
		 return list;
	}
	
	@Override
	public List<UserAttachments> selectAll(Users user) {
		
		return userAttachRep.selectById(user);
		
	}
	
	@Override
	public UserAttachments selectByNo(Long userAttachmentsFileNo) {
		//UserAttachments s =
		return  userAttachRep.findById(userAttachmentsFileNo).orElse(null);
		
	}

	@Override
	public List<UserAttachments> selectUserAttachmentsByUserNo(Long userNo) {
		
		List<UserAttachments> fileList = queryFactory.selectFrom(ua)
				.where(ua.user.userNo.eq(userNo)).fetch();
		
		return fileList;
	}

}
