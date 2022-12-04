package modakbul.mvc.choi;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.test.annotation.Commit;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.Tuple;
import com.querydsl.jpa.impl.JPAQueryFactory;

import modakbul.mvc.domain.Category;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.LikeGather;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QLikeGather;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.service.GatherService;

@SpringBootTest
@Transactional
@Commit
@EnableScheduling
public class GatherTest {
	
	Users user = new Users(2L);
	Category category = new Category(3L);
	RegularGather regularGather = new RegularGather(1L);
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	@Autowired
	private EntityManager em;
	
	@Autowired
	private GatherRepository gatherRep;
	
	@Autowired
	private GatherService gatherService;
	@Test
	void contextLoads() {
		System.out.println("gatherRep = " + gatherRep);
	}
	
	@Test
	void gatherInsert() {
		String sDate = "2022.12.09 20:00";
		String sDate2 = "2022.12.09 10:00";
		SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd hh:mm");
		Date d = null;
		Date d2 = null;
		try {
			d = date.parse(sDate);
			d2 = date.parse(sDate2);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Gather gather = new Gather(1L, category, user, null, "코딩공부할사람~!", 0, 4, "남녀모두", 20, 35, d, d2, 2, "성남시 오리역", "1층 카페", "즐겁게 공부하실분!", "모집중", null , 0, null);
		gatherRep.save(gather);
	}
	
	@Test
	public void selectGather() {
		Optional<Gather> op = gatherRep.findById(8L);
		Gather gather = op.orElse(null);
		System.out.println(gather);
	}
	
	
	//이거는 새로 insert해준다.
	@Test
	@org.springframework.transaction.annotation.Transactional(readOnly = false)
	public void insertNewGather() {
		String sDate = "2022.12.09 20:00";
		String sDate2 = "2022.12.09 10:00";
		SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd hh:mm");
		Date d = null;
		Date d2 = null;
		try {
			d = date.parse(sDate);
			d2 = date.parse(sDate2);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Gather gather = new Gather(7L, category, user, regularGather, "풋살할사람~!!!!", 10, 15, "남자", 20, 35, d, d2, 2, "성남시 야탑", "1층 풋살장", "매너있게 공찰분들 오세요!", "모집중", null , 0, null);

		em.merge(gather);
	}
	
	

		@Test
		@org.springframework.transaction.annotation.Transactional
		public void updateGather() {
			String sDate = "2022.12.09 20:00";
			String sDate2 = "2022.12.09 10:00";
			SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd hh:mm");
			Date d = null;
			Date d2 = null;
			try {
				d = date.parse(sDate);
				d2 = date.parse(sDate2);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Gather gather = new Gather(6L, category, user, regularGather, "풋살모집합니다", 12, 18, "남자", 20, 35, d, d2, 2, "성남시 야탑", "1층 풋살장", "매너있게 공찰분들 오세요!", "모집중", null , 0, null);
			//Gather findGather = gatherRep.findById(gather.getGatherNo()).orElse(null);
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
	
		
		@Test
		public void selectGatherList() {
			boolean gatherType = true; //true이면 정기모임, false이면 일일모임
			String place = null;
			List<Long> categoryList= java.util.Arrays.asList(1L);
			
			
			QGather g = QGather.gather;
			BooleanBuilder builder = new BooleanBuilder();
			
			//일일, 정기모임 구분
			if(gatherType) {
				builder.and(g.regularGather.regularGatherNo.isNotNull()); // 정기모임
			}else {
				builder.and(g.regularGather.regularGatherNo.isNull()); //일일모임
			}
			
			if(categoryList!=null) builder.and(g.category.categoryNo.in(categoryList));
		
			//장소 검색
			if(place != null) {
				builder.and(g.gatherPlace.contains(place));
			}
			
			List<Gather> gatherList = queryFactory
			.selectFrom(g)
			.where(builder)
			.fetch();//카테고리 체크박스
			
			for(Gather a:gatherList) {
				System.out.println("모임 = " + a);
			}
		}
		
	
		
		@Test
	      public void likeGatherCount() {
	         QLikeGather likeGather = QLikeGather.likeGather;
	         List<LikeGather> likeGatherList;
	         List<Tuple> list = queryFactory
	               .select(likeGather.gather.gatherNo, likeGather.gather.gatherNo.count())
	               .from(likeGather)
	               .groupBy(likeGather.gather.gatherNo)
	               .fetch();
	         
	         
	         for(int i=0;i<list.size();i++) {
	            Tuple t = list.get(i);
	            
	             
	            //likeGatherList.add(new LikeGather(new Gather()));
	         }
	         
	      }
	
}
