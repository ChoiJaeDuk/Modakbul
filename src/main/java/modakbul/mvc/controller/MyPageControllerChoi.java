package modakbul.mvc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ch.qos.logback.core.Context;
import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Follow;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.groupby.ParticipantGroupBy;
import modakbul.mvc.groupby.SelectReplyState;
import modakbul.mvc.service.AdminService;
import modakbul.mvc.service.AlarmService;
import modakbul.mvc.service.FollowService;
import modakbul.mvc.service.GatherAttachmentsService;
import modakbul.mvc.service.GatherService;
import modakbul.mvc.service.InquiryService;
import modakbul.mvc.service.ParticipantService;
import modakbul.mvc.service.RegularGatherService;


@Controller
@RequestMapping("/my_page")
@RequiredArgsConstructor
public class MyPageControllerChoi {
	
	private final GatherService gatherService;
	private final RegularGatherService regularGatherService;
	private final GatherAttachmentsService gatherAttachmentsService;
	private final ParticipantService participantService;
	private final InquiryService inqService;
	private final FollowService followService;
	private final AlarmService alarmService;
	private final AdminService adminService;
	private final static int PAGE_COUNT=5;
	private final static int BLOCK_COUNT=4;
	@RequestMapping("/{url}")
	public void aa() {
		
	}
	
	@RequestMapping("/my_page_index/{userNo}")
	public ModelAndView main(@PathVariable Long userNo,@RequestParam(defaultValue = "1") int nowPage, HttpSession session) {
		ModelAndView mv= new ModelAndView();
		String path = session.getServletContext().getRealPath("/save");
		
		Pageable pageable = PageRequest.of(nowPage-1, PAGE_COUNT);//0부터 시작, PAGE_COUNT(10)개씩 뿌림, 정렬, 기준=bno
		//PageRequest pageRequest = PageRequest.of(0, 5);
		Page<SelectReplyState> list=inqService.selectReplyState(userNo, pageable);
		List<SelectReplyState> resultList1 = list.getContent();
		Long totalWaiting=list.getTotalElements();
		
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		Long selectMyGatherIng = adminService.selectMyGatherIng(userNo);
		Long selectMyGatherEnd = adminService.selectMyGatherEnd(userNo);
		
		List<ParticipantGroupBy> selectApplicationStateCount = participantService.selectApplicationStateCount(userNo);
		
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		 int temp = (nowPage - 1) % BLOCK_COUNT;
		 int startPage = nowPage - temp;
		 
		
		 mv.addObject("replyState", totalWaiting); 
		System.out.println(resultList1.size());
		
		 mv.setViewName("my_page/my_page_index");
		 mv.addObject("blockCount", BLOCK_COUNT);
		 mv.addObject("startPage",startPage);
		 mv.addObject("nowPage", nowPage);
		 
		 mv.addObject("followingList", followList);
		 mv.addObject("follower", follower.size());
		 mv.addObject("following", following.size());
		 mv.addObject("newAlarm", newAlarm);
		 mv.addObject("userNo", userNo);
		
		 mv.addObject("fileNames", fileNames);
		 
		 mv.addObject("selectApplicationStateCount", selectApplicationStateCount);
		 mv.addObject("selectMyGatherIng", selectMyGatherIng);
		 mv.addObject("selectMyGatherEnd", selectMyGatherEnd);
		 
		
		return mv;
	}
	
	
	@RequestMapping("/gatherAD/{url}")
	public void url(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		System.out.println("와이제?");
		
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> applicationList = participantService.selectApplicationStateByUserNo(userNo, "신청대기", pageable);
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("applicationList", applicationList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
		
		System.out.println("d = " + follower.size());
	}
	
	@RequestMapping("/gatherSelect/applicationList")
	public void selectApplicationList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> applicationList = participantService.selectApplicationStateByUserNo(userNo, "신청대기", pageable);
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		model.addAttribute("fileNames", fileNames);
		model.addAttribute("applicationList", applicationList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
		
		System.out.println("d = " + follower.size());

	}
	
	@RequestMapping("/gatherSelect/upcomingList")
	public void selectUpcomingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
	
		
		Page<Gather> upcomingList = participantService.selectApplicationStateByUserNo(userNo, "참가승인", pageable);

		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
	
		model.addAttribute("upcomingList", upcomingList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
		
		


	}
	
	
	@RequestMapping("/gatherSelect/participationList")
	public void selectparticipationList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
	
		
		
		Page<Gather> participationList = participantService.selectApplicationStateByUserNo(userNo, "참가완료", pageable);
	
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);

		model.addAttribute("participationList", participationList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);

	}
	
	
	@RequestMapping("/gatherSelect/waitingList")
	public void selectWaitingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> waitingList = gatherService.selectGatherStateByUserNo(pageable, userNo, "신청대기");
		
		System.out.println("waitingList = " + waitingList);
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);

		model.addAttribute("waitingList", waitingList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);

	}
	
	
	@RequestMapping("/gatherSelect/recruitingList")
	public void selectRecruitingList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		Page<GatherGroupBy> recruitingList = gatherService.selectRecruitingList(pageable, userNo);
		
		
		model.addAttribute("recruitingList", recruitingList);
		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);

	}
	
	@RequestMapping("/selectParticipant")
	@ResponseBody
	public Page<Participant>  selectParticipant(HttpServletRequest request,Long gatherNo, @RequestParam(defaultValue ="1") int nowPage){
		
		System.out.println("호출되니");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		Page<Participant> participantList = participantService.selectParticipantByGatherNo(gatherNo, pageable);
		
		/*List<Participant> test = participantList.getContent();
        List<Users> usersList =new ArrayList<Users>();
		
		for(Participant p:test) {
			usersList.add(p.getUser());
		}
		
		System.out.println("몇개 가져와? " + test.size());
		
		test.forEach(b->System.out.println(b.getApplicationState()));
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//map.put("participantList", participantList);
		//map.put("usersList", usersList);*/
		
		
		return participantList;
	
	}
	
	
	@RequestMapping("/gatherSelect/completionList")
	public void selectCompletionList(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		System.out.println("nowPage = " + nowPage );
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		
		Page<Gather> completionList = gatherService.selectGatherStateByUserNo(pageable, userNo, "진행완료");
		
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		
		model.addAttribute("completionList", completionList);

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
		System.out.println("F = " + following.size());


	}
	
	@RequestMapping("/gatherSelect/deleteParticipant")
	public String deleteParticipant(Long userNo, Long gatherNo, String url, RedirectAttributes redirect) {
		participantService.deleteParticipant(userNo, gatherNo);
		
		redirect.addAttribute("userNo", userNo);
		return "redirect:/my_page/gatherSelect/"+url;
		
	}
	
	@RequestMapping("/gatherSelect/deleteGather")
	public String deleteGather(Long gatherNo, Long regularGatherNo, Long userNo, RedirectAttributes redirect, HttpSession session) {
		
		System.out.println("regularGatherNo = " + regularGatherNo);
		String saveDir = session.getServletContext().getRealPath("/save");
		
		List<String> fileList = gatherService.selectGatherFile(gatherNo);
		for(String fileName: fileList) {
			String fn = saveDir +"/"+fileName;
			File file = new File(fn);
			file.delete();
		}
		
		gatherAttachmentsService.deleteGatherAttachments(gatherNo);
		
		if(regularGatherNo!=null) {
			regularGatherService.deleteRegularGather(regularGatherNo);
		}
		
		gatherService.deleteGather(gatherNo);
		redirect.addAttribute("userNo", userNo);
		
		
		return "redirect:/my_page/gatherSelect/waitingList";
	}
	
	@RequestMapping("/gatherSelect/cancelGather")
	public String cancelGather(Long userNo, Long gatherNo, int regularGatherState ,RedirectAttributes redirect) {
		
		if(regularGatherState == 0) {
			regularGatherService.updateRegularGatherState(gatherNo, "모임종료");
		}
		
		gatherService.updateGatherState(gatherNo, "모임취소");
		
		redirect.addAttribute("userNo", userNo);
		return "redirect:/my_page/gatherSelect/recruitingList";
	}
	
	
	
	@RequestMapping("/gatherAD/adApplication")
	public void adApplication(Model model, @RequestParam(defaultValue ="1") int nowPage, Long userNo, Long gatherNo, HttpSession session) {
		String path = session.getServletContext().getRealPath("/save");
		Pageable pageable = PageRequest.of((nowPage-1),PAGE_COUNT);
		int temp= (nowPage -1)%BLOCK_COUNT; 
		int startPage= nowPage-temp;
		
		File file = new File(path);
		String fileNames [] = file.list();
		
		//Gather gather=gatherService.selectGatherByGatherNo(gatherNo);
		Page<Gather> adApplicationList = gatherService.selectNoneADGatherList(userNo, pageable);
		
		model.addAttribute("adApplicationList", adApplicationList);
		//model.addAttribute("gather", gather);
		
		
		List<Follow> followList = followService.selectByUserId(userNo);
		List<Follow> following = followService.myFollower(userNo);
		List<Follow> follower = followService.myFollowing(userNo);
		int newAlarm = alarmService.countNewAlarm(userNo);
		

		model.addAttribute("blockCount", BLOCK_COUNT);
		model.addAttribute("startPage",startPage); 
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("fileNames", fileNames);
		
		model.addAttribute("followingList", followList);
		model.addAttribute("follower", follower.size());
		model.addAttribute("following", following.size());
		model.addAttribute("newAlarm", newAlarm);
		model.addAttribute("userNo", userNo);
	}
	
	@ResponseBody
	@RequestMapping("/updateApplicationState")
	public void updateApplicationState(HttpServletRequest request,Long gatherNo, Long userNo) {
		System.out.println("업데이트 잘 됐니?");
		String state = request.getParameter("state");
		participantService.updateApplicationState(userNo, gatherNo, state);
		System.out.println("업데이트 잘 됐니?");
		
	}

	
}
