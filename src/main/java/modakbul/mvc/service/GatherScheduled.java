package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;

@Service
@EnableScheduling
public class GatherScheduled {
	
	@Autowired
	 private GatherServiceScheduled sche;
	
	
	@Scheduled(cron = "0 * * * * *") // 매시간 0분 30분마다 실행된다.
	// @Scheduled(cron = "0 * * * * *") // 1분마다 실행된다.
	public void autoUpdateGatherState() {
		List<Gather> gather =sche.autoUpdateGatherState();
		
		sche.test(gather);
	}// for문
}
