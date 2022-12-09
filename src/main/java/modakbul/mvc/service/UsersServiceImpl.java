package modakbul.mvc.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.DefaultResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import modakbul.mvc.domain.KakaoOAuthToken;
import modakbul.mvc.domain.QUsers;
import modakbul.mvc.domain.QUsers;
import modakbul.mvc.domain.Role;
import modakbul.mvc.domain.Users;
import modakbul.mvc.repository.UsersRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class UsersServiceImpl implements UsersService {

	private final UsersRepository usersRep;
	private final EntityManager em;
	private final MailSendService mailSender;
	private final JPAQueryFactory queryFactory;
	
	//@Value("${apikey.kakao.rest.api.key")
	//private String KAKAO_REST_API_KEY="14b0e31baeb3e5bc554c607d7293b85c";

	@Autowired
	private PasswordEncoder passwordEncoder;
	// private final MailTest mail;
	@Autowired
	private AuthenticationManager authenticationManager;
	
	private final static int PAGE_COUNT = 5;
	private final static int BLOCK_COUNT=4;
	

	@Override
	public void insert(Users user) {
		System.out.println("insert하자!");

		String encodedPassword = passwordEncoder.encode(user.getUserpwd());

		user.setUserpwd(encodedPassword);
		
		usersRep.save(user);
		
	}

	@Override
	public String sendCode(String userEmail) throws Exception {
		String userId = usersRep.selectUserId(userEmail);
		
		if(userId != null) {
			return "이미 가입되어있는 email입니다.";
			//throw new RuntimeException("이미 가입되어있는 유저아이디입니다.");
		}

		return mailSender.sendSimpleMessage(userEmail, "join");

	}
	
	/*
	 * @Override public String checkCode(String code) throws Exception {
	 * 
	 * return null; }
	 */

	@Override
	public Page<Users> selectAll(Pageable pageable, String job) {
		QUsers users = QUsers.users;
		
		int nowPage=4;
		pageable = PageRequest.of(nowPage-1, PAGE_COUNT, Direction.DESC, "userNo");
		
		//Page<Users> list = usersRep.findAll(page);
		
		//int temp = (nowPage-1)%BLOCK_COUNT;
		
		//int startPage = nowPage-temp;
		
		BooleanBuilder builder = new BooleanBuilder();
		if(job != null) {
			builder.and(users.userJob.eq(job));
		}
		
		List<Users> list = queryFactory
				.select(users)
				.from(users)
				.where(builder)
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetch();

		//return usersRep.findAll(pageable); 
		//findall
		return new PageImpl<Users>(list, pageable, list.size());
		//return null;
	}

	

	@Override
	public Users selectById(String userId) {

		return usersRep.selectById(userId);
	}

	@Override
	public boolean nickCheck(String userNick) {
		Users user = usersRep.nickCheck(userNick);

		if (user == null)
			return true;

		return false;
	}

	@Override
	@org.springframework.transaction.annotation.Transactional
	public void update(Users user) {
		System.out.println("update하자!");
		Users dbU = usersRep.findById(user.getUserNo()).orElse(null);
		
		System.out.println("userpwd =" + user.getUserpwd() );
		if(user.getUserpwd().length() > 0) {
			System.out.println("여기에 갓니 ?");
			String encodedPassword = passwordEncoder.encode(user.getUserpwd());
			user.setUserpwd(encodedPassword);
			dbU.setUserpwd(user.getUserpwd());
		}

		
		dbU.setUserPostCode(user.getUserPostCode());
		dbU.setUserAddr(user.getUserAddr());
		dbU.setUserAddrDetail(user.getUserAddrDetail());

	}

	@Override
	public void delete(Users user) {

		usersRep.deleteById(user.getUserNo());

	}

	@Override
	public String selectUserId(String userEmail) {
		String dbUserId = usersRep.selectUserId(userEmail);
		//if (dbUserId == null)
			//throw new RuntimeException("해당 이메일의 정보가 존재하지 않습니다.");
		return dbUserId;

	}

	@Override
	public boolean selectUserPwd(String userId, String userEmail) throws Exception{
		System.out.println("시작 = " + userId);
	
		if (usersRep.selectById(userId)==null) {
			System.out.println("1번");
			return false;
		}else {
			Users user = usersRep.selectById(userId);
			System.out.println("user = " + user.getUserEmail());
			System.out.println("2번");
			String ePw = mailSender.sendSimpleMessage(userEmail, "find");
			
			String encodedPassword = passwordEncoder.encode(ePw);
			user.setUserpwd(encodedPassword);

			
			return true;
		}
		
	}

	@Override
	public Users updateTemper(Long userNo, double temper) {
		// (평균매너온도 * 온도카운트 + 새로운 매너온도)/( 온도카운트+1)

		Users dbUser = usersRep.findById(userNo).orElse(null);
		double dbTemper = dbUser.getTemper() * dbUser.getTemperCount();

		dbUser.setTemperCount(dbUser.getTemperCount() + 1);

		double newTemper = (Math.round(((dbTemper + temper) / dbUser.getTemperCount()) * 10)) / 10.0;

		dbUser.setTemper(newTemper);

		return dbUser;
	}

	@Override
	public HashMap<String, Object> kakaoLogin(String token) throws ParseException {
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + token);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		
		RestTemplate rt = new RestTemplate();
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers);
		rt.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
		rt.setErrorHandler(new DefaultResponseErrorHandler(){
			
			public boolean hassError(ClientHttpResponse response) throws IOException{
				HttpStatus statusCode = response.getStatusCode();
				return statusCode.series() == HttpStatus.Series.SERVER_ERROR;
			}
		});
		
		ResponseEntity<String> response = rt.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest,
				String.class
				
		);
		
		/*KakaoProfile kp = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoProfileRequest, KakaoProfile.class).getBody();
		String email = kp.kakao_account.getEmail();
		System.out.println("여기즘이니 ?"+email);
		String id = usersRep.selectUserId(email);
		Users user = usersRep.selectById(id);*/
		String str = response.getBody();
		JSONObject kakao_response = parseJSON(str);
		JSONObject kakao_account = (JSONObject) kakao_response.get("kakao_account");
		JSONObject profile = (JSONObject) kakao_account.get("profile");
		JSONObject properties = (JSONObject) kakao_response.get("properties");
		
		String userEmail = (String) kakao_account.get("email");
		String userNick = (String) profile.get("nickname");
		String id = usersRep.selectUserId(userEmail);
		String profileImage = (String) properties.get("profile_image");
		String gender = (String) kakao_account.get("gender");
		
		Users user = usersRep.selectById(id);
		
		//profile.setEmail(userEmail);
	
		
		System.out.println(userEmail);
		
		userInfo.put("userNick", userNick);
        userInfo.put("profileImage", profileImage);
        userInfo.put("userEmail", userEmail);
        userInfo.put("id", id);
        userInfo.put("gender", gender);


		//Users newUser = Users.builder().userEmail(userEmail).userNick(userNick).build();		
		/*if(id==null) {

			 usersRep.save(
						Users.builder()
						.userId(userEmail)
						.userpwd("3323")
						.userName(userNick)
						.userNick(userNick)
						.userGender("여자")
						.userEmail(userEmail)
						.userValidateNo("32333")
						.userPhone("122231")
						.userPostCode("1231")
						.userAddr("경기도 성남시 분당구")
						.userAddrDetail("알파리움")
						.userJob("개인")
						.state(Role.ROLE_USER)
						.build()
						
						);

		}*/
		
			if(id!=null) {
				
				String pwd = user.getUserpwd();
				String encodedPassword = passwordEncoder.encode(pwd);
				Authentication kakaoUsernamePassword = new UsernamePasswordAuthenticationToken(id, pwd);
				Authentication authentication = authenticationManager.authenticate(kakaoUsernamePassword);
				SecurityContextHolder.getContext().setAuthentication(authentication);
			}
	
		
		
		return userInfo;
	}

	@Override
	public KakaoOAuthToken getAccessToken(String code) {
		System.out.println("못가니 ?");
		
		String access_token = "";
		String refresh_token = "";
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
			
			params.add("grant_type", "authorization_code");
			params.add("client_id", "14b0e31baeb3e5bc554c607d7293b85c");
			params.add("redirect_uri", "http://localhost:9000/auth/kakao/callback");
			params.add("code", code);
			System.out.println("params = " + params);
			HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
			
			
			ResponseEntity<String> response = restTemplate.exchange(
					
					"https://kauth.kakao.com/oauth/token",
					HttpMethod.POST,
					kakaoTokenRequest,
					String.class
					
					
					);
			System.out.println("response = " + response);
			System.out.println("response body =" + response.getBody());
			ObjectMapper mapper = new ObjectMapper();
			KakaoOAuthToken token = mapper.readValue(response.getBody(), KakaoOAuthToken.class);
			
			System.out.println(token.getAccess_token());
			
			return token;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
			
	private JSONObject parseJSON(String response) throws ParseException {
		
			System.out.println("여기로는 오나 ?");
			JSONParser jsonParser = new JSONParser();
			System.out.println(jsonParser);
			
		
			
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response);
			System.out.println("jsonObject = " + jsonObject);
			
			return jsonObject;


	}

	@Override
	public List<Users> selectByKeyword(String keyword) {
		
		//return usersRep.selectByKeyword(keyword);
		return null;
	}

	@Override
	public Users selectById(Long userNo) {
		
		return usersRep.findById(userNo).orElse(null);
	}
	

}
