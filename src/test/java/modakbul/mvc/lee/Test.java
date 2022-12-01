package modakbul.mvc.lee;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.test.annotation.Commit;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.AlarmReceiverRepository;
import modakbul.mvc.repository.AlarmRepository;
import modakbul.mvc.repository.FollowRepository;
import modakbul.mvc.repository.LikeGatherRepository;

@SpringBootTest
@Commit
@Transactional
public class Test {
	@Autowired
	private FollowRepository followRep;

	@Autowired
	private AlarmRepository alarmRep;
	@Autowired
	private AlarmReceiverRepository alarmReceiverRep;

	@Autowired
	private LikeGatherRepository like;

	@org.junit.jupiter.api.Test
	public void insertFollow() {
		System.out.println("followRep = " + followRep);
		for (long i = 8L; i <= 9L; i++)
			followRep.save(Follow.builder().followingUser(new Users(7L)).followerUser(new Users(i)).build());
	}

	@org.junit.jupiter.api.Test
	public void deleteFollow() {
		for (long i = 1L; i <= 501; i += 50L) {
			followRep.deleteById(i);
		}
	}

	@org.junit.jupiter.api.Test
	public void inserLike() {
		for (Long i = 5L; i <= 6L; i++) {
			like.save(LikeGather.builder().gather(new Gather(i)).user(new Users(6L)).build());
		}
	}

	@org.junit.jupiter.api.Test
	public void selectLike() {
		List<LikeGather> gatherlist = like.selectByUserId(5L);
		for (LikeGather l : gatherlist) {
			System.out.println(l);
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	@org.junit.jupiter.api.Test
	public void insertAlarm() {
		Users sendUsers = new Users(1L);
		for(Long i=5L; i<=9L; i++) {
			alarmReceiverRep.save(AlarmReceiver.builder()
					.user(new Users(i))
					.alarm(alarmRep.save(Alarm.builder()
							.alarmSubject("참가가 신청되었습니다.")
							.alarmContent(sendUsers + "님이 참가를 승인했습니다.")
							.build()
							))
					.alarmStatus("안읽음")
					.build()
					);
		}
		
	}
	
	@org.junit.jupiter.api.Test
	public void selectAlarm() {
		Pageable pageable = PageRequest.of(0, 10, Direction.DESC,"ALARM_RECEIVE_NO");
		Page<AlarmReceiver> page = alarmReceiverRep.selectByUserId(6L,pageable);
		
		System.out.println("page.getNumber() = " + page.getNumber());
		System.out.println("page.getSize() = " + page.getSize());
		System.out.println("page.getTotalPages() = " + page.getTotalPages());
		System.out.println("page.hasPrevious() = " + page.hasPrevious());
		System.out.println("page.hasNext() = " + page.hasNext());
		System.out.println("page.getTotalElements() = " + page.getTotalElements());
		
		List<AlarmReceiver> list = page.getContent();
		list.forEach(b->System.out.println(b)); 
		list.forEach(a->a.setAlarmStatus("읽음"));
			
		
	}
	
	@org.junit.jupiter.api.Test
	public void deleteAlarm() {
		alarmReceiverRep.deleteById(1L);
	}
	
	@org.junit.jupiter.api.Test
	public void countNewAlarm() {
		int newAlarm = alarmReceiverRep.countNewAlarm(7L);
		System.out.println(newAlarm);
	}

}
