package modakbul.mvc.lee;

import static org.mockito.ArgumentMatchers.anyByte;

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
	/**
	 * 나를 팔로우(구독자) 하는 사람들
	 */
	@org.junit.jupiter.api.Test
	public void myFollower() {
		List<Follow> list = followRep.myFollower(7L);
		System.out.println("userNo : 5L 의 팔로워 수 = " + list.size()+"명!");
	}
	
	/**
	 * 내가 팔로잉(구독한채널) 하는 사람들
	 */
	@org.junit.jupiter.api.Test
	public void myFollowing() {
		List<Follow> list = followRep.myFollwing(7L);
		System.out.println("구독한 채널의 수 = " + list.size()+"명!" );
	}
	
	/**.
	 * 팔로잉 목록 검색(제가 이사람 팔로잉 했나요?)
	 */
	@org.junit.jupiter.api.Test
	public void searchFollowing() {
		Follow follow = followRep.searchFollowing(8L, 1L);
		if(follow != null) System.out.println("8L님이 6L님을 구독했어요!!!");
		else System.out.println("8L님이 6L님을 구독 안했어요~~~");
	}
	
	
	/////////////////////////////////////////////////////////////

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
	
	@org.junit.jupiter.api.Test
	public void countGather() {
		int result = like.countLikeGather(5L);
		System.out.println("관심모임 갯수 = " + result);
	}
	
	@org.junit.jupiter.api.Test
	public void searchLikeGather() {
		LikeGather lg = like.searchLikeGather(53L, 7L);
		if(lg != null) System.out.println("10L 모임을 5L님이 관심등록 했어요!!!");
		else System.out.println("10L 모임을 5L님이 관심등록 안했어요~~");
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
	
	@org.junit.jupiter.api.Test
	public void unreadAlarms() {
		List<AlarmReceiver> list = alarmReceiverRep.unreadAlarms(7L);
		
		System.out.println("새로운 알림 : " + list.size()+"개");
		
		for(AlarmReceiver a : list) {
			//System.out.println("안읽은 메세지 : " + a.toString());
			//a.setAlarmStatus("읽음");
		}
	}
	
	///////////////////////////////////////////////////////////////////
	
	

}
