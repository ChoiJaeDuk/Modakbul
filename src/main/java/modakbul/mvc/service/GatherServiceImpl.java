package modakbul.mvc.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.QAdvertisement;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QGatherReview;
import modakbul.mvc.domain.QUserReview;
import modakbul.mvc.domain.QUsers;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.repository.GatherRepository;

@Service
@RequiredArgsConstructor
@Transactional
@EnableScheduling
//@EnableTransactionManagement
public class GatherServiceImpl implements GatherService {

	private final EntityManager em;

	private QGather g = QGather.gather;

	private QAdvertisement a = QAdvertisement.advertisement;

	private QUsers u = QUsers.users;

	private QUserReview ur = QUserReview.userReview;

	private QGatherReview gr = QGatherReview.gatherReview;

	@Autowired
	private ParticipantService participantService;

	@Autowired
	private JPAQueryFactory queryFactory;

	private final GatherRepository gatherRep;

	@Override
	public void insertGather(Gather gather) {
		gatherRep.save(gather);

	}
	boolean state = false;
	@Override
	@Scheduled(cron = "0 0,30 * * * *")//매시간 0분 30분마다 실행된다.
	//@Scheduled(cron = "0 * * * * *") // 20초마다 실행된다.
	public void autoUpdateGatherState() {		
		
		/////////////////////////////////
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime ldt = LocalDateTime.of(now.getYear(), now.getMonth(), now.getDayOfMonth(), now.getHour(),now.getMinute());

		// boolean result = date1.isEqual(ldt);
		List<Gather> gatherList = queryFactory.selectFrom(g).where(g.gatherState.in("모집중", "모집마감", "진행중")).fetch();
		System.out.println(gatherList.size());
		for (Gather gather : gatherList) {
			System.out.println(gather.getGatherNo());
			LocalDateTime grd = gather.getGatherDate();
			
			//시간은 0~23까지 표현되기 때문에 24가 넘어가면 -24를 빼주고 다음날로 넘긴다..
	
			LocalDateTime completeDate = grd.plusHours(gather.getGatherTime());
			System.out.println(completeDate);
			int i = participantService.selectParticipantCountByGatherNo(gather.getGatherNo());
			System.out.println("결과 = " + ldt.isEqual(gather.getGatherDeadline()));
			System.out.println("i = " + i +" / " + "최소인원: " + gather.getGatherMinUsers());
			if (ldt.isEqual(gather.getGatherDeadline())) {
				
				
				if (i < gather.getGatherMinUsers()) {
					gather.setGatherState("모임취소");
					participantService.autoUpdateParticipantState(gather.getGatherNo(), "인원미달", "참가승인");
				} else {
					gather.setGatherState("모집마감");
					participantService.autoUpdateParticipantState(gather.getGatherNo(), "참가확정", "참가승인");
				}
			} else if (ldt.isEqual(gather.getGatherDate())) {
				gather.setGatherState("진행중");
				participantService.autoUpdateParticipantState(gather.getGatherNo(), "참가중", "참가확정");
			} else if (ldt.isEqual(completeDate)) {
				gather.setGatherState("진행완료");
				participantService.autoUpdateParticipantState(gather.getGatherNo(), "참가완료", "참가중");
			}
		} // for문

	}

	@Override
	public void updateGather(Gather gather) {
		Gather dbGather = gatherRep.findById(gather.getGatherNo()).orElse(null);

		if (dbGather == null)
			throw new RuntimeException("존재하지 않는 모임입니다.");

		if (!dbGather.getGatherState().equals("모집중"))
			throw new RuntimeException("모집중인 모임이 아닙니다.");

		em.merge(gather);
	}

	@Override
	public Page<Gather> selectGatherList(boolean gatherType, List<Long> categoryList, String place, String sort,
			String search, Pageable pageable) {

		List<OrderSpecifier> ORDERS = gatherSort(pageable);

		BooleanBuilder builder = new BooleanBuilder();
		builder.and(g.gatherState.eq("모집중"));
		// 일일, 정기모임 구분
		if (gatherType) {
			builder.and(g.regularGather.regularGatherNo.isNotNull()); // 정기모임
		} else {
			builder.and(g.regularGather.regularGatherNo.isNull()); // 일일모임
		}

		if (categoryList != null)
			builder.and(g.category.categoryNo.in(categoryList));

		// 장소 검색
		if (search != null) {
			builder.and(g.gatherName.contains(search));
		}

		if (place != null) {
			builder.and(g.gatherPlace.contains(place));
		}

		List<Gather> result = queryFactory.selectFrom(g).where(builder)
				.orderBy(ORDERS.stream().toArray(OrderSpecifier[]::new)).offset(pageable.getOffset())
				.limit(pageable.getPageSize()).fetch();// 카테고리 체크박스

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
					OrderSpecifier<?> orderGatherDeadline = GatherServiceImpl.getSortedColumn(direction, QGather.gather,
							"gatherDeadline");
					ORDERS.add(orderGatherDeadline);
					break;
				case "userTemper":
					OrderSpecifier<?> orderUserTemper = GatherServiceImpl.getSortedColumn(direction,
							QGather.gather.user, "temper");
					ORDERS.add(orderUserTemper);
					break;
				case "likeCount":
					OrderSpecifier<?> orderLikeCount = GatherServiceImpl.getSortedColumn(direction, QGather.gather,
							"likeCount");
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

		List<Gather> result = queryFactory.selectFrom(g).where(g.gatherState.eq("모집중")).orderBy(g.gatherRegisDate.asc())
				.offset(pageable.getOffset()).limit(pageable.getPageSize()).fetch();// 카테고리 체크박스
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

	@Override
	public Page<Gather> selectNoneADGatherList(Long userNo, Pageable pageable) {
		List<Gather> result = queryFactory.select(g).from(g).leftJoin(a).on(g.gatherNo.eq(a.gather.gatherNo))
				.where(a.gather.gatherNo.isNull().and(g.user.userNo.eq(userNo))).offset(pageable.getOffset())
				.limit(pageable.getPageSize()).fetch();
		return new PageImpl<Gather>(result, pageable, result.size());
	}

	@Override
	public void updateGatherState(Long gaherNo, String state) {
		Gather gather = gatherRep.findById(gaherNo).orElse(null);

		gather.setGatherState(state);
	}

	@Override
	public Page<Gather> selectUnWriteReview(Long userNo) {
		List<Gather> result = queryFactory.select(g).from(g).join(u).on(g.user.userNo.eq(u.userNo)).leftJoin(gr)
				.on(u.userNo.eq(gr.hostUser.userNo)).where(gr.gatherReviewNo.isNull()).fetch();

		return null;
	}

}
