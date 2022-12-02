package modakbul.mvc.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.AdminRepository;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.UsersRepository;

@Service
@Transactional
@EnableScheduling
public class AdminServiceImpl implements AdminService {
 
	@Autowired
	private AdminRepository adminRep;
	@Autowired
	private GatherRepository gatherRepository;
	@Autowired
	private UsersRepository usersRepository;
	
	
	/**
	 * 모임 조회
	 * */
	@Override
	public List<Gather> selectGatherList() {
	
		return gatherRepository.findAll();
	}
	
	/**
	 * 회원 조회
	 * */
	@Override
	public List<Users> selectUsersList() {
		
		return usersRepository.findAll();
	}
	
	/**
	 * 광고 조회
	 * */
	@Override
	public List<Advertisement> selectAll() {
		return adminRep.findAll();
	}
	
	/**
	 * 모임 페이징
	 * */
	@Override
	public Page<Gather> selectGatherList(Pageable pageable) {
		// TODO Auto-generated method stub
		return gatherRepository.findAll(pageable);
	}
	
	/**
	 * 회원 페이징
	 * */
	@Override
	public Page<Users> selectUsersList(Pageable pageable) {
		// TODO Auto-generated method stub
		return usersRepository.findAll(pageable);
	}
	
	/**
	 * 광고 페이징
	 * */
	@Override
	public Page<Advertisement> selectAll(Pageable pageable) {
		
		return adminRep.findAll(pageable);
	}
	
	/**
	 * 광고 등록
	 * */
	@Override
	public Advertisement advertisementInsert(Advertisement advertisement) {
		
		Advertisement resultAdvertisement = adminRep.save(advertisement);
		return resultAdvertisement;
		
	}
	
	/**
	 * 광고 상태 변경
	 * */
	@Override
	public Advertisement statusUpdate(Advertisement advertisement) {
		Advertisement statusUpdate = adminRep.findById(advertisement.getAdvertisementNo()).orElse(advertisement);
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
		Advertisement bannerUpdate = adminRep.findById(advertisement.getAdvertisementNo()).orElse(advertisement);
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
		Advertisement updateAdvertiserment = adminRep.findById(advertisementNo).orElse(null);
		if(updateAdvertiserment==null)
			throw new RuntimeException("오류로 삭제 불가");
		
		adminRep.deleteById(advertisementNo);
	}
	

}
