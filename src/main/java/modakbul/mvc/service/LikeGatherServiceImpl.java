package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
	public Page<LikeGather> selectById(Long userNo, Pageable page) {
		
		return likeGatherRep.selectByUserId(userNo, page);
	}

	@Override
	public String insert(LikeGather likeGather) {
		LikeGather dbLg = likeGatherRep.searchLikeGather(likeGather.getGather().getGatherNo(), likeGather.getUser().getUserNo());
		
		if(dbLg != null)return "fail";
		
		LikeGather resultLikeGather = likeGatherRep.save(likeGather);
		
		if(resultLikeGather == null) {
			System.out.println("인서트 오류");
			return "fail";
		}
		return "ok";
	}

	@Override
	public String delete(Long gatherNo, Long userNo) {
		
		LikeGather lg = likeGatherRep.searchLikeGather(gatherNo, userNo);
		
		System.out.println("서비스에서 삭제할 항목 = " + lg.getAttentionNo());
		
		likeGatherRep.deleteById(lg.getAttentionNo());
		
		return "ok";
	}
	
	@Override
	public LikeGather selectEle(Long gatherNo, Long userNo) {
		LikeGather lg = likeGatherRep.searchLikeGather(gatherNo, userNo);
		return lg;
	}

	

}
