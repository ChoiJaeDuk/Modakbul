package modakbul.mvc.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public List<Follow> selectByUserId(Long userNo) {
		
		return followRep.selectByUserId(userNo);
	}

	@Override
	public String insert(Follow follow) {
		Follow resultFollow = followRep.save(follow);
		System.out.println("resultFollow = " + resultFollow);
		
		return "ok";

	}

	@Override
	public String delete(Long follower, Long follwing) {
		System.out.println("서비스 왔?");
		Follow f = followRep.searchFollowing(follower, follwing);
		
		followRep.deleteById(f.getFollowNo());
		
		return "ok";

	}

	@Override
	public List<Follow> myFollower(Long userNo) {
		List<Follow> list = followRep.myFollower(userNo);
		
		//if(list.isEmpty()) throw new RuntimeException("팔로워 수를 불러올 수 없습니다.");
			
		return list;
	}

	@Override
	public List<Follow> myFollowing(Long userNo) {
		List<Follow> list = followRep.myFollwing(userNo);
		
		//if(list.isEmpty()) throw new RuntimeException("팔로잉 수를 불러올 수 없습니다.");
		
		return list;
	}

	@Override
	public String searchFollowing(Long follower, Long following) {
		Follow follow = followRep.searchFollowing(follower, following);
		
		if(follow==null) {
			return "no";
		}
		
		return "yes";
	}

}
