package modakbul.mvc.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.UserReview;
import modakbul.mvc.repository.UserReviewRepository;

@Service
@Transactional
public class UserReviewServiceImpl implements UserReviewService {
	@Autowired
	private UserReviewRepository userReviewRep;
	
	@Autowired 
	private UsersService userService;

	@Override
	public Page<UserReview> selectAllByUserReviewNo(Long hostUserNo, Pageable pageable) {
		
		return userReviewRep.selectByUserReviewNo(hostUserNo,pageable);
	}

	@Override
	public void insert(UserReview userReview) {
		userReviewRep.save(userReview);
		userService.updateTemper(userReview.getHostUser().getUserNo(),userReview.getUserTemper()); //주최자 온도, 회원 온도

	}

	@Override
	public void delete(Long userReviewNo) {
		UserReview ur=userReviewRep.findById(userReviewNo).orElse(null);
		if(ur== null) {
			throw new RuntimeException("글번호 오류로 삭제 못함");
		}
		userReviewRep.deleteById(userReviewNo);
	}
	/**
	 * 회원 아이디별 상세
	 * */
	@Override
	public UserReview selectByUserReviewNo(Long userReviewNo) {
		UserReview userReview=userReviewRep.findById(userReviewNo).orElse(null);
		if(userReview==null)
			throw new RuntimeException("글번호 오류입니다.");
		return userReview;
	}

	

}
