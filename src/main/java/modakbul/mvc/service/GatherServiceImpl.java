package modakbul.mvc.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.repository.GatherRepository;
@Service
@RequiredArgsConstructor
@Transactional
@EnableScheduling
public class GatherServiceImpl implements GatherService {
	
	private final EntityManager em;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	private final GatherRepository gatherRep;
	
	@Override
	public void insertGather(Gather gather) {
		gatherRep.save(gather);
	}

	@Override
	@Scheduled(cron = "0 0/30 * * * *")//30분마다 실행된다.
	public void updateGatherState() {
		
	}

	@Override
	@org.springframework.transaction.annotation.Transactional(readOnly = false)
	public void updateGather(Gather gather) {
		Gather dbGather = gatherRep.findById(gather.getGatherNo()).orElse(null);
		
		if(dbGather==null) throw new RuntimeException("존재하지 않는 모임입니다.");
		
		if(!dbGather.getGatherState().equals("모집중")) throw new RuntimeException("모집중인 모임이 아닙니다."); 
		
		Gather findGather = em.find(Gather.class, gather.getGatherNo());
		findGather.setGatherName(gather.getGatherName());
		findGather.setGatherComment(gather.getGatherComment());
		findGather.setGatherDate(gather.getGatherDate());
		findGather.setGatherDeadline(gather.getGatherDeadline());
		findGather.setGatherMinAge(gather.getGatherMinAge());
		findGather.setGatherMaxAge(gather.getGatherMaxAge());
		findGather.setGatherMinUsers(gather.getGatherMinUsers());
		findGather.setGatherBid(gather.getGatherBid());
		findGather.setGatherImg(gather.getGatherImg());
		findGather.setGatherPlace(gather.getGatherPlace());
		findGather.setGatherPlaceDetail(gather.getGatherPlaceDetail());
		findGather.setGatherSelectGender(gather.getGatherSelectGender());	
		findGather.setGatherTime(gather.getGatherTime());
	}

	@Override
	public List<Gather> selectGatherList(int regularGatherNo, int categoryNo, String sort, Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Gather selectGatherByGatherNo(int gatherNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Gather> selectADGatherList(List<Long> adList) {
		// TODO Auto-generated method stub
		return null;
	}

}
