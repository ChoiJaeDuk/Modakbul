package modakbul.mvc.service;

import modakbul.mvc.domain.Advertisement;

public interface AdvertisementService {
	
	/**
	 * 광고 등록
	 * */
	Advertisement advertisementInsert(Advertisement advertisement);
	
	/**
	 * 광고 배너 수정하기
	 * */
	Advertisement bannerUpdate(Advertisement advertisement);
    
	/**
	 * 광고 상태 변경
	 * */
	Advertisement statusUpdate(Advertisement advertisement);
	
	/**
	 * 광고 상태 Scheduled
	 * */
	void scheduledStatusUpdate(Advertisement advertisement);
    /**
     * 삭제하기
     * */
    void delete(Long advertisementNo);
}
