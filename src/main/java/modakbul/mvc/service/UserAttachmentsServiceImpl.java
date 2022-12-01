package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.repository.UserAttachmentsRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class UserAttachmentsServiceImpl implements UserAttachmentsService {
	
	private final UserAttachmentsRepository userAttachRep;
	private final UsersService usersService;

	@Override
	public void insert(UserAttachments userAttachments) {
		
		userAttachRep.save(userAttachments);
	}

//	@Override
//	public void update(UserAttachments userAttachments) {
//		// TODO Auto-generated method stub
//
//	}

	@Override
	public void delete(Long userAttachmentsFileNo) {
		
		userAttachRep.deleteById(userAttachmentsFileNo);

	}

}
