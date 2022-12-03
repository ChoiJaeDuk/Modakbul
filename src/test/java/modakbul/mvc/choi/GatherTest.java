package modakbul.mvc.choi;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.test.annotation.Commit;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQueryFactory;

import modakbul.mvc.domain.Category;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.RegularGather;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.LikeGatherRepository;
import modakbul.mvc.service.GatherService;

@SpringBootTest
@Transactional
@Commit
@EnableScheduling
public class GatherTest {
	
	Users user = new Users(4L);
	Category category = new Category(3L);
	RegularGather regularGather = new RegularGather(1L);
	private QGather g = QGather.gather;
	@Autowired
	private JPAQueryFactory queryFactory;
	
	@Autowired
	private EntityManager em;
	
	@Autowired
	private GatherRepository gatherRep;
	
	@Autowired
	private LikeGatherRepository likeRep;
	
	@Autowired
	private GatherService gatherService;
	@Test
	void contextLoads() {
		System.out.println("gatherRep = " + gatherRep);
	}
	
	@Test
	void gatherInsert() {
		String sDate = "2022.11.10 20:00";
		String sDate2 = "2022.12.10 10:00";
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
		Gather gather = new Gather(3L, category, user, null, "코딩공부할사람~!!@@", 0, 4, "남녀모두", 20, 35, d, d2, 2, "경기도 성남시 오리역", "1층 카페", "즐겁게 공부하실분!", "진행완료", null , 0, null, 0);
		
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
		Gather gather = new Gather(7L, category, user, regularGather, "풋살할사람~!!!!", 10, 15, "남자", 20, 35, d, d2, 2, "성남시 야탑", "1층 풋살장", "매너있게 공찰분들 오세요!", "모집중", null , 0, null,0);

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
			Gather gather = new Gather(6L, category, user, regularGather, "풋살모집합니다", 12, 18, "남자", 20, 35, d, d2, 2, "성남시 야탑", "1층 풋살장", "매너있게 공찰분들 오세요!", "모집중", null , 0, null,0);
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
			boolean gatherType = false; //true이면 정기모임, false이면 일일모임
			String place = null;
			List<Long> categoryList= null;//java.util.Arrays.asList(1L);
			String sort = "userTemper";
		
			Pageable pageable = PageRequest.of(0, 5 , Direction.ASC, sort);
		
			List<OrderSpecifier> ORDERS = gatherSort(pageable);
		
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
			.orderBy(ORDERS.stream().toArray(OrderSpecifier[]::new))
			.fetch();//카테고리 체크박스
			
			for(Gather a:gatherList) {
				System.out.println("모임 = " + a);
			}
		}
		
		
		public static OrderSpecifier<?> getSortedColumn(Order order, Path<?> parent, String fieldName) {
		        Path<Object> fieldPath = Expressions.path(Object.class, parent, fieldName);
		        return new OrderSpecifier(order, fieldPath);
		}

		
		private List<OrderSpecifier> gatherSort(Pageable pageable) {
		    List<OrderSpecifier> ORDERS = new ArrayList<>();

		    if (!pageable.getSort().isEmpty()) {
		        for (Sort.Order order : pageable.getSort()) {
		            Order direction = order.getDirection().isAscending() ? Order.ASC : Order.DESC;
		            System.out.println("order.getDirection().isAscending() = " + order.getDirection().isAscending());
		            switch (order.getProperty()) { 
		                case "gatherDeadline":
		                    OrderSpecifier<?> orderGatherDeadline = GatherTest.getSortedColumn(direction, QGather.gather, "gatherDeadline");
		                    ORDERS.add(orderGatherDeadline);
		                    break;
		                case "userTemper":
		                    OrderSpecifier<?> orderUserTemper = GatherTest.getSortedColumn(direction, QGather.gather.user, "temper");
		                    ORDERS.add(orderUserTemper);
		                    break;
		                case "category":
		                    OrderSpecifier<?> orderLikeCount = GatherTest.getSortedColumn(direction, QGather.gather, "likeCount");
		                    ORDERS.add(orderLikeCount);
		                    break;
		                default:
		                    break;
		            }
		        }
		    }
		    return ORDERS;
		}
	
		
//		@Test
//		public void likeGatherCount() {
//			List<LikeGather> list = likeRep.selectLikeGatherCount();
//			for(LikeGather l : list) {
//				System.out.println("리스트 = " + l);
//			}
//		}
		
		
		@Test
		public void selectGatherList2() {
			boolean gatherType = false; //true이면 정기모임, false이면 일일모임
			String place = null;
			List<Long> categoryList= null;//java.util.Arrays.asList(1L);
			String sort = "userTemper";
		
			Pageable pageable = PageRequest.of(0, 5 , Direction.ASC, sort);
		
			List<OrderSpecifier> ORDERS = gatherSort(pageable);
		
			Page<Gather> page = gatherService.selectGatherList(gatherType, categoryList, place, sort, "",pageable);
			
			List<Gather> gatherList = page.getContent();
			gatherList.forEach(b->System.out.println(b));
			
		}
		
		@Test
		public void selectGatherByGatherNo() {
			Gather gather = gatherService.selectGatherByGatherNo(10L);
			System.out.println("gather = " + gather);
		}
		
		@Test
		public void selectGatherOrderByRegisDate() {
			Pageable pageable = PageRequest.of(0, 5 , Direction.DESC, "gatherRegisDate");
			Page<Gather> gather = gatherService.selectGatherOrderByRegisDate(pageable);
			System.out.println("gather = " + gather.getContent());
			
			for(Gather ga:gather.getContent()) {
				System.out.println(ga);
			}
		}
		
		
		@Test
		public void gatherStateCount() {
			List<Long> list = gatherService.gatherStateCount(1L);
			for(Long a:list) {
				System.out.println(a);
			}
			
		}
		
		
		@Test
		public void selectGatherCountByMonth() {
			Pageable pageable = PageRequest.of(0, 12);
			//Page<GatherGroupBy> list = gatherService.selectGatherCountByMonth(pageable);
			List<GatherGroupBy> gatherList = gatherService.selectGatherCountByMonth(pageable);
			
			for(GatherGroupBy b : gatherList) {
				System.out.println("interface = " + b.getGatherCount());
			}
		}
		
		
//		@Test
//		public void selectGatherOrderByRegisDate() {
//			Pageable pageable = PageRequest.of(0, 12, Direction.DESC, "gather");
//			gatherService.selectGatherOrderByRegisDate();
//		}
}

