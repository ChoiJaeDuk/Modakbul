package modakbul.mvc.service;

import java.util.List;

import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.Users;

public interface LikeGatherService {
	
	/**
	 * 전체검색 - 아마 안쓰지 않나?
	 */
	List<LikeGather> selectAll();
	
	/**
	 *  유저아이디별로 검색 - 마이페이지에서 띄우니까
	 */
	LikeGather selectById(Long userNo);
	
	/**
	 * 등록 - 버튼 클릭시
	 */
	void insert(LikeGather likeGather);
	
	
	
	/**
	 * 삭제 - 버튼 클릭시
	 */
	void delete(Long attentionNo);
}
