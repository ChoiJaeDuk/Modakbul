package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

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
 	Page<LikeGather> selectById(Long userNo, Pageable page);
	
	/**
	 * 등록 - 버튼 클릭시
	 */
	String insert(LikeGather likeGather) throws Exception;
	
	
	
	/**
	 * 삭제 - 버튼 클릭시
	 */
	String delete(Long gatherNo, Long userNo);
	
	/**
	 * 검색 - 단일객체
	 */
	LikeGather selectEle(Long gatherNo, Long userNo);
}
