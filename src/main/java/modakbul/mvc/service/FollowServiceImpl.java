package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.repository.FollowRepository;

@Service
@Transactional
@RequiredArgsConstructor
public class FollowServiceImpl implements FollowService {
	
	private final JPAQueryFactory queryfactory;
	private final FollowRepository followRep;

	@Override
	public Follow selectByUserId(Long userNo) {
		
		return followRep.selectByUserId(userNo);
	}

	@Override
	public void insert(Follow follow) {
		Follow resultFollow = followRep.save(follow);
		System.out.println("resultFollow = " + resultFollow);

	}

	@Override
	public void delete(Long followNo) {
		followRep.deleteById(followNo);

	}

}
