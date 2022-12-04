package modakbul.mvc.service;

import java.io.IOException;
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

		String encodedPassword = passwordEncoder.encode(user.getUserpwd());

		user.setUserpwd(encodedPassword);
		
		if(user.getUserGender()!=null) {
			usersRep.save(
					Users.builder()
					.userId(user.getUserId())
					.userpwd(encodedPassword)
					.userName(user.getUserName())
					.userNick(user.getUserNick())
					.userEmail(user.getUserEmail())
					.userValidateNo(user.getUserValidateNo())
					.userPhone(user.getUserPhone())
					.userPostCode(user.getUserPostCode())
					.userAddr(user.getUserAddr())
					.userAddrDetail(user.getUserAddrDetail())
					.state(Role.ROLE_USER)
					.userJob("개인")
					.userGender(user.getUserGender())
					.build());
			
		}else {
			usersRep.save(
					Users.builder()
					.userId(user.getUserId())
					.userpwd(encodedPassword)
					.userName(user.getUserName())
					.userNick(user.getUserNick())
					.userEmail(user.getUserEmail())
					.userValidateNo(user.getUserValidateNo())
					.userPhone(user.getUserPhone())
					.userPostCode(user.getUserPostCode())
					.userAddr(user.getUserAddr())
					.userAddrDetail(user.getUserAddrDetail())
					.state(Role.ROLE_USER)
					.userJob("기관")
					.build());
		}
		
	}

	@Override
	public String emailCheck(String userEmail) throws Exception {
		String userId = usersRep.selectUserId(userEmail);
		
		if(userId != null) throw new RuntimeException("이미 가입되어있는 유저아이디입니다.");

		return mailSender.sendSimpleMessage(userEmail, "join");

	}

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
	@org.springframework.transaction.annotation.Transactional(readOnly = false)
	public Users update(Users user) {
		Users dbUser = usersRep.selectById(user.getUserId());

		if (dbUser == null)
			throw new RuntimeException("해당 아이디에 대한 오류로 수정할 수 없습니다.");

		if (user.getUserpwd() != null) {

			String encodedPassword = passwordEncoder.encode(user.getUserpwd());

			user.setUserpwd(encodedPassword);
		}

		
		  dbUser.setUserPhone(user.getUserPhone());
		  dbUser.setUserPostCode(user.getUserPostCode());
		  dbUser.setUserAddr(user.getUserAddr());
		  dbUser.setUserAddrDetail(user.getUserAddrDetail());
		  dbUser.setUserProfileImg(user.getUserProfileImg());
		 
		em.merge(user);

		return dbUser;
	}

	@Override
	public void delete(Users user) {

		usersRep.deleteById(user.getUserNo());

	}

	@Override
	public String selectUserId(String userEmail) {
		String dbUserId = usersRep.selectUserId(userEmail);
		if (dbUserId == null)
			throw new RuntimeException("해당 이메일의 정보가 존재하지 않습니다.");
		return dbUserId;

	}

	@Override
	public void selectUserPwd(String userId, String userEmail) throws Exception{

		Users user = usersRep.selectById(userId);
		if (!user.getUserEmail().equals(userEmail))
			throw new RuntimeException("해당 정보에 맞는 회원이 없습니다.");
		
		String ePw = mailSender.sendSimpleMessage(userEmail, "find");
		
		String encodedPassword = passwordEncoder.encode(ePw);
		user.setUserpwd(encodedPassword);

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
	public String kakaoLogin(String token) throws ParseException {
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
		
		String str = response.getBody();
		JSONObject kakao_response = parseJSON(str);
		JSONObject kakao_account = (JSONObject) kakao_response.get("kakao_account");
		JSONObject profile = (JSONObject) kakao_account.get("profile");
		String userEmail = (String) kakao_account.get("email");
		String userNick = (String) profile.get("nickname");
		String id = usersRep.selectUserId(userEmail);
		Users user = usersRep.selectById(id);
		System.out.println(id);

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
	
		
		
		return id;
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
			//ObjectMapper objectMapper = new ObjectMapper();
			//KakaoOAuthToken oauthTokenKakao = objectMapper.readValue(response.getBody(), KakaoOAuthToken.class);
			//System.out.println("토큰 = " + oauthTokenKakao);
			//return oauthTokenKakao;
		
		
		
		/*String kakaoURL = "https://kauth.kakao.com/oauth";
		String access_token = "";
		String refresh_token = "";
		try {
			URL url = new URL(kakaoURL);
			HttpURLConnection connection = (HttpURLConnection)url.openConnection();
			connection.setRequestMethod("GET");
			connection.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&clinet_id="+KAKAO_REST_API_KEY);
			sb.append("&redirect_uri=http://localhost:9000/auth/kakao/callback");
			sb.append("&code="+code);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = connection.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		
			String line = "";
			
			String result = "";
			
			while( (line = br.readLine()) != null) {
				result += line;
			}
			
		
			System.out.println("response body = " + result);
			
			JSONObject object = parseJSON(result);
			
			access_token = (String) object.get("access_token");
			refresh_token = (String) object.get("refresh_token");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return access_token;*/
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

}
