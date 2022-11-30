package modakbul.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
public class TilesConfiguration {
	/**
	 * Tiles 등록
	 * */
	@Bean
	public UrlBasedViewResolver viewResolver() {
		UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
		viewResolver.setOrder(1);
		viewResolver.setViewClass(TilesView.class);
		
		System.out.println("TilesConfiguration의 viewResolver() call....");
		
		return viewResolver;
	}
	
	@Bean
	public TilesConfigurer getTilesConfigurer() {
		TilesConfigurer config = new TilesConfigurer();
		
		config.setDefinitions(new String[] {"/WEB-INF/tiles/tiles.xml"});
		System.out.println("TilesConfigurer의 getTilesConfigurer() call....");
		return config;
	}
}
