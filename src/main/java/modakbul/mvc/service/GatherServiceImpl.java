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
import modakbul.mvc.domain.AlarmReceiver;
import modakbul.mvc.domain.Gather;
import modakbul.mvc.domain.Participant;
import modakbul.mvc.domain.QAdvertisement;
import modakbul.mvc.domain.QGather;
import modakbul.mvc.domain.QGatherReview;
import modakbul.mvc.domain.QParticipant;
import modakbul.mvc.domain.QUserReview;
import modakbul.mvc.domain.Users;
import modakbul.mvc.groupby.GatherGroupBy;
import modakbul.mvc.repository.GatherAttachmentsRepository;
import modakbul.mvc.repository.GatherRepository;
import modakbul.mvc.repository.RegularGatherRepository;

@Service
@RequiredArgsConstructor
@Transactional
@EnableScheduling
//@EnableTransactionManagement
public class GatherServiceImpl implements GatherService {

	private final EntityManager em;

	private QGather g = QGather.gather;

	private QAdvertisement a = QAdvertisement.advertisement;

	private QUserReview ur = QUserReview.userReview;

	private QGatherReview gr = QGatherReview.gatherReview;
	
	private QParticipant p = QParticipant.participant;
	
	

	@Autowired
	private ParticipantService participantService;
	
	private AlarmService alarmService;

	@Autowired
	private JPAQueryFactory queryFactory;

	private final GatherRepository gatherRep;
	
	private final GatherAttachmentsRepository gatherAttachementsRep;
	
	private final RegularGatherRepository regularGatherRep;
	
	
	
	@Override
	public void insertGather(Gather gather) {
		
		gatherRep.save(gather);
	}
	
	
	@Override
	@Scheduled(cron = "0 0,30 * * * *")//매시간 0분 30분마다 실행된다.
	//@Scheduled(cron = "0 * * * * *") // 1분마다 실행된다.
	public void autoUpdateGatherState() {		
		
		/////////////////////////////////
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime ldt = LocalDateTime.of(now.getYear(), now.getMonth(), now.getDayOfMonth(), now.getHour(),now.getMinute());

		// boolean result = date1.isEqual(ldt);
		List<Gather> gatherList = queryFactory.selectFrom(g).where(g.gatherState.in("모집중", "모집마감", "진행중")).fetch();
		
		System.out.println("검색결과 수 : "+gatherList.size());
	
		for (Gather gather : gatherList) {
			System.out.println(gather.getGatherNo());
			
			LocalDateTime grd = gather.getGatherDate();
			LocalDateTime completeDate = grd.plusHours(gather.getGatherTime());
			
			int i = participantService.selectParticipantCountByGatherNo(gather.getGatherNo());
			
			//System.out.println("결과 = " + ldt.isEqual(gather.getGatherDeadline()));
			//System.out.println("i = " + i +" / " + "최소인원: " + gather.getGatherMinUsers());
			if (ldt.isEqual(gather.getGatherDeadline())) {
				if ( i < gather.getGatherMinUsers() ) {
					gather.setGatherState("모임취소");
					autoUpdateParticipantState(gather.getGatherNo(), "인원미달", "참가승인");
					List<Users> usersList = gatherStateAlarmList("참가승인",gather.getGatherNo());
					
		
					
					if(gather.getRegularGather().getRegularGatherState().equals("진행중")) {
						//다음 날짜를 계산
						LocalDateTime newGatherDate = gather.getGatherDate().plusDays(gather.getRegularGather().getRegularGatherCycle()*7);
						//다음 마감시간을 계산
						LocalDateTime newDeadline = newGatherDate.minusHours(3);
						//새로운 모임을 insert
						Gather newGather = new Gather(0L, gather.getCategory(), gather.getUser(), gather.getRegularGather()
								, gather.getGatherName(), gather.getGatherMinUsers(), gather.getGatherMaxUsers(), gather.getGatherSelectGender()
								, gather.getGatherMinAge(), gather.getGatherMaxAge(), newGatherDate, newDeadline, gather.getGatherTime(), gather.getGatherPlace()
								, gather.getGatherPlaceDetail(), gather.getGatherComment(), "모집중", null, gather.getGatherBid(), gather.getGatherImg(), gather.getLikeCount());
						gatherRep.save(newGather);
					}
				} else {
					gather.setGatherState("모집마감");
					autoUpdateParticipantState(gather.getGatherNo(), "참가확정", "참가승인");
				}
			} else if (ldt.isEqual(gather.getGatherDate())) {
				gather.setGatherState("진행중");
				autoUpdateParticipantState(gather.getGatherNo(), "참가중", "참가확정");
			} else if (ldt.isEqual(completeDate)) {
				gather.setGatherState("진행완료");
				autoUpdateParticipantState(gather.getGatherNo(), "참가완료", "참가중");
				if(gather.getRegularGather().getRegularGatherState().equals("진행중")) {
					//다음 날짜를 계산
					LocalDateTime newGatherDate = gather.getGatherDate().plusDays(gather.getRegularGather().getRegularGatherCycle()*7);
					//다음 마감시간을 계산
					LocalDateTime newDeadline = newGatherDate.minusHours(3);
					//새로운 모임을 insert
					Gather newGather = new Gather(0L, gather.getCategory(), gather.getUser(), gather.getRegularGather()
							, gather.getGatherName(), gather.getGatherMinUsers(), gather.getGatherMaxUsers(), gather.getGatherSelectGender()
							, gather.getGatherMinAge(), gather.getGatherMaxAge(), newGatherDate, newDeadline, gather.getGatherTime(), gather.getGatherPlace()
							, gather.getGatherPlaceDetail(), gather.getGatherComment(), "모집중", null, gather.getGatherBid(), gather.getGatherImg(), gather.getLikeCount());
					gatherRep.save(newGather);
				}
			}
		} // for문

	}
	
	private List<Users> gatherStateAlarmList(String state, Long gatherNo){
		List<Users> userList = queryFactory.select(p.user)
				.from(p)
				.where(p.applicationState.eq(state)
						.and(p.gather.gatherNo.eq(gatherNo)))
				.fetch();
		return userList;
	}
	
	
	@Override
	public void autoUpdateParticipantState(Long gatherNo, String state, String dbState) {
		//System.out.println("참가자 상태 업데이트 호출되니?" +state);
		queryFactory.update(p)
		.set(p.applicationState, state)
		.where(p.gather.gatherNo.eq(gatherNo)
				.and(p.applicationState.eq(dbState)))
		.execute();
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

		Page<Gather> result = gatherRep.selectBidGatherappliList(pageable);

		//return new PageImpl<Gather>(result, pageable, result.size());
		return result;
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
	public Page<Gather> selectByReviewState(Long userNo, boolean state, Pageable pageable) {
		BooleanBuilder builder = new BooleanBuilder();
		
		builder.and(p.user.userNo.eq(userNo));
		builder.and(p.applicationState.eq("참가확정"));
		if(state) {//true이면 후기를 남긴 Gather를 리턴한다.
			builder.and(ur.writerUser.userNo.isNotNull());
		}else {//false이면 후기를 안남긴 Gather를 리턴한다.
			builder.and(ur.writerUser.userNo.isNull());
		}
		
		List<Gather> result = queryFactory.select(p.gather)
				.from(p).leftJoin(ur).on(p.user.userNo.eq(ur.writerUser.userNo))
				.where(builder).fetch();
		
		return new PageImpl<Gather>(result, pageable, result.size());
	}

}
