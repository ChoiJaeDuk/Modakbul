package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.repository.GatherRepository;
@Service
@RequiredArgsConstructor
@Transactional
@EnableScheduling
public class GatherServiceImpl implements GatherService {
	
	private final EntityManager em;
	
	private QGather g = QGather.gather;
	
	@Autowired
	private JPAQueryFactory queryFactory;
	
	private final GatherRepository gatherRep;
	
	@Override
	public void insertGather(Gather gather) {
		LocalDateTime grd = LocalDateTime.of(gather.getGatherRegisDate().toLocalDate(),gather.getGatherRegisDate().toLocalTime());
		LocalDateTime gatherRegisDate = LocalDateTime.of(grd.getYear(),grd.getMonth(), grd.getDayOfMonth(), grd.getHour(), grd.getMinute());
		gather.setGatherRegisDate(gatherRegisDate);
		gatherRep.save(gather);
	}
	
	@Override
	@Scheduled(cron = "0/20 * * * * *")//매시간 0분 30분마다 실행된다.
	public void autoUpdateGatherState() {
		List<Gather> gatherList = queryFactory.
				selectFrom(g)
				.where(g.gatherState.ne("진행완료").or(g.gatherState.ne("모임취소")))
				.fetch();
		//System.out.println(gatherList);
		
		for(Gather gather:gatherList) {
			LocalDateTime grd = LocalDateTime.of(gather.getGatherRegisDate().toLocalDate(),gather.getGatherRegisDate().toLocalTime());
			LocalDateTime gatherRegisDate = LocalDateTime.of(grd.getYear(),grd.getMonth(), grd.getDayOfMonth(), grd.getHour(), grd.getMinute());
			System.out.println("gatherRegisDate 시간변환 확인 = "+ gatherRegisDate);
			
			LocalDateTime dl = LocalDateTime.of(gather.getGatherDeadline().toLocalDate(),gather.getGatherDeadline().toLocalTime());
			LocalDateTime deadLine = LocalDateTime.of(dl.getYear(),dl.getMonth(), dl.getDayOfMonth(), dl.getHour(), dl.getMinute());
			System.out.println("deadLine 시간변환 확인 = "+ deadLine);
			
			
			
		}
		
//		LocalDateTime date1 = LocalDateTime.of(2022, 12, 4, 0, 8);
//		LocalDateTime now = LocalDateTime.now();
//		LocalDateTime ldt = LocalDateTime.of(now.getYear(),now.getMonth(), now.getDayOfMonth(), now.getHour(), now.getMinute());
//		boolean result = date1.isEqual(ldt);
//		
//		System.out.println(result);
		
	}

	@Override
	@org.springframework.transaction.annotation.Transactional(readOnly = false)
	public void updateGather(Gather gather) {
		Gather dbGather = gatherRep.findById(gather.getGatherNo()).orElse(null);
		
		if(dbGather==null) throw new RuntimeException("존재하지 않는 모임입니다.");
		
		if(!dbGather.getGatherState().equals("모집중")) throw new RuntimeException("모집중인 모임이 아닙니다."); 
		
		em.merge(gather);
	}

	@Override
	public Page<Gather> selectGatherList(boolean gatherType, List<Long> categoryList, String place, String sort, String search, Pageable pageable) {
				
		List<OrderSpecifier> ORDERS = gatherSort(pageable);
		
		BooleanBuilder builder = new BooleanBuilder();
		builder.and(g.gatherState.eq("모집중"));
		//일일, 정기모임 구분
		if(gatherType) {
			builder.and(g.regularGather.regularGatherNo.isNotNull()); // 정기모임
		}else {
			builder.and(g.regularGather.regularGatherNo.isNull()); //일일모임
		}
		
		if(categoryList!=null) builder.and(g.category.categoryNo.in(categoryList));
	
		//장소 검색
		if(search !=null) {
			builder.and(g.gatherName.contains(search));
		}
		
		if(place != null) {
			builder.and(g.gatherPlace.contains(place));
		}
		
		List<Gather> result = queryFactory
				.selectFrom(g)
				.where(builder)
				.orderBy(ORDERS.stream().toArray(OrderSpecifier[]::new))
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetch();//카테고리 체크박스
		
		return new PageImpl<Gather>(result, pageable, result.size());
	}
	
	
	

	@Override
	public Gather selectGatherByGatherNo(Long gatherNo) {
		Optional<Gather> op = gatherRep.findById(gatherNo);
		Gather gather = op.orElse(null);
		return gather;
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
	            switch (order.getProperty()) { 
	                case "gatherDeadline":
	                    OrderSpecifier<?> orderGatherDeadline = GatherServiceImpl.getSortedColumn(direction, QGather.gather, "gatherDeadline");
	                    ORDERS.add(orderGatherDeadline);
	                    break;
	                case "userTemper":
	                    OrderSpecifier<?> orderUserTemper = GatherServiceImpl.getSortedColumn(direction, QGather.gather.user, "temper");
	                    ORDERS.add(orderUserTemper);
	                    break;
	                case "likeCount":
	                    OrderSpecifier<?> orderLikeCount = GatherServiceImpl.getSortedColumn(direction, QGather.gather, "likeCount");
	                    ORDERS.add(orderLikeCount);
	                    break;
	                default:
	                    break;
	            }
	        }
	    }
	    return ORDERS;
	}

	@Override
	public void updateLikeCount(Long gatherNo, int likeCount) {
		Gather gather = gatherRep.findById(gatherNo).orElse(null);
		gather.setLikeCount(likeCount);
	}

	
	
	@Override
	public List<Long> gatherStateCount(Long userNo) {
		
//		List<String> gatherList = queryFactory
//				.select(g.gatherState)
//				.from(g)
//				.where(g.user.userNo.eq(userNo))
//				.fetch();
//		
//		
//		List<Tuple> result = queryFactory
//				.select(g.gatherState, g.gatherState.count())
//				.from(g)
//				.where(g.gatherState.in(gatherList))
//				.groupBy(g.gatherState)
//				.fetch();
//		
//		for(Tuple tuple:result) {
//			System.out.println(tuple.get(g.gatherState) + "/" + tuple.get(g.gatherState.count()));
//		}
//		return result;
		
		List<Long> countList = gatherRep.selectStateCount(userNo);
		return countList;
		
	}

	@Override
	public Page<Gather> selectGatherOrderByRegisDate(Pageable pageable) {
			
		List<Gather> result = queryFactory
				.selectFrom(g)
				.where(g.gatherState.eq("모집중"))
				.orderBy(g.gatherRegisDate.asc())
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetch();//카테고리 체크박스
		System.out.println("result = " + result);
		
		return new PageImpl<Gather>(result, pageable, result.size());
	}

	@Override
	public List<GatherGroupBy> selectGatherCountByMonth(Pageable pageable) {
		List<GatherGroupBy> list = gatherRep.selectGatherCountByMonth();
		
		return list;
			
	}

	@Override
	public Page<Gather> selectBidGatherappliList(Pageable pageable) {
		
		List<Gather> result = gatherRep.selectBidGatherappliList();
		
		return new PageImpl<Gather>(result, pageable, result.size());
	}
	
}
