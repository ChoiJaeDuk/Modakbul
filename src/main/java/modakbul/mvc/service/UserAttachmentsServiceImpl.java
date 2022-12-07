package modakbul.mvc.service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UserAttachmentsRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class UserAttachmentsServiceImpl implements UserAttachmentsService {
	
	private final UserAttachmentsRepository userAttachRep;
	//private final UsersService usersService;
	private final EntityManager em;

	@Override
	public void insert(UserAttachments userAttachments) {
		
		userAttachRep.save(
				UserAttachments.builder()
				.user(userAttachments.getUser())
				.userAttachmentsFileSubject(userAttachments.getUserAttachmentsFileSubject())
				.userAttachmentsFileName(userAttachments.getUserAttachmentsFileName())
				.build()

				);
	}

	@Override
	@org.springframework.transaction.annotation.Transactional
	public void update(UserAttachments userAttachments) {
		
		em.merge(userAttachments);

	}

	@Override
	public void delete(Long userAttachmentsFileNo) {
		
		userAttachRep.deleteById(userAttachmentsFileNo);

	}

}
