package modakbul.mvc.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import modakbul.mvc.domain.Advertisement;

public interface AdminRepository extends JpaRepository<Advertisement, Long>, QuerydslPredicateExecutor<Advertisement> {

   /**
    * 광고 상태 출력
    */ 
   @Query(value = "select * from advertisement where ad_status = '광고중'",nativeQuery = true)
   List<Advertisement> selectByStatus1(Advertisement advertisement);
   /**
    * 광고 상태 출력
    */ 
   @Query(value = "select * from advertisement where ad_status = '신청대기'",nativeQuery = true)
   List<Advertisement> selectByStatus2(Advertisement advertisement);
   /**
    * 광고 상태 출력
    */ 
   @Query(value = "select * from advertisement where ad_status = '광고종료'",nativeQuery = true)
   List<Advertisement> selectByStatus3(Advertisement advertisement);
}