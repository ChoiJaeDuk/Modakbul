package modakbul.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import modakbul.mvc.domain.Alarm;
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.service.AlarmService;

@Controller
@RequestMapping("/alarm")
public class AlarmController {
	
	@Autowired
	private AlarmService alarmService;
	
	private final static int PAGE_COUNT=10;
	private final static int BLOCK_COUNT=4;
	
	/**
	 * 회원의 알람 리스트 출력
	 *  - 안읽은 알람 읽음처리
	 */
	@RequestMapping("/myAlarm")
	public ModelAndView myAlarm(Long userNo, @RequestParam(defaultValue = "1") int nowPage) {
		System.out.println("누구의 알람목록 ? " + userNo);
		
		Pageable page = PageRequest.of((nowPage - 1), PAGE_COUNT, Direction.DESC, "ALARM_RECEIVE_NO");
		Page<AlarmReceiver> pageList = alarmService.selectByUserId(userNo, page);

		int temp = (nowPage - 1) % BLOCK_COUNT;
		int startPage = nowPage - temp;

		ModelAndView mv = new ModelAndView();
		mv.setViewName("lee/views/my-page/alarmList");
		mv.addObject("pageList", pageList);

		mv.addObject("blockCount", BLOCK_COUNT);
		mv.addObject("startPage", startPage);
		mv.addObject("nowPage", nowPage);
		
		return mv;

	}
	
	/**
	 * 알람 & 알람리시버 등록
	 */
	@RequestMapping("/insert")
	public String insert(Long userNo) {
		Alarm alarm = Alarm.builder()
				.alarmSubject("참가 신청이 승인되었습니다.")
				.alarmContent("주최자가 신청을 승인했습니다.")
				.build();
		

		return "redirect:/alarm/myAlarmuserNo=";
	}
	
	/**
	 * 알람리시버 삭제
	 */
	@RequestMapping("/delete")
	public String delete(Long receiverNo) {
		alarmService.deleteReceiver(receiverNo);
		
		return "redirect:/alarm/myAlarm?userNo=";
	}
	
	/**
	 * 회원의 안읽은 알람 갯수
	 */
	@RequestMapping("/newAlarm")
	public ModelAndView countNewAlarm(Long userNo) {
		
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("안읽은 알람들?");
		mv.addObject("newAlarm", newAlarm);
		
		return mv;
	}
	
	/**
	 * 안읽은 알람 리스트 & 갯수 
	 */
	@RequestMapping("/unreadAlarm")
	public ModelAndView unreadAlarms(Long userNo) {
		
		List<AlarmReceiver> list = alarmService.unreadAlarms(userNo);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("안읽은 알람들?");
		mv.addObject("unreadList", list);
		
		
		return mv;
	}
}
