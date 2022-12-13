package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.repository.GatherReviewRepository;

@Service
@Transactional
public class GatherReviewServiceImpl implements GatherReviewService {
	
	@Autowired
	private GatherReviewRepository gatherReviewRep;
	
	@Autowired 
	private UsersService userService;
	
	@Autowired
	private RegularGatherService regularGatherService;
	
	/**
	 * 문의 전체
	 * */
	@Override
	
	public Page<GatherReview> selectAllByRegularGatherNo(Long regularGatherNo,Pageable pageable) {
		
		Page<GatherReview> list = gatherReviewRep.selectAllByRegularGatherNo(regularGatherNo, pageable);
	
		return list;
	}
	/**
	 * 등록
	 * */
	@Override
	public void insert(GatherReview gatherReview) {
		GatherReview resultReview=gatherReviewRep.save(gatherReview);
		
		regularGatherService.updateGatherTemper(gatherReview.getRegularGather().getRegularGatherNo(),gatherReview.getGatherTemper()); //정기모임 번호, 모임온도
		userService.updateTemper(gatherReview.getHostUser().getUserNo(),gatherReview.getHostUser().getTemper()); //주최자 온도, 회원 온도
	}

	/**
	 * 삭제
	 * */
	@Override
	public void delete(Long gatherReviewNo) {
		GatherReview gatherReview=gatherReviewRep.findById(gatherReviewNo).orElse(null);
		if(gatherReview==null)
			throw new RuntimeException("글번호 오류로 삭제 못해요 ");
	}
	/**
	 * 리뷰 아이디별 상세
	 * */
	@Override
	public GatherReview selectByGatherReviewNo(Long gatherReviewNo) {
		GatherReview gatherReview=gatherReviewRep.findById(gatherReviewNo).orElse(null);
		if(gatherReview==null)
			throw new RuntimeException("글번호 오류입니다.");
		return gatherReview;
	}
}
