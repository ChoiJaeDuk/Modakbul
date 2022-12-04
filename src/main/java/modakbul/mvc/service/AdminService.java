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
   
}