package modakbul.mvc.config;

import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.BeanNameViewResolver;

import com.querydsl.jpa.impl.JPAQueryFactory;

@Configuration
public class AppConfig {
	
	@PersistenceContext //선언하면 EntityManager 들어옴
	EntityManager em;
	
	/**
	 * ㅇㅖ외처리 
	 * */
	@Bean
	public SimpleMappingExceptionResolver getSimpleMappingExceptionResolver() {
		SimpleMappingExceptionResolver resolver= new SimpleMappingExceptionResolver();
		Properties pro= new Properties();
		pro.put("Exception", "error/errorView");
		resolver.setExceptionMappings(pro);
		return resolver;
	}
	/**
	 * JPAQueryFactory등록 = 생성
	 * : querydsl 사용할 때 다양 한 쿼리를 직접 할 수 있도록 관련 메소드 제공
	 * : 기존의 ~.findAll(Predicate pre)-select전용이기 때문에 조건만 BooleandBuilder를
	 * 만들었지만 delete,update, insert d서브쿼리 복잡한 쿼리를 이런 다양한 쿼리히는 
	 * JPAQueryFactory사용 
	 * */
	@Bean
	public JPAQueryFactory queryFactory() {
		return new  JPAQueryFactory(em);
	}
}
