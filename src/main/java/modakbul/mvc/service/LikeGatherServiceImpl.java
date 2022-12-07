package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.UserAttachments;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.LikeGatherRepository;

@Service
@Transactional
@RequiredArgsConstructor
public class LikeGatherServiceImpl implements LikeGatherService {
	
	private final JPAQueryFactory queryfactory;
	private final LikeGatherRepository likeGatherRep;

	@Override
	public List<LikeGather> selectAll() {
		return likeGatherRep.findAll();
	}
	
	@Override
	public List<LikeGather> selectById(Long userNo) {
		
		return likeGatherRep.selectByUserId(userNo);
	}

	@Override
	public void insert(LikeGather likeGather) {
		LikeGather resultLikeGather = likeGatherRep.save(likeGather);
		if(resultLikeGather == null) throw new RuntimeException("관심모임 등록에 실패했습니다.");
		System.out.println("resultLikeGather = " + resultLikeGather);

	}

	@Override
	public void delete(Long gatherNo, Long userNo) {
		
		LikeGather lg = likeGatherRep.searchLikeGather(gatherNo, userNo);
		likeGatherRep.deleteById(lg.getAttentionNo());
		

	}
	
	@Override
	public LikeGather selectEle(Long gatherNo, Long userNo) {
		LikeGather lg = likeGatherRep.searchLikeGather(gatherNo, userNo);
		return lg;
	}

	

}
