package modakbul.mvc.service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.QRegularGather;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.RegularGatherRepository;


@Service
@RequiredArgsConstructor
@org.springframework.transaction.annotation.Transactional
@EnableScheduling
public class RegularGatherServiceImpl implements RegularGatherService {

	private final EntityManager em;
	
	private QRegularGather rg = QRegularGather.regularGather;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	private final RegularGatherRepository regularGatherRep;
	private final GatherRepository gatherRep;
	
	@Override
	public RegularGather insertRegularGather(RegularGather regularGather) {
		RegularGather rg = regularGatherRep.save(regularGather);
		
		return rg;
	}

	
	@Override
	public void deleteRegularGather(Long regulrGatherNo) {
		regularGatherRep.deleteById(regulrGatherNo);
	}
	
	
	@Override
	public void updateRegularGather(RegularGather regularGather) {
		em.merge(regularGather);
	}
	
	
	@Override
	public void updateRegularGatherState(Long gatherNo, String state) {
		Gather gather = gatherRep.findById(gatherNo).orElse(null);
		Long regularGatherNo = gather.getRegularGather().getRegularGatherNo();
		RegularGather regularGather = regularGatherRep.findById(regularGatherNo).orElse(null);
		regularGather.setRegularGatherState(state);
	}
	

	@Override
	public void updateGatherTemper(Long regularGatherNo, double temper) {
		RegularGather regularGather = regularGatherRep.findById(regularGatherNo).orElse(null);
		double newTemper = (Math.round(regularGather.getGatherTemper() * regularGather.getGatherTemperCount() + temper)/(regularGather.getGatherTemperCount()+1)*10)/10.0;
		
		regularGather.setGatherTemper(newTemper);
		regularGather.setGatherTemperCount(regularGather.getGatherTemperCount()+1);
	}


	

	

}
