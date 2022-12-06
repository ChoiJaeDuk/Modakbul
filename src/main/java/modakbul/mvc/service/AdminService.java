package modakbul.mvc.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import modakbul.mvc.domain.Advertisement;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Users;

public interface AdminService {
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
   //void scheduledStatusUpdate(Advertisement advertisement);
   /**
    * 광고 상태 출력(광고중)
    * */
   List<Advertisement> selectByStatus1(Advertisement advertisement);
   /**
    * 광고 상태 출력(신청대기)
    * */
   List<Advertisement> selectByStatus2(Advertisement advertisement);
   /**
    * 광고 상태 출력(광고 종료)
    * */
   List<Advertisement> selectByStatus3(Advertisement advertisement);
   /**
     * 삭제하기
     * */
    void delete(Long advertisementNo);
    
    /**
     * 모임 조회
     * */
    List<Gather> selectGatherList();
    
    /**
     * 회원 조회
     * */
    List<Users> selectUsersList();
    
    /**
     * 광고 조회
     * */
    List<Advertisement> selectAll();
    
    /**
    * 모임 조회 - Page처리
    * */
   Page<Gather> selectGatherList(Pageable pageable);
   
   /**
    * 회원 조회 - Page처리
    * */
   Page<Users> selectUsersList(Pageable pageable);
   
   /**
    * 광고 조회 - Page처리
    * */
   Page<Advertisement> selectAll(Pageable pageable);
   
   /**
    * 1월 광고중
    * */
   List<Advertisement> selectAdStatusIng1(Advertisement advertisement);
   
   /**
    * 2월 광고중
    * */
   List<Advertisement> selectAdStatusIng2(Advertisement advertisement);
   
   /**
    * 3월 광고중
    * */
   List<Advertisement> selectAdStatusIng3(Advertisement advertisement);
   
   /**
    * 4월 광고중
    * */
   List<Advertisement> selectAdStatusIng4(Advertisement advertisement);
   
   /**
    * 5월 광고중
    * */
   List<Advertisement> selectAdStatusIng5(Advertisement advertisement);
   
   /**
    * 6월 광고중
    * */
   List<Advertisement> selectAdStatusIng6(Advertisement advertisement);
   
   /**
    * 7월 광고중
    * */
   List<Advertisement> selectAdStatusIng7(Advertisement advertisement);
   
   /**
    * 8월 광고중
    * */
   List<Advertisement> selectAdStatusIng8(Advertisement advertisement);
   
   /**
    * 9월 광고중
    * */
   List<Advertisement> selectAdStatusIng9(Advertisement advertisement);
   
   /**
    * 10월 광고중
    * */
   List<Advertisement> selectAdStatusIng10(Advertisement advertisement);
   
   /**
    * 11월 광고중
    * */
   List<Advertisement> selectAdStatusIng11(Advertisement advertisement);
   
   /**
    * 12월 광고중
    * */
   List<Advertisement> selectAdStatusIng12(Advertisement advertisement);
   
   /**
    * 모임 참가비 조회 1
    * */
   String selectGatherBid1(String gatherBid);
   
}