package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.repository.AdvertisementRepository;

@Service
@Transactional
@EnableScheduling
public class AdvertisementServiceImpl implements AdvertisementService {
 
	@Autowired
	private AdvertisementRepository advertisementRep;

	/**
	 * 광고 등록
	 * */
	@Override
	public Advertisement advertisementInsert(Advertisement advertisement) {
		
		Advertisement resultAdvertisement = advertisementRep.save(advertisement);
		return resultAdvertisement;
		
	}
	
	/**
	 * 광고 상태 변경
	 * */
	@Override
	public Advertisement statusUpdate(Advertisement advertisement) {
		Advertisement statusUpdate = advertisementRep.findById(advertisement.getAdvertisementNo()).orElse(advertisement);
		if(statusUpdate==null)
			throw new RuntimeException("오류로 수정 불가");
		
		statusUpdate.setAdStatus(advertisement.getAdStatus());
		
		return statusUpdate;
	}
	
	/*
	@Override
	@Scheduled(cron = "* * 0 * * *")
	public void scheduledStatusUpdate(Advertisement advertisement) {
		
		LocalDateTime now = LocalDateTime.now();
		Date date = advertisement.getDeadLine();
		}
		*/
	
	/**
	 * 광고 배너 수정
	 * */
	@Override
	public Advertisement bannerUpdate(Advertisement advertisement) {
		Advertisement bannerUpdate = advertisementRep.findById(advertisement.getAdvertisementNo()).orElse(advertisement);
		if(bannerUpdate==null)
			throw new RuntimeException("오류로 수정 불가");
		
		bannerUpdate.setAdFileName(advertisement.getAdFileName());
		
		return bannerUpdate;
	}

	/**
     * 삭제하기
     * */
	@Override
	public void delete(Long advertisementNo) {
		Advertisement updateAdvertiserment = advertisementRep.findById(advertisementNo).orElse(null);
		if(updateAdvertiserment==null)
			throw new RuntimeException("오류로 삭제 불가");
		
		advertisementRep.deleteById(advertisementNo);
	}
	
	/**
	 * 전체 검색
	 * */
	@Override
	public List<Advertisement> selectAll() {
		return advertisementRep.findAll();
	}
	
	/**
	 * 페이징
	 * */
	@Override
	public Page<Advertisement> selectAll(Pageable pageable) {
		
		return advertisementRep.findAll(pageable);
	}


	

	

}
