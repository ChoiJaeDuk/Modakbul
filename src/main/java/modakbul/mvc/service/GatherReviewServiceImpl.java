package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.GatherReview;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.GatherReviewRepository;

@Service
@Transactional
public class GatherReviewServiceImpl implements GatherReviewService {
	
	@Autowired
	private GatherReviewRepository gatherReviewRep;
	
	/**
	 * 문의 전체
	 * */
	@Override
	public List<GatherReview> gatherReviewList() {
		return gatherReviewRep.findAll();
	}
	/**
	 * 등록
	 * */
	@Override
	public void insert(GatherReview gatherReview) {
		GatherReview resultReview=gatherReviewRep.save(gatherReview);
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
