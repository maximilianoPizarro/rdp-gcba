package com.rdp.springmvc.configuration;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.format.FormatterRegistry;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


import com.rdp.springmvc.converter.AreaToHostAreaConverter;
import com.rdp.springmvc.converter.RoleToUserProfileConverter;
import com.rdp.springmvc.service.HelloJob;


@Configuration
@EnableScheduling   //esto para las tareas cron
@Import(JpaConfiguration.class)
@EnableWebMvc
@ComponentScan(basePackages = "com.rdp.springmvc")
public class AppConfig extends WebMvcConfigurerAdapter{
	
	
	@Autowired
	RoleToUserProfileConverter roleToUserProfileConverter;
	
	@Autowired
	AreaToHostAreaConverter areaToHostAreaConverter;

	/**
     * Configure ViewResolvers to deliver preferred views.
     */
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {

		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		registry.viewResolver(viewResolver);
		
	}
	
	/**
     * Configure ResourceHandlers to serve static resources like CSS/ Javascript etc...
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
    }
    
    /**
     * Configure Converter to be used.
     * In our example, we need a converter to convert string values[Roles] to UserProfiles in newUser.jsp
     */
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(roleToUserProfileConverter);
        registry.addConverter(areaToHostAreaConverter);
    }
	

    /**
     * Configure MessageSource to lookup any validation/error message in internationalized property files
     */
    @Bean
	public MessageSource messageSource() {
	    ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
	    messageSource.setBasename("messages");
	    return messageSource;
	}
    
    /**Optional. It's only required when handling '.' in @PathVariables which otherwise ignore everything after last '.' in @PathVaidables argument.
     * It's a known bug in Spring [https://jira.spring.io/browse/SPR-6164], still present in Spring 4.3.0.
     * This is a workaround for this issue.
     */
    
    @Override
    public void configurePathMatch(PathMatchConfigurer matcher) {
        matcher.setUseRegisteredSuffixPatternMatch(true);
    }
    
   //run every morning at 6 AM
 
    @Scheduled(cron = "0 0 6 * * MON-FRI")
     public void scheduleFixedDelayTask() {
  		HelloJob a= new HelloJob();
  		a.execute();
  		
      }    
    
    
    
 //   @Scheduled(cron = "*/10 * * * * *")
  /*  public void scheduleFixedDelayTask() {
		HelloJob a= new HelloJob();
		a.execute();
		
    }
*/
//  "0 0 * * * *" = the top of every hour of every day.
//  "*\/10 * * * * *" = every ten seconds.
//  "0 0 8-10 * * *" = 8, 9 and 10 o'clock of every day.
//  "0 0 6,19 * * *" = 6:00 AM and 7:00 PM every day.
//  "0 0/30 8-10 * * *" = 8:00, 8:30, 9:00, 9:30, 10:00 and 10:30 every day.
//  "0 0 9-17 * * MON-FRI" = on the hour nine-to-five weekdays
//  "0 0 0 25 12 ?" = every Christmas Day at midnight 
    /* 
     * segundos,minutos,horas,dia del mes, mes, dias del mes
     * ? todos los dias
     * MON-FRI lunes y viernes
     */

//second, minute, hour, day of month, month, day(s) of week
    
    
}

